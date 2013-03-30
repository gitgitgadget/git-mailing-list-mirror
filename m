From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 12/12] pretty: support %>> that steal trailing spaces
Date: Sat, 30 Mar 2013 16:31:12 +0700
Message-ID: <CACsJy8Bd7duZzTmhHM6H_e1tvkGM=socofDps8dMeQbtj5_5-Q@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1363400683-14813-13-git-send-email-pclouds@gmail.com> <CAPig+cSzHuSnT2+e+U+zJtOUtReUo=3JWZDQcCbMKS4ibZtjvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 10:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULs99-0002pe-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab3C3Jbo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:31:44 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:49950 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab3C3Jbo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Mar 2013 05:31:44 -0400
Received: by mail-oa0-f54.google.com with SMTP id n12so922896oag.13
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=G7WrGulNpUS/AFR3HRJJp96XxOJBbD0EUG2MmQjv81w=;
        b=g0WZpz2EAOrUyw7MqyVx+x+Z5ERLwhRPfZVyysSxoARiqGW1nS95uycjvuJDwB9ha4
         0p5rcQRP1j7vvkLn1v7EaaabQYJxaG3EsCpvPH9/4Ulya4zhlb6/K1qOD5pSJH9XCtWt
         ZfFHV6P2GE3A/5FtSsm4tKBDBczvFjrifA+bWaHxAkE53EROJNFI+YZnFbu/5hSeKOyV
         /3Yq+SIv1VjZAizcfhIpiCB5p89cNLIird776Mfv8+5Gmv1RuZK2FQHTKngrFTSnVhki
         SdKg9QJjq3aj6ZK7aWlraIU5yzOMwBUGbiutWN4FewpVTCPFcFpPltUmmzDHRPTkxUE9
         mPxw==
X-Received: by 10.60.8.197 with SMTP id t5mr1922933oea.4.1364635903336; Sat,
 30 Mar 2013 02:31:43 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Sat, 30 Mar 2013 02:31:12 -0700 (PDT)
In-Reply-To: <CAPig+cSzHuSnT2+e+U+zJtOUtReUo=3JWZDQcCbMKS4ibZtjvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219568>

On Sun, Mar 17, 2013 at 4:06 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Fri, Mar 15, 2013 at 10:24 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy
> <pclouds@gmail.com> wrote:
>> This is pretty useful in `%<(100)%s%Cred%>(20)% an' where %s does no=
t
>
> s/% an/%an/

No. The space after '%' is intentional. And thanks for proofreading in
all my patches.
--
Duy
