From: Bo Chen <chen@chenirvine.org>
Subject: Re: GSoC - Some questions on the idea of
Date: Sun, 1 Apr 2012 19:30:51 -0400
Message-ID: <CA+M5ThTnd+TST6WsAn-Jd=Gb=1EWaJ+QbLMxXgtAVFNVqnRcMw@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
	<CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
	<loom.20120328T131530-717@post.gmane.org>
	<CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
	<20120330203430.GB20376@sigill.intra.peff.net>
	<4F7768D6.3010400@gmail.com>
	<CA+M5ThTKtSFPq8A3oc1wvc9i0vG1NMyHCRE+poYaq+65FQWOxw@mail.gmail.com>
	<CACsJy8DTegW78Qw7-T6uK_oZj2CELv57bbH6sU=bScHDesGYPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jeff King <peff@peff.net>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 01:31:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEUEm-0006Yg-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 01:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab2DAXax convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Apr 2012 19:30:53 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37045 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2DAXax convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 19:30:53 -0400
Received: by wibhq7 with SMTP id hq7so2157821wib.1
        for <git@vger.kernel.org>; Sun, 01 Apr 2012 16:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=K6kJKVQsi0rPZX0HmEaqTJiR/8sUTk5pyP4j1LdECF4=;
        b=NjV4NhVPZ/q2bTv7eDL9sjP40Ca3eLM5bXqZSIJewNTcWdtmoI89i09Kf9ebVQ6FEp
         LWoauhm3b2UBLiY1lC2FT2kT/9lXP/mIFzt4vHNPXyO2oAXqnlPeQIVTJg6amIEhEbJ9
         qdZnRzD80PerYNJ8E8Xw+6NCARj/v7RcosJOjj8hex4IooKy/8JUiOBJpT80s6Q3XXqC
         owu8y9DQoqTcDFg/fVZuqX56OrTFxdB5EjR00pOHY97eMiFaAgOlWE2oUVfHWb1aKish
         lvnAyT6ntb8h/afDU9u0dsIfjCQHtaHXPdgoAdFXHFQ6uS2shDcanhTzLnhYH4UHkIJv
         Imfw==
Received: by 10.180.97.41 with SMTP id dx9mr19472238wib.9.1333323051695; Sun,
 01 Apr 2012 16:30:51 -0700 (PDT)
Received: by 10.216.47.65 with HTTP; Sun, 1 Apr 2012 16:30:51 -0700 (PDT)
X-Originating-IP: [69.248.109.119]
In-Reply-To: <CACsJy8DTegW78Qw7-T6uK_oZj2CELv57bbH6sU=bScHDesGYPQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQnJF0989Wk5XKfC2j6u9XkHBHsb5ORXdeJv7x5i8S839zt7rTDeKOiXEnpDycMxw1caEle0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194493>

One question,  can anyone help me clear?

My .git/objects has 3 blobs, a, b, and c. a is a unique file, b and c
two sequential versions of the same file. When I run "git gc", what
exactly happens here, e.g., how exactly git (in the latest version)
delta compresses-the blobs here?

Any help will be appreciated.

Bo

On Sun, Apr 1, 2012 at 12:22 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Sun, Apr 1, 2012 at 4:27 AM, Bo Chen <chen@chenirvine.org> wrote:
>>> Who decides bigness:
>>> Bigness seems to be relative to system resources. =A0Does the user =
crunch the
>>> numbers to determine if a file is big-file, or does git? =A0If the =
numbers are
>>> relative then should git query the system and make the determinatio=
n?
>>> =A0Either way, once the system-resources are upgraded and formerly =
"big-files"
>>> are no longer considered "big" how is the previous history refactor=
ed tot
>>> behave "non-big-file-like"? =A0Conversely, if the system-resources =
are
>>> re-distributed so that formerly non-big files are now relatively bi=
g (ie,
>>> moved from powerful central server login to laptops), how is the hi=
story
>>> refactored to accommodate the newly-relative-bigness?
>>>
>>
>> In common sense, a file of tens of MBs should not be considered as a
>> big file, but a file of tens of GBs should definitely be considered =
as
>> a big file. I think one simple workable solution is to let the user
>> set the threshold of the big file.
>
> We currently have core.bigFileThreshold =3D 512MB.
>
>> One complicate but intelligent
>> solution is to let git auto-config the threshold by evaluating curre=
nt
>> computing resources in the running platform (a physical machine or
>> just a VM). As to the problem of migrating git in different platform=
s
>> which equip with different computing power, the git repo should also
>> keep tract of under what big file threshold a specific file is
>> handled.
> --
> Duy
