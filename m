From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Wed, 20 Oct 2010 19:35:16 +0530
Message-ID: <20101020140511.GA13315@kytes>
References: <20101018051702.GD22376@kytes>
 <8043579.526738.1287452576766.JavaMail.root@mail.hq.genarts.com>
 <20101019064210.GA14309@kytes>
 <1287563970.2673.12.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Bash <bash@genarts.com>, Matt Stump <mstump@goatyak.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 16:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ZJ2-0006uX-AS
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 16:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab0JTOGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 10:06:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42300 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0JTOGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 10:06:08 -0400
Received: by gwj23 with SMTP id 23so42477gwj.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OGR4FT1bvAbelqpg5NJOtk2aNNukOXEWEr/0En8wRpE=;
        b=ZcRCzDVaPeOUllblZFkGFEvIGFPxodl3hOyebLLB6lKQ6Y9al5sS7YUx5kFXhxLssF
         +f/9EMxCXX0ws42wYBVfbmsGMxvm1CXok+LJYl2x+VbhGAYrtdULWUKw67oAsN+A/52U
         +BJYWYgX+LAJUvQD8tPyVArslFZHz3hO1ssWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xMbnWNdjOsOOptSl5CJ7bOA0ZDzuurpGA6nuM/BbVWQo60N+XseyBdfe2g/tsEADB0
         M+aBbmhT3Wz8ysdgOA/3LU0rgNFD/GM27B5XYgF9mv7sqjIN1hm7fzRL0FyTiLxl7AMH
         UCj2IwaqHFAcTyMqr7NAzsDYTmDmohfl43o4Q=
Received: by 10.100.13.9 with SMTP id 9mr5425628anm.234.1287583566153;
        Wed, 20 Oct 2010 07:06:06 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id w15sm278926anw.13.2010.10.20.07.05.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 07:06:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287563970.2673.12.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159411>

Hi Will,

Will Palmer writes:
> It's been a while since I was involved in this discussion, so maybe the
> design has changed by now,

Yep, and I'm to blame for that- sorry I didn't CC you earlier. I got
confused between "Tomas Carnecky" and "Will Palmer". To avoid this
confusion in future, I'd request everyone to display the names they
use on the list in the IRC whois information (unless it's a privacy
issue).

> but I was under the impression that there
> would be one "one-to-one" mapping branch (which would never be checked
> out), containing the history of /, and that the "real" git branches,
> tags, etc, would be based on the trees originally referenced by the root
> checkout, with git-notes (or similar) being used to track the weirdness
> in mappings. How does the "multiple branches touched in a single commit"
> complicate anything other than the heuristics for automatic branch
> detection (which I assume nobody is at the stage of talking about yet).

Yeah, that was my plan too originally, but I clearly haven't thought
about it enough. I'm currently noting down the various scenarios that
the others are quoting -- there are quite a few I hadn't thought about
earlier.

[...]

-- Ram
