From: Stephen Hemminger <stephen.hemminger@vyatta.com>
Subject: Re: git svn perl issues
Date: Wed, 23 Mar 2011 14:45:35 -0700 (PDT)
Message-ID: <521251622.25680.1300916735091.JavaMail.root@tahiti.vyatta.com>
References: <AANLkTikowuFsXFwLL14oS0zzHh3RiHOrGTVHXgyy8dLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 22:45:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Vs7-00054j-EC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 22:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab1CWVph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 17:45:37 -0400
Received: from mail.vyatta.com ([76.74.103.46]:40545 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab1CWVpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 17:45:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 7FEF41828F55;
	Wed, 23 Mar 2011 14:45:35 -0700 (PDT)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amCMjhhNDe3v; Wed, 23 Mar 2011 14:45:35 -0700 (PDT)
Received: from mail.vyatta.com (mail.vyatta.com [76.74.103.46])
	by mail.vyatta.com (Postfix) with ESMTP id 45C381828F44;
	Wed, 23 Mar 2011 14:45:35 -0700 (PDT)
In-Reply-To: <AANLkTikowuFsXFwLL14oS0zzHh3RiHOrGTVHXgyy8dLw@mail.gmail.com>
X-Originating-IP: [10.250.0.101]
X-Mailer: Zimbra 6.0.6_GA_2330.RHEL5_64 (ZimbraWebClient - FF3.0 (Linux)/6.0.6_GA_2330.RHEL5_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169876>


> On 23 March 2011 16:52, Stephen Hemminger <shemminger@vyatta.com>
> wrote:
> > 1. The following needs to be fixed:
> >
> > $ git svn clone
> > Use of uninitialized value $_[0] in substitution (s///) at
> > /usr/share/perl/5.10.1/File/Basename.pm line 341.
> > fileparse(): need a valid pathname at /usr/lib/git-core/git-svn line
> > 403
> 
> While noisy and ugly, uninitialized warnings are usually pretty
> harmless...

User should never see perl splat, it is sloppy.

> > 2. The git-svn perl script does not follow Perl Best Practices.
> > If you run the perlcritic script on it, all the following
> > warnings/errors
> > are generated:
> 
> Some of these are undoubtedly valid complaints, but the so called best
> practices that the perl critic policies implement are, in my opinion,
> not widely accepted as such by the perl community. At least not all of
> them. I wouldn't go following them blindly - especially in working
> production code...

Some of them are crap, but like sparse warnings it is trivial to
fix them and make it clean so why not.

If you don't maintain code it just rots.
