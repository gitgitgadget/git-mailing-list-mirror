From: "Theo Niessink" <theo@taletn.com>
Subject: RE: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Tue, 7 Jun 2011 13:46:13 +0200
Message-ID: <746198706CB145F79CD13E52567F1F58@martinic.local>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com> <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org> <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com> <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local> <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com> <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>,
	<johannes.schindelin@gmx.de>
To: "'Junio C Hamano'" <gitster@pobox.com>, <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:46:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTujq-0001zJ-QE
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab1FGLqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 07:46:22 -0400
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:1952 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333Ab1FGLqV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 07:46:21 -0400
Received: from cpbrm-ews18.kpnxchange.com ([10.94.84.149]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Jun 2011 13:46:15 +0200
Received: from CPSMTPM-CMT108.kpnxchange.com ([195.121.3.24]) by cpbrm-ews18.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Jun 2011 13:46:16 +0200
Received: from pc0003 ([77.168.115.212]) by CPSMTPM-CMT108.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Tue, 7 Jun 2011 13:46:13 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6090
Thread-Index: AcwkxYvUqvfPvrc1SOCPzTGTRiAqwAAQsH5A
In-Reply-To: <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 07 Jun 2011 11:46:13.0633 (UTC) FILETIME=[80B6C710:01CC2508]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175201>

Junio C Hamano wrote: 
> Let's not add an unnecessary goto while at it.  How about this on top
> instead?

Yeah, that is much cleaner indeed.

- Theo
