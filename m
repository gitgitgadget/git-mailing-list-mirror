From: Christoph Duelli <duelli@melosgmbh.de>
Subject: [gitk] after exiting gitk the X11 clipboard is "messed up" - it contains
 the wrong commit
Date: Wed, 30 Sep 2009 10:38:17 +0200
Message-ID: <4AC318F9.4080104@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 10:38:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msuhj-0007vb-A6
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 10:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbZI3IiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 04:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbZI3IiU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 04:38:20 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:13531 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZI3IiT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2009 04:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1254299901; l=1952;
	s=domk; d=melosgmbh.de;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:
	Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=/dy+/SEI5WoZjuUiazGUeH3yqEU=;
	b=mOWJFkLBuscIwRpEYkyDOKK3T5KR/UZIsF3sKDEs3MjjGjUWbNIAFWqWIPF6R4dbXcn
	sEnkbw6srNpkjbFLPGaAY385cXoAxvZeceR50XSe9AHYOa1cHc2OS/wk9fCgfuvVg2olL
	eh0Ll1oygQM5ZXFDN+Inr3SVHEHdZNoI0og=
X-RZG-AUTH: :P2kWY0mrft+7PRqjQVQfkgnIveo2zsFMc4bua7BlzFdpPx7kEk2N74DOz34elah7
X-RZG-CLASS-ID: mo00
Received: from mail.melosgmbh.de
	(186.146.179.213-static.augustakom.net [213.179.146.186])
	by post.strato.de (klopstock mo63) (RZmta 22.1)
	with ESMTP id 203789l8U7kGtX for <git@vger.kernel.org>;
	Wed, 30 Sep 2009 10:38:21 +0200 (MEST)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.031,BAYES_00: -1.665,TOTAL_SCORE: -1.634,autolearn=ham
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.7.0 patch 1)
	for git@vger.kernel.org;
	Wed, 30 Sep 2009 10:30:34 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129335>

(Using git 1.6.5.rc1.19.g8426 on SLES10 Linux) I am having the followin=
g=20
  problem:

1) gitk somefile.c
2) find the interesting commit, double click the sha1 id to bring it=20
into the clipboard (works)
3) exit gitk
4) gitk <paste from clipboard>
-> the id that is pasted is NOT the one I double clicked but the first=20
one in the list

As a workaround I paste the ID first and exit gitk later, but this is a=
=20
bit annoying (and a trap for gitk users).

See also
http://article.gmane.org/gmane.comp.version-control.git/65845/match=3Dg=
itk+clipboard

Best regards and thank you for a helpful tool.
--
Christoph Duelli



-----------------------------------------------------------------------=
----------
MELOS GmbH
Medizinische Labor-Organisations-Systeme GmbH=20
=46ranz-Beer-Stra=DFe 6
86459 Gessertshausen
Tel.: +49 8238/9611-0
=46ax: +49 8238/9611-99
mailto: info@melosgmbh.de
URL:    www.melosgmbh.de

Amtsgericht Augsburg, HRB 13226
USt-IdNr. DE 130 958 139
Gesch=E4ftsf=FChrer:
Herbert Mayer, Andreas Manntz, Helmut Welsch
--------------------------------------------
This e-mail (including any attachments) is confidential and may be priv=
ileged. If you have received it by mistake, please notify the sender by=
 e-mail and delete it from your system.
Any unauthorised use or dissemination of this e-mail or its contents in=
 whole or in part is strictly prohibited. Please note that e-mails are =
susceptible to change.
MELOS GmbH shall not be liable for the improper or incomplete transmiss=
ion of the information contained in this communication nor for any dela=
y in its receipt.
MELOS GmbH does not guarantee that the integrity of this communication =
has been maintained nor that this communication is free of viruses, int=
erceptions or interference.
