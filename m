From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/11] Add new git-cc-cmd helper to contrib
Date: Sat, 20 Apr 2013 11:16:31 +1000
Message-ID: <CACsJy8Dt2++tRUYcJk3jXuHUAv9jRmYYSYyVwHXQeo5O_3WQLw@mail.gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 03:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTMQb-0003LT-LZ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 03:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252Ab3DTBRE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Apr 2013 21:17:04 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:54530 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965210Ab3DTBRD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 21:17:03 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so739390obc.20
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 18:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=HmdOKVWwaUW1iAZm9COPU/FO5DhIWm2sCahhqWIgbMQ=;
        b=jO9FlsRCjfdwF5VHiiZ8lyigvELZFSbL6YWhzTWh4fxcCENO/AqYdOpJA8vimLS7If
         jREdKFbHQ3sU3tWN23ptLVlOJ1MCV1teKZoLt4QxLPtBwaZtMa4WWXLF49+AXHC/yCOU
         U6Z3kzUtRKTjQJTDvByMfIFBVHVbGLfjYaUuUtfij13cA7YCtRh52pQNpiZv0X3tDD6r
         DKG6ezk6zyrJJBOtgV6ioVtxe7Fw76pAK2/hAf8x/TMF2nChMOpPdAmKIoThMiejasy9
         OMf7m8R9iesOaOYRCleuEQsdfSmCJlgULAKHRVbxND2XGdaDaGKoXr1bxzc2WdYyi9bm
         599A==
X-Received: by 10.182.204.5 with SMTP id ku5mr5569142obc.22.1366420621879;
 Fri, 19 Apr 2013 18:17:01 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Fri, 19 Apr 2013 18:16:31 -0700 (PDT)
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221828>

On Sat, Apr 20, 2013 at 5:30 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This script allows you to get a list of relevant persons to Cc when s=
ending a
> patch series.
>
>   % git cc-cmd v1.8.1.6^^1..v1.8.1.6^^2
>   "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com> (au=
thor: 30%, signer: 7%)
>   Duy Nguyen <pclouds@gmail.com> (author: 7%)

You see, I like to cause confusion. These two are the same person.
Maybe you should check based on email only instead.

>   "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> (author: 7%)
>   Jean-Noel Avila <jn.avila@free.fr> (signer: 7%)

And these two are like the same. Perhaps mailmap support will help?
--
Duy
