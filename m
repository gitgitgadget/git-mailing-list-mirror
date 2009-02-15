From: Ben Hoskings <ben@hoskings.net>
Subject: Re: Unexpected local changes immediately after fresh clone
Date: Sun, 15 Feb 2009 20:38:30 +1000
Message-ID: <5442F1F6-41A3-4CCD-8167-FB65CA5E1164@hoskings.net>
References: <3D94CDCE-88EB-479A-9D36-6B92FCFCBAF4@hoskings.net> <76718490902122141h578a72e3k70366d6583d6c8c3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 11:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYePt-0005sT-Hn
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 11:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZBOKig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 05:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbZBOKig
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 05:38:36 -0500
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57349 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbZBOKif convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 05:38:35 -0500
Received: from 203-214-44-138.dyn.iinet.net.au ([203.214.44.138] helo=[192.168.0.4])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <ben@hoskings.net>)
	id 1LYeOQ-000IUb-Cp
	for git@vger.kernel.org; Sun, 15 Feb 2009 10:38:34 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 203.214.44.138
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+NfruTD+QNcdCFC4Eoi3sW
In-Reply-To: <76718490902122141h578a72e3k70366d6583d6c8c3@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109988>

On 13/02/2009, at 3:41 PM, Jay Soffian wrote:

> HFS+ is case-insensitive by default. The Linux kernel has files which
> collide on a case-insensitive filesystem, which is what you're seeing=
=2E

Aha=97yep, that was it alright. That could have taken a while to track =
=20
down; I wasn't expecting anything of the sort, but retrospectively, of =
=20
course. :)

Thanks for your help.

Ben
