From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: remote#branch
Date: Thu, 1 Nov 2007 01:22:33 +0100
Message-ID: <200711010122.34190.jnareb@gmail.com>
References: <20071030053732.GA16963@hermes.priv> <472844D4.8050306@op5.se> <20071031091529.GA25025@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 01:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InNnU-0003LW-Vb
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 01:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbXKAAUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 20:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbXKAAUN
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 20:20:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:30201 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbXKAAUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 20:20:11 -0400
Received: by ug-out-1314.google.com with SMTP id z38so406975ugc
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=FuBdI0o7MCk+WmwZ9D5gIJR5L3u1O70NGJhWK41KPDs=;
        b=rJPbCgRG+ccwwTl302GCTgDMdZviJDkFdjR/L/S9C2bK3SWvOQAZtrzNu//oq/Lj0ZrebT589CubLoYjRq2hBAMN2YRPQvdb/nGIj+7kmvs8CM0ytNUYMWWdPmn5uMxG7pitcUsHUpJ+dFDsnwad3G1pfCHFXESaDk+uyIFBml4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QD7ozzN7Q71fSe+Hlwyp87JgJbyduuKNbbT0iC9VIZBShQmAJp/Uxt0MaP65L48KxcfRid2uySJFad8oUmNk7NycepYcclKqrgKKhGxLo56FnbtL3I0/61MAnYSNTd+VkR3Vx2BlnPjja1cGyzv1qgWdzHRZyiJejlrgiCCRPO0=
Received: by 10.67.27.16 with SMTP id e16mr1511478ugj.1193876410303;
        Wed, 31 Oct 2007 17:20:10 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.199.125])
        by mx.google.com with ESMTPS id i7sm2583732nfh.2007.10.31.17.20.07
        (version=SSLv3 cipher=OTHER);
        Wed, 31 Oct 2007 17:20:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20071031091529.GA25025@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62899>

Mike Hommey wrote:
> On Wed, Oct 31, 2007 at 10:03:16AM +0100, Andreas Ericsson <ae@op5.se> wrote:
>>>
>>>Or copied from gitweb.
>>>
>> Perhaps, but I've never seen that done. Partly because you can't be sure
>> the HTTP url is the same as the git address (perhaps people are used to
>> this from CVS and the likes), and partly because you'd, for most cases,
>> want to use git:// or ssh transport instead of http.
>> 
>> It might be nifty to have gitweb print some git-valid locator for a repo
>> though, or even a full copy-pastable "git clone git://host/path/to/repo.git"
>> command-line thingie. I'll look into it when I have leisure.
> 
> Hum... it already does print http and git "Mirror URL"s which are ready to
> be copy/pasted to feed git clone arguments.

The only thing to add (for absolutely no gain IMHO) would be code
which would add quotes (single or double) around URL/path which
contain spaces:
  
  Mirror URL    'git://repo.or.cz/repo with spaces.git'
                'http://repo.or.cz/r/repo with spaces.git'
  Push URL      'repo.or.cz:/srv/git/repo with spaces.git'  

-- 
Jakub Narebski
Poland
