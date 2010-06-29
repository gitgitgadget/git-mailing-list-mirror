From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: [PATCH 2/5] Add another rename + D/F conflict testcase
Date: Tue, 29 Jun 2010 12:49:58 +0400
Message-ID: <AANLkTik6Qt40dZA8Gv26j0SyhkvZt5D2LIm_QBEtmAsU@mail.gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
	<1277773936-12412-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	vmiklos@frugalware.org, gitster@pobox.com, spearce@spearce.org
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 29 10:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTWWD-0007DR-1N
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 10:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab0F2IuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 04:50:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48558 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0F2IuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 04:50:00 -0400
Received: by wyb38 with SMTP id 38so2489421wyb.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yi/w6PzE87p1EpRVgShcSEXeVU0FV9cwERubDtTioH4=;
        b=kzK5C7ej4OdepQqbNqOXP8yFc1RODPVqTQMQlEKJpkpdMiXt7KbxaMFq7U8djMRI4V
         jbthLKy5P6Bq+osN4c4J8J1aH78qoMAR53WOO7RG7eYRcmhX79ZIfSpWzmMfavNCPGI7
         fJtRl9TtFnuc5xMBrS+x6syc5cs1tOlt60oMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IWUBqwWsle4kQ73oHzc40vmx5YXrb5gdBap0RQU0RiZR+zRy3DrgGnm9TFxJygRNcR
         Y2z7REI/hxy5U09/4Q2Zc838jRHG5JYq/48ctTonpO4vedFskg/PY5JJTw28tgMlKrfP
         vJFAYefLL68YiydgnewTK1IS/ASzEzXXy7KA0=
Received: by 10.227.69.17 with SMTP id x17mr4948151wbi.171.1277801398724; Tue, 
	29 Jun 2010 01:49:58 -0700 (PDT)
Received: by 10.216.169.142 with HTTP; Tue, 29 Jun 2010 01:49:58 -0700 (PDT)
In-Reply-To: <1277773936-12412-3-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149896>

> I hope it's not bad style to take someone else's testcase from the ma=
iling
> list and submit it on their behalf as a testsuite addition (nor do I =
know
> what to do about the signed-off-by line in this case). =C2=A0This is =
simply the
> testcase Alexander Gladysh posted to the list on March 8. =C2=A0I rea=
lly like
> his example due to how it serves as a simple case where there are two=
 D/F
> conflicts with a rename across paths involved in both of those D/F
> conflicts.

I have no problem if you use my test case for the Git testsuite. The
more tests =E2=80=94 the merrier. :-)

Consider this testcase as signed-off by me.

If you feel that you need to mention my name somewhere and proper Git
headers are a problem =E2=80=94 commit comments would do.

If, to honor all formalities, you would need my actual commit =E2=80=94=
 please
tell me, I'll try to submit it.

Alexander.
