From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Sat, 22 Feb 2014 10:57:17 +0100
Message-ID: <m261o7a2rm.fsf@linux-m68k.org>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8DnjQyzY2ym7=fAQzThuhMuFzGLuKc35JJXn5FfB7r4Gg@mail.gmail.com>
	<87fvnbhdn7.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 22 10:58:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH9LN-00053d-Ei
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbaBVJ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:57:28 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:46012 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbaBVJ50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:57:26 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fWQ1t4r5Hz3hjcZ;
	Sat, 22 Feb 2014 10:57:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fWQ1t4czWzbbjY;
	Sat, 22 Feb 2014 10:57:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id LA6f9sqMkRL7; Sat, 22 Feb 2014 10:57:21 +0100 (CET)
X-Auth-Info: tHFCfAHJCMwghVSKJqGCNZkiYtqDd7rA/1H6Pm/Mkz8=
Received: from linux.local (ppp-88-217-46-190.dynamic.mnet-online.de [88.217.46.190])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 22 Feb 2014 10:57:21 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id D4B971E55E9; Sat, 22 Feb 2014 10:57:17 +0100 (CET)
X-Yow: It's OBVIOUS..  The FURS never reached ISTANBUL..  You were
 an EXTRA in the REMAKE of ``TOPKAPI''..  Go home to your
 WIFE..  She's making FRENCH TOAST!
In-Reply-To: <87fvnbhdn7.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sat, 22 Feb 2014 07:20:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242523>

David Kastrup <dak@gnu.org> writes:

> That does look strange: Emacs has a history of more than 30 years.  But
> the Git mirror is quite younger.  Maybe one needs to make sure to use
> the author date rather than the commit date here?

There is no difference between commit and author date in the Emacs git
mirror since bzr doesn't keep that distinction (and cvs didn't either).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
