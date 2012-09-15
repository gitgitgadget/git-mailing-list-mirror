From: "Philip Oakley" <philipoakley@iee.org>
Subject: How to create the " [PATCH 0/5]" first email?
Date: Sat, 15 Sep 2012 15:27:02 +0100
Organization: OPDS
Message-ID: <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:27:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCtLY-0003KU-Jt
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 16:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab2IOO0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2012 10:26:52 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:60251 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751357Ab2IOO0w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2012 10:26:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuMKAG2PVFBZ8rU+/2dsb2JhbABFhgeFP69GAnyBCIIbBgEFCAEBGQQLAQUeAQEcEAIDBQIBHQIFIQICFAEEGgYHFwYbAgECAwGIAKgtklCBIYoZAYFOg24yYAONZZgdgmeBYg
X-IronPort-AV: E=Sophos;i="4.80,426,1344207600"; 
   d="scan'208";a="403818525"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip01ir2.opaltelecom.net with SMTP; 15 Sep 2012 15:26:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205560>

The git format-patch allows numbered patches to be created, however I'm
not sure how folk generate the initial "0/n" patch. Which of the variou=
s
options should I be using?

Also, being on windows, the various 'mbox' and 'MUA' discussions are ne=
w
to me, so the format-patch step where :-

"Typically it will be placed in a MUA=E2=80=99s drafts folder, edited t=
o add
timely commentary that should not go in the changelog after the three
dashes, and then sent as a message whose body, in our example, starts
with "arch/arm config files were=E2=80=A6". On the receiving end, reade=
rs can
save interesting patches in a UNIX mailbox and apply them with
git-am(1)."

hides a multitude of implicit knowledge steps. Is there an extended
description of what that would mean from a platform independent
viewpoint? e.g. if the patches are separte files and an mbox is one
consolidated file, how to get from one to the other so that 'it' can be
sent by 'git send-mail'.

I'm also missing an understanding of the preparation stage where one
tries to tidy up the various commit messages becaue they weren't
explicit, specfic nor concise enough, so I suspect that there is an
implicit `git format-patch` <-> `git am` loop of sharpening the mbox
patches before submission to the list that I'm missing. Has this=20
described somewhere?

Philip Oakley
