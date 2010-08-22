From: David Aguilar <davvid@gmail.com>
Subject: Re: git commands
Date: Sun, 22 Aug 2010 14:19:23 -0700
Message-ID: <20100822211921.GA27048@gmail.com>
References: <1282288658094-5443370.post@n2.nabble.com>
 <5F6739C3-B537-4694-BC63-F3F74962A47C@gmail.com>
 <vpq39u97m3l.fsf@bauges.imag.fr>
 <1282294163263-5443609.post@n2.nabble.com>
 <AANLkTimRpwLZHve_cAY0JxLGKC4202i-V_Soq=m1_JsY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sandy2010 <sandeeptt@yahoo.com>, git@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 23:12:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnHq4-0000x4-Ew
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab0HVVMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 17:12:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36026 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab0HVVMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 17:12:18 -0400
Received: by pvg2 with SMTP id 2so2034773pvg.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pXWALGcgPY3yIY9t4+XOiNOA+XRGL/8gdHRTwgDOhsI=;
        b=ayf0wWe7klJGN6kmttHHkcuTCf2mbGpB3YTdFk0p6jYK6hc8Hwrppt7LI9sRr+mwAq
         avFDugj4IUrhgzmz76Hukxq81fshcAP2LtJzOBWVE04a5ww9UXiab1VnF/9myil2e9BI
         Pi2q8COwXGHrn9wdGZyy8480qXhBGez60MGl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UebGhPgkx8Biz39eLaUyF/oesR5vsGjKsYnI4GL75DKWclzNEO3Cp4UMjIQbgCSiOX
         zRjUm3AXxOOdlAvcf6wPdxs3RVeYeroPkCW7CqnrkzhH+7gGXLkNCNuzOHdf2TFjxMct
         rDkyf5y4qnMCq+jcpyeWyrPdH69956Yy+XAQw=
Received: by 10.142.132.15 with SMTP id f15mr3619920wfd.14.1282511538383;
        Sun, 22 Aug 2010 14:12:18 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d4sm7457404wfh.23.2010.08.22.14.12.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 14:12:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimRpwLZHve_cAY0JxLGKC4202i-V_Soq=m1_JsY@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154193>

On Sun, Aug 22, 2010 at 06:41:35PM +0800, Lin Mac wrote:
> Hi,
> 
> 2010/8/20 sandy2010 <sandeeptt@yahoo.com>:
> > Yeah.. Actually, we were using git-15.6 and the command we used was
> > 'git-clone'. Later, I upgraded to git-1.7.1 and I found that in the
> > installation directory, there was only 4 binaries including git. I was
> > wondering were are the rest commands like git-clone, etc? Hence, I asked
> > this question.
> I have the same question regarding the installation here. I'm trying
> to upgrade from v1.5.x to the newest. But found that there are only a
> few files installed. Where are the rest? Should I uninstall the old
> version before I install? And is there any issues for the newer
> version works in respository made by v1.5.x, like git-svn?
> 
> Best Regards,
> Mac Lin.

Uninstall the old one and install the new one.
All the same commands are there, they're just organized
nicer so that they don't have to necessarily live in your $PATH.

The old version provided commands like 'git-clone' in /usr/bin.
You cannot use them like that anymore.
These days we say 'git clone' (no dashes).

Here's a blurb from http://lkml.org/lkml/2008/8/17/174

GIT v1.6.0 Release Notes
========================
User visible changes
--------------------
With the default Makefile settings, most of the programs are now
installed outside your $PATH, except for "git", "gitk" and
some server side programs that need to be accessible for technical
reasons.  Invoking a git subcommand as "git-xyzzy" from the command
line has been deprecated since early 2006 (and officially announced in
1.5.4 release notes); use of them from your scripts after adding
output from "git --exec-path" to the $PATH is still supported in this
release, but users are again strongly encouraged to adjust their
scripts to use "git xyzzy" form, as we will stop installing
"git-xyzzy" hardlinks for built-in commands in later releases.

-- 

	David
