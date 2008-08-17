From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Sun, 17 Aug 2008 22:49:05 +0200
Message-ID: <48A88EC1.5020503@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200808140457.56464.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:50:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpCZ-0004LE-5o
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYHQUtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYHQUtM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:49:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:29112 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYHQUtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:49:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489732fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=e6xQ1SX3sFg6pJFdbO+yoJM0iSXOCR7GyVSx0yEyEOg=;
        b=Xp0S3lbCtwhzIB0E9Yp1Yz5C+fPE4mKti2w1JaCKDzVxrHqKLp/FRIECgkdiCDxnr8
         jsWh3Nl7mvfSf6Bo7htHS4sQxPxKwHcrZrcrpXHt8aW7MdERGgQcWeRcBMvUx43FElqK
         XQaWtXSeNUarhijlpBXQHg8bVMoH9WlOJmhqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZMipr5vnd7REzxrvvdrZyaNr5U/vZaLvBPmAgt3Nbil9sVfYZNOcUQ+ZKoAJYxCYKT
         DWxJ4XgdWR779VcHnSOKAq5pMPtxHv4UB8sx1ud/Li96OnpFWOWp3fXQ6WU5vLofQqQR
         fg0pZ3EhTBu/+3SMBkTIe+bAOf0L1rd/nkTh0=
Received: by 10.86.23.17 with SMTP id 17mr4004331fgw.44.1219006149450;
        Sun, 17 Aug 2008 13:49:09 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id l19sm10374094fgb.7.2008.08.17.13.49.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:49:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <200808140457.56464.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92663>

Jakub Narebski wrote:
> Now that according to Google Summer of Code 2008 timeline
>   http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
> we are in the middle of the suggested 'pencils down' date (August 11 --
> -- August 18), I and perhaps other on git mailing list would like
> to know what is the current status of all git GSoC 2008 projects.
> I think that writing it down would help GSoC manager and co-manager...
(...)
> 4. Eclipse plugin push support
>  
> Student: Marek Zawirski
> Mentor: Shawn O. Pearce
> 
> JGit can now create (suboptimal) packs: it can reuse delta, but cannot 
> currently create one.  This is used to implement push support in 
> jgit/egit.
> 
> Status: Done, merged in, and used as example to add for example Amazon's 
> S3 support and SFTP transport support.

I'm just putting in the background patches with my 2nd big task for 
GSoC: (mostly) GUI for push. This code uses prior work - the one 
described by Jakub.

It took me a long time to do it, I was expecting some more time for 
other things, but it was probably better to focus on 1 thing at time. I 
think that we can say now that it's usable: it's possible to push from 
Eclipse in some (hopefully) sensible way.

Basing on created components, we can also add fetch GUI or remotes 
configuration editor easier than before.

> Student retention: I don't know, but I guess it is likely.

Nice guess! ;) That's quite true. I'm sure that I will no longer have 
that much time for coding jgit or egit, but when possible, I'll try to 
contribute in some way. Now, I'm starting to work on fetch GUI.

Having this opportunity, I want to say: thank you Shawn for being that 
great mentor! :) And thanks to other folks for given help. I've learned 
some new things here and it was (is?) nice experience to code for egit.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
