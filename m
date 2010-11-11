From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Thu, 11 Nov 2010 20:18:52 +0700
Message-ID: <AANLkTimuN2Ese-Am+Ydr6n1A9YGhFauUit_da0ici5bL@mail.gmail.com>
References: <m3eiatfbg2.fsf@localhost.localdomain> <1289407021-30287-1-git-send-email-pclouds@gmail.com>
 <20101110174736.GD11513@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, gitster@pobox.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 14:19:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGX3e-0001De-Ak
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 14:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722Ab0KKNTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 08:19:15 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56540 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759Ab0KKNTO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 08:19:14 -0500
Received: by wwb29 with SMTP id 29so44566wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 05:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8mCO+KNSPc0iujuj65Gp7UEyZ0fdHy4qvrVtjpmCc5s=;
        b=peMLMfzNlzEvLVFgeGeEx/5ALKDQuA/Z1JCfqbI0Mq43d30MMZVi01OjI2PdAmqqY5
         L280uVSkowrqiRm/0ydA/PnOQdOTXanc7lbW3a3/vw8y+l6+BwDjHoxoBmQWCtf2mxve
         6q9YT0cvlZ8ew460bMArEDIMiOUOUuhOShsn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VwV+bSzNpVzQfDYQR98Loc+SrCdhIzBY0YfrVx68RUCPCXoUSu0Ig3l9ZcK/peHgpC
         WHmjOHc9i1ZZ9wYQqcrovS2uecnpZMe/iie55jZ+iOSSsC0aM2SE/3VmViPY+d3CVrNb
         GF9tnzo2+5GZ66db07S99Cpceq3rxbOewGwCw=
Received: by 10.216.182.75 with SMTP id n53mr1879797wem.41.1289481552585; Thu,
 11 Nov 2010 05:19:12 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 11 Nov 2010 05:18:52 -0800 (PST)
In-Reply-To: <20101110174736.GD11513@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161246>

2010/11/11 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> This does not work in commands that startup_info is NULL
>> (i.e. non-builtin ones).
>
> That is easily fixable, no?

Laziness is a big factor to me (or maybe I'm just tired after work).
In the meantime I'll take your analysis and fix fast-import. Thanks.
--=20
Duy
