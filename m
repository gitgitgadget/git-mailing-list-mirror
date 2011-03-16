From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to itself
Date: Wed, 16 Mar 2011 21:58:03 +0700
Message-ID: <AANLkTinUqK=pxTGYZn0oLm5i9cs4=XRPjHXnRp-FP9xh@mail.gmail.com>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-2-git-send-email-cmn@elego.de> <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
 <1300140128.4320.39.camel@bee.lab.cmartin.tk> <7vpqptb976.fsf@alter.siamese.dyndns.org>
 <1300190396.19100.31.camel@bee.lab.cmartin.tk> <1300192832.19100.35.camel@bee.lab.cmartin.tk>
 <7vd3lsb9m3.fsf@alter.siamese.dyndns.org> <1300210062.19100.46.camel@bee.lab.cmartin.tk>
 <AANLkTimQ81mwYhWLzGunimQzapEUkMmvKj47PuPWPgm0@mail.gmail.com> <1300286976.7214.27.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzsC1-00032i-VF
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab1CPO7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 10:59:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43541 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab1CPO7Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 10:59:16 -0400
Received: by wya21 with SMTP id 21so1718617wya.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=/SX02p/cFh5eANBQ/Zd+mHWNztueq0/bG1Lx2Tu5Kwg=;
        b=leEpsv7j+Pd1n4cFAoEGFxtXuYbctg0oyUt97uar0uiQd41cYd9qoAcvoLfcY7vfTi
         pkcwsE5sBJ6q0PRBtu7CD095ZYaZQyVxONWU7olegrB9r8F6p9N2m8HNdKDo7BaH36D9
         pNo1pJy7jcNfNGzxCE42xfmk4EVka/83nVoAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T7p8JR4h6au5jKhXeN10rGfAP0Xy4I8mW5NKyd5nTYmzVuHAbZYQasK6GFI4JpmeXd
         aZ56LZ4f3N+GcAUkSVxPLDAeox9smsrzpnFx4l4LY/ZT7CYluvkilKJcGUi9idjO49WW
         Gn1hbpUegqlEugINhY69PXPnAHT4h6VeFEkIE=
Received: by 10.216.243.195 with SMTP id k45mr74484wer.66.1300287555480; Wed,
 16 Mar 2011 07:59:15 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 16 Mar 2011 07:58:03 -0700 (PDT)
In-Reply-To: <1300286976.7214.27.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169161>

On Wed, Mar 16, 2011 at 9:49 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> =C2=A0At any rate, I think make_absolute_path is mis-named and it sho=
uld be
> called real_path (or make_real_path). The difference between
> make_nonrelative_path and make_absolute_path is certainly not clear
> without looking at the implementation.

More precise, descriptive names are always appreciated :)
--=20
Duy
