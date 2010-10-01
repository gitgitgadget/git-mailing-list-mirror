From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: State of ab/send-email-perl in next
Date: Fri, 1 Oct 2010 21:42:16 +0530
Message-ID: <20101001161213.GA26521@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 18:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1iEh-0005XP-Ej
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 18:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0JAQNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 12:13:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43396 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0JAQNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 12:13:21 -0400
Received: by iwn5 with SMTP id 5so3989861iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=9EmnrggbGTVNpvQc9LQ3G9nYDgvL0XYdg27OAwMxgvg=;
        b=cvw8PaLKJ+ugkteSA8XiGbsjpn0RSk8n2RxpXMjbOWag4iWSD8bgIgLrkO/V6Gz0Pa
         0yZJaok9jo/fYYzyNCQvg0ZQ/pJHGfLSOUHMMUJ7KTbNQ9zqJZ4GxqdrZDPefFyxYbCB
         9KX5h4ZdQ1i5yCdprGeap41fkLEGaFjhk02g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=HBCIj+QSgNBG00r1huG3ZPCWPa6TtBKOxApqraetwTnO4xnyGHpi/MD3+011wV58t9
         MKug+BV3ckI7ECHlaOAZ9MHlWX6fxoyVcpcockwru21G1aPavJwnWW90H4n6aw4UuNNV
         SGMIWRenu4I60vd607inAQieipR48kcaP8LZk=
Received: by 10.231.30.68 with SMTP id t4mr5864071ibc.129.1285949600712;
        Fri, 01 Oct 2010 09:13:20 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n20sm1323488ibe.17.2010.10.01.09.13.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 09:13:19 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157758>

Hi Junio,

I just pulled in some updates from `next` and I noticed this. Thought
I should let you know incase you miss it: many of the commit messages
are malformed like this one. Notice how =C6var's s-o-b and Avery's
"Reviewed-by:" appear on the same line.

commit 529dd386dda6c6e6d0dad801785d2d943756fb3f
Author: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
Date:   Thu Sep 30 13:43:08 2010 +0000

    send-email: make_message_id use "require" instead of "use"
   =20
    Change the use of Sys::Hostname from a "use" to a "require". The
    former happens in an implicit BEGIN block and is thus immune from t=
he
    if block it's contained in, so it's always loaded.
   =20
    This should speed up the invocation of git-send-email by a few
    milliseconds.
   =20
    Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.comRevie=
wed-by: Avery Pennarun <apenwarr@gmail.com>
    Reviewed-by: Jeff King <peff@peff.net>
    >
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
