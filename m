From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] command-list.txt: mark git-archive plumbing
Date: Wed, 16 Feb 2011 16:32:27 +0700
Message-ID: <AANLkTi=3BUE5Zu6yLjOe-hJ4LBh8qzwVmOdML8GQ0=ss@mail.gmail.com>
References: <4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org> <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org> <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann> <20110209210312.GB2083@sigill.intra.peff.net>
 <7vipwsomq8.fsf@alter.siamese.dyndns.org> <20110209234621.GA12575@sigill.intra.peff.net>
 <20110215070426.GA6118@duynguyen-vnpc> <7vwrl1nmdr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 10:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppdky-0005Sm-F7
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 10:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821Ab1BPJdC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 04:33:02 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50736 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758788Ab1BPJc6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 04:32:58 -0500
Received: by wwa36 with SMTP id 36so1160816wwa.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 01:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=W8eSzEXcbxmM1GZbDrDCcS3+3vTTcpDVnLbVSLTrzrk=;
        b=vr9UMYDE5dccujlezNHBFQnTOUGwIofdAa21WMU243n/dNMffm8dgc60sX1S/gDtqI
         h6N6nY+sac2gVrymC87E2cusbVyxYEVQr5UHVr3CzNRTQ/cmYJNTkBXiA/a2/odgLaUg
         XrBNm9+d8KaplRDuQ9+cbYO7C6iPJDFsHtGyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=M9OOb6eoZcTqHerKfhBjyBT3DvnsJvS3lMUBi8w+b5eWz3lMYtLcg9ikBqBe5T/mtn
         aBVNEcJDw+9Wbi6fGRzpk6SwwFcweJQBMmuHHwc2FLOA9E9iAqxmmIVi/W0vly4iLYZO
         x8idg2NsZLNRxIBkjQbFmbwkZCaiX27eEXr9s=
Received: by 10.216.50.72 with SMTP id y50mr300816web.28.1297848777207; Wed,
 16 Feb 2011 01:32:57 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 16 Feb 2011 01:32:27 -0800 (PST)
In-Reply-To: <7vwrl1nmdr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166938>

On Wed, Feb 16, 2011 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> =C2=A0 Perhaps a patch like this for the record?
>
> Hmm, I don't think you can have it two ways.
>
> What does Documentation/cmd-list.perl do to this line?

I see. The first category is used to split commands into a hash.

cmd-list.perl produces cmds-mainporcelain.txt with git-archive and
cmds-plumbinginterrogators.txt without.
--=20
Duy
