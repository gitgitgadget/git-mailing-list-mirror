From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] send-email: Ask for in-reply message ID even if from and to is already known
Date: Fri, 11 Jun 2010 22:11:59 +0200
Message-ID: <201006112211.59425.alexander.stein@informatik.tu-chemnitz.de>
References: <vpqtypmn4bm.fsf@bauges.imag.fr> <201006101908.19578.alexander.stein@informatik.tu-chemnitz.de> <7vtyp9ie2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 22:12:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONAaJ-00072W-88
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 22:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918Ab0FKUMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 16:12:05 -0400
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:56177 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316Ab0FKUME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 16:12:04 -0400
Received: from 77-64-189-43.dynamic.primacom.net ([77.64.189.43] helo=kongar.localnet)
	by jack.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alexander.stein@informatik.tu-chemnitz.de>)
	id 1ONAa7-0000yP-VT; Fri, 11 Jun 2010 22:12:00 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.32-gentoo-r7; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7vtyp9ie2a.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -0.9 (/)
X-Spam-Report: --- Start der SpamAssassin 3.3.0 Textanalyse (-0.9 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 TVD_RCVD_IP TVD_RCVD_IP
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: e3a4f6e1275be1643272008be9fceab0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148968>

Am Freitag 11 Juni 2010, 21:06:53 schrieb Junio C Hamano:
> Did you run the existing test suite unattended and make sure everything
> still passes?

During test suite run I noticed this patch doesn't allow to run the suite 
unattended. This may only work with some config option as Matthieu already 
pointed out.
I will rethink about this problem and repost a new patch

Alexander
