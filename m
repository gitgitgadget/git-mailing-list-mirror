From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 13:25:30 -0500
Message-ID: <20101018182530.GC6877@burratino>
References: <20101018051702.GD22376@kytes>
 <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes>
 <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino>
 <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
 <20101018172810.GA6877@burratino>
 <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
 <20101018181336.GB6877@burratino>
 <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:31:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7uUn-0000Iu-93
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab0JRSbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 14:31:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44111 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533Ab0JRSbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 14:31:34 -0400
Received: by vws2 with SMTP id 2so750325vws.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kdH3tkbz5tsGy5n6YgldLlwgOIjjAtZhGIK43+ZMG30=;
        b=iQuCnpvRIF3mF+T8SD31Ex0rcu3uvouZHGu0bNA6Xwr3XIMb0Ls8/ws9JF08eOYxTs
         VjywirkChWavb37ZKtSd6cGLAMOlo/aLamh35CDePvdLRGk1Mp2h3JLSiW8aDQlqpNQ5
         wm6dxkhEZRIurB4BsxzOaQVWONHRkkSogIkIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LCjPPV8hCdQkohcSLuEAmr7rBZSIcVScdIP46Upp5sm+OmqliHcpSfEFFn0nakYdpj
         vdeizDdb7l0g/QtXKCxZVnhlg7zWCcsiRLLImzK+QiQeazfXiJkL2xfeS8yTd79Kl0M4
         JEydZNv4ZmOVnenJzLCnHYuc1fOtsaeHmkzK8=
Received: by 10.103.241.18 with SMTP id t18mr1806303mur.36.1287426548593;
        Mon, 18 Oct 2010 11:29:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j14sm4404232faa.47.2010.10.18.11.29.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 11:29:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159278>

Sverre Rabbelier wrote:

> Does the replay API somehow indicate that a revision changed since
> last time you looked?

Good question.  Ram, I think there was some discussion of this
recently in connection with svnrdump, right?  IIRC the suggested
method was to use hooks or mine a commits@ mailing list. :(
