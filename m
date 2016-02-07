From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each valid atom
Date: Sun, 07 Feb 2016 14:47:16 +0100
Message-ID: <87wpqg4opn.fsf@linux-m68k.org>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
	<CAOLa=ZQxbCYd_bpf4PSpRVvejOgi=farNPtHgP_mZZypOf6cnQ@mail.gmail.com>
	<CAPig+cSt9Dub88ywP8mc8dPq6pXFvn4OTSJmEWbAiTeirRB7xA@mail.gmail.com>
	<CAOLa=ZTFVLxiP5PXszwmS3xueitQJd3FhJ968hf58yvWX=qmGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 14:47:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSPgx-0007qJ-QJ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 14:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbcBGNrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 08:47:51 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:33667 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbcBGNrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 08:47:22 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3pysH948kgz3hjhF;
	Sun,  7 Feb 2016 14:47:17 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3pysH93BY8zvdWc;
	Sun,  7 Feb 2016 14:47:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id CBbVKwHcbR2c; Sun,  7 Feb 2016 14:47:16 +0100 (CET)
X-Auth-Info: FuksyGVPGSquG+9E9Joj1vA2qmWG1stwCa3XiDpMtamDihFLIRr5KAtHCi9uzssd
Received: from igel.home (host-188-174-197-168.customer.m-online.net [188.174.197.168])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  7 Feb 2016 14:47:16 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 1C6712C51EC; Sun,  7 Feb 2016 14:47:16 +0100 (CET)
X-Yow: HELLO, little boys!   Gimme a MINT TULIP!!  Let's do the BOSSA NOVA!!
In-Reply-To: <CAOLa=ZTFVLxiP5PXszwmS3xueitQJd3FhJ968hf58yvWX=qmGA@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 7 Feb 2016 14:31:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285729>

Karthik Nayak <karthik.188@gmail.com> writes:

> +               if ((( arg && len == arg - sp)  ||
> +                    (!arg && len == ep - sp )) &&

                      len == (arg ? arg : ep) - sp &&

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
