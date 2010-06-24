From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/9] Add memory pool library
Date: Thu, 24 Jun 2010 22:20:41 +0200
Message-ID: <AANLkTimeWwsodoVK-9Yx65MBOk0IhgxxVgAjGpIuHUE7@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624105339.GC12376@burratino> 
	<AANLkTilItX_xbbpX9mfKg0Dfx6ThzYuVsBu25C_-fJ6W@mail.gmail.com> 
	<20100624185521.GB1848@burratino> <AANLkTikNV0m5E7982wY5wdtcMstpfKKMX4MdZvdhqhOb@mail.gmail.com> 
	<20100624200641.GA2209@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:21:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsv9-0007Sx-5Z
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab0FXUVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 16:21:05 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39477 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab0FXUVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 16:21:04 -0400
Received: by gxk28 with SMTP id 28so999525gxk.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=S2UJ6kNQt8ev00eT0IujCHNCSlMppAXVgoFcXU3cMv4=;
        b=haULOF2yKgsoSTweaZCy2OBbn6uVGAvkLhTGy7zP2MywvyleTiWoEERbiWdDPFCFC5
         2uw7LmkGtHasGnw+xsqVTMtFJraO5DSad0G+9PY8XpQqDmKz/sLqctQKN2cG3Oqe1nW2
         uam6gX+UIPzL/uCMfPsafOT3nFjg+TryIL8bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oZnNtGzQKwCIxBOffGLEScVvju2o8ckdiVyR8EIS5J+OnIWIkEirZCzwWIOMhrtJ8B
         b1UMkpSvGTNq5N1V49+xlyqmUxePiqqQtkV1NVz5F8yMNQ/vJXkI50CL/znz5WR1b0ua
         OwQVXCrhbYcvvMsBs2XOHYrFgRNKm5fvhE3h8=
Received: by 10.229.218.21 with SMTP id ho21mr5716005qcb.102.1277410862158; 
	Thu, 24 Jun 2010 13:21:02 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 13:20:41 -0700 (PDT)
In-Reply-To: <20100624200641.GA2209@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149635>

Hi again,

Jonathan Nieder wrote:
> Thanks for this list. =C2=A0Do you think it=E2=80=99s worth automatin=
g its
> production? =C2=A0i.e., a masochistic person could write a script to
> compile with the __attribute__((unused)) suppressed, parse warnings t=
o
> find unused functions, and then take an intersection of sets to
> confirm that no family of functions is unused.

Er, I think that's a bit of an overkill :p
Someone editing the code can always suppress MAYBE_UNUSED and check
with our list of unused functions in the comment by hand.

-- Ram
