From: Niels Basjes <niels@basjes.nl>
Subject: Re: [PATCH] Two RPM building improvements
Date: Fri, 27 Mar 2009 17:07:25 +0100 (CET)
Message-ID: <18535782.631238170045741.JavaMail.root@webmail.basjes.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 17:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnElA-0002bX-Tq
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbZC0QQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 12:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbZC0QQt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 12:16:49 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:1471 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbZC0QQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 12:16:48 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2009 12:16:48 EDT
Received: from webmail.basjes.nl (nicoenans.demon.nl [83.160.8.251])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id n2RG7VfB091843
	for <git@vger.kernel.org>; Fri, 27 Mar 2009 17:07:32 +0100 (CET)
	(envelope-from niels@basjes.nl)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail.basjes.nl (Postfix) with ESMTP id 24BC9A693A
	for <git@vger.kernel.org>; Fri, 27 Mar 2009 17:07:31 +0100 (CET)
Received: from webmail.basjes.nl ([127.0.0.1])
 by localhost (webmail.basjes.nl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13695-08 for <git@vger.kernel.org>;
 Fri, 27 Mar 2009 17:07:30 +0100 (CET)
Received: from webmail.basjes.nl (webmail.basjes.nl [172.19.3.101])
	by webmail.basjes.nl (Postfix) with ESMTP id 70CEDA6939
	for <git@vger.kernel.org>; Fri, 27 Mar 2009 17:07:27 +0100 (CET)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114907>

Hi Jakub,

----- Jakub Narebski <jnareb@gmail.com> wrote:
> Niels Basjes <Niels@Basjes.nl> writes:
> 
> > Two RPM building improvements:
> Two _unrelated_ RPM building improvements squashed in one commit.

Hmm, well, ok. You're right.

> >   - Building the RPMs can now be done by a non-root user.
> 
> It was always possible, you only have to configure rpm / rpmbuild,
> namely put path to where you want your RPM_BUILDING directory in
> ~/.rpmmacros as %_topdir, for example:
> 
>   $ cat ~/.rpmmacros
>   %_topdir        /home/local/builddir

Yes, you're right. It has always been possible.
That works fine if you want all RPMS of multiple project to be thrown 
in one heap and have to spent time figuring out which rpms were built by 
which project.
I've always preferred forcing the rpmbuilding to be done in a subdirectory 
of the current source checkout. That way I can easily remove all old stuff 
of _this_ project (simply remove the entire subdirectory) and easily know 
what has been created by this project.

> Please RTFM first, 

I read the RTFM (really I did).

> before going to solve non-problem in (ugh) fairly complicated way.

What makes this complicated? 
It's only different from what you're used to.

> >   - The additional target all-rpms now builds the RPMs for a
> > multitude of target platforms.
> 
> Please wrap commit messages at 72-76 columns, at most at 80 columns.
> No such overly long lines, please.

Ok.

> But the all-rpms target looks like a good idea

Ok, discard this patch. I'll submit new (splitout) patches.

-- 
Met vriendelijke groeten,

Niels Basjes

ir. drs. Niels Basjes  -  http://niels.basj.es/  -  VCV 20000302
mailto:`echo 'Niels Basjes'|sed 's/\(.*\)\(..\)/\1.\2/g;s/ /@/g'`
