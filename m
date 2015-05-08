From: Thomas Koch <thomas@koch.ro>
Subject: Re: Please consider extending .gitignore to support setting of a file size limit
Date: Fri, 8 May 2015 08:44:39 +0200
Message-ID: <201505080844.40002.thomas@koch.ro>
References: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com> <xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Roger Mendes <sproger1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 08:51:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqc8R-0007Xn-RC
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 08:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbbEHGvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 02:51:43 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34356 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbEHGvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 02:51:42 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2015 02:51:42 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id 2E672420D0;
	Fri,  8 May 2015 08:44:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id coyz9oUC3U_1; Fri,  8 May 2015 08:44:41 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/3.16.0-0.bpo.4-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268602>

On Thursday, May 07, 2015 11:31:12 PM Junio C Hamano wrote:
> Roger Mendes <sproger1@gmail.com> writes:
> > Allow .gitignore to support setting a file size limit so that all
> > files over a certain size will by automatically ignored when
> > performing git add, commit -a...;
> 
> No.

Please have a look into "git annex". It provides large file support without
blowing up the repository size entirely and has facilities to decide what to
do with files based on multiple criterias like file size.

Maybe some features from git annex have matured enough to be proposed
for inclusion into git?

Regards, Thomas Koch
