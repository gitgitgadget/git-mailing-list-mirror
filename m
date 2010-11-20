From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/6] http (dumb): end urls with slash
Date: Sat, 20 Nov 2010 12:32:28 +0800
Message-ID: <AANLkTimWz4meHUb6o0K8yNMmqyqpWbKrq0OmnzWAS300@mail.gmail.com>
References: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr>
	<AANLkTikM8mNv+GiVyDWEJxsf0o3FYaaJj+jdYyiuXnov@mail.gmail.com>
	<20101119051047.GA4201@burratino>
	<1290170790-2200-1-git-send-email-rctay89@gmail.com>
	<7vd3q0c4b3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 05:32:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJf7r-0000KK-V6
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 05:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007Ab0KTEca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 23:32:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48163 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757916Ab0KTEc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 23:32:29 -0500
Received: by eye27 with SMTP id 27so3166288eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 20:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=roPfq+zpFrm2J71Wk9423X6ycnWingwE8s4WORjwAdA=;
        b=faUGqe/ptvU1KTNBS1DIcieiqGoVMoo2G0HF2zXXuVELts8P2fLgTuneGeVCuVyV/S
         s0FdE2kX1MnQV1mKo5dXfHoEoxDVsmDCGHuZFAnkYECbBT/aw6uW86ULa8KEfEkFwp2E
         k1oFVCw6IU+OTUtEuevp4hVZhgarAwBbLp0oA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BJwBovTSAn23PL0IGeHYrfZKpxtFy/BMdaCdzm9X3C4G9RAHToHI0BJIv1Afg6Ea99
         CGyYrdQbLUrXcC/DLVJiqs6IGqoLpK1cMSGd3ftZXt9QIdxgOwcd2SWeSYq7zSyR2o8Z
         2x5sLD1nJS9cselD6JcDU6vGmrp3hqVoGI24I=
Received: by 10.213.14.146 with SMTP id g18mr5677166eba.2.1290227548661; Fri,
 19 Nov 2010 20:32:28 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Fri, 19 Nov 2010 20:32:28 -0800 (PST)
In-Reply-To: <7vd3q0c4b3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161822>

Hi,

On Sat, Nov 20, 2010 at 6:54 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Didn't find anything suspicious during my cursory read (except for th=
e
> ones Jonathan pointed out, which I missed), but how does this series
> relate to your earlier commits around d8fab07 (remote-curl: ensure th=
at
> URLs have a trailing slash, 2010-04-08)? =A0Same topic, tying loose e=
nds?
> Same topic, different approach? =A0Unrelated changes with similar-sou=
nding
> names?

Johnathan and Junio, thanks for taking the time.

Sorry for the confusion. Well, it's all about slashes, hence the
title, but there are some refactors and related work in the http area
in this series.

--=20
Cheers,
Ray Chuan
