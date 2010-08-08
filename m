From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Allow HTTP user agent string to be modified.
Date: Sun, 8 Aug 2010 10:49:53 +0800
Message-ID: <AANLkTinuHAnmakLsKujpj6C=eShxe_s+dnwYWg5VfvHy@mail.gmail.com>
References: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
	<AANLkTinyohKaACbheGR2Q=-K5sWwv+y1u1-3b2WPzxVh@mail.gmail.com>
	<1281202184.4815.1.camel@compaq.olson.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Sun Aug 08 04:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohvxr-0008M2-C8
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 04:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab0HHCtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 22:49:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36894 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0HHCty convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 22:49:54 -0400
Received: by iwn33 with SMTP id 33so2626330iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KNprGJE7iAGhDSVLiVhe/UsbNqFw2FNj7d7cvANA4Kg=;
        b=t3jkBq078gSrTvlsvm6iVrDPg3VqjEORv8tsWnW/RLsR+DWhN/YwqpLHZID+e+8cq5
         63AqmPC1ClsJyBimCTgb3qosCPFTNKy8DxU8J7q/6z8PL+Em73I/quz6kdf97E4eu4RR
         c9pwdTaj/cEjDjl4FxkAig/HAha7ubcQ+XmTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gSsQrNYRnVZMURLCMhxaK0d1dWUfuBLO9eU2UaBxwL4ljuPeRg8hYgwU9rp+NqauYh
         YvhRfOQQnuVMmZ7NO9tapLA6idYibHTp6ShTVo2G1J1pllwyPSL8LqOB+mEmhqyhuWnC
         tcGJcQB1xLoO72JEhYMBItnEQcaElqAY3gSJA=
Received: by 10.231.191.138 with SMTP id dm10mr16566300ibb.126.1281235794042; 
	Sat, 07 Aug 2010 19:49:54 -0700 (PDT)
Received: by 10.231.158.141 with HTTP; Sat, 7 Aug 2010 19:49:53 -0700 (PDT)
In-Reply-To: <1281202184.4815.1.camel@compaq.olson.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152878>

On Sun, Aug 8, 2010 at 1:29 AM, Spencer E. Olson <olsonse@umich.edu> wr=
ote:
> I would have no problem doing that. =A0I was just trying to match the
> style already present in http.c. =A0All the other pointer tests in th=
at
> function/file are done the same.

I wouldn't go so far as to say "all" - there is quite a mish-mash of
check styles there.

--=20
Cheers,
Ray Chuan
