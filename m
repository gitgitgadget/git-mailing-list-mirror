From: Luke Diamand <luke@diamand.org>
Subject: Re: Git-p4 fails with NameError with python 2.7.2
Date: Tue, 20 Oct 2015 14:57:46 +0100
Message-ID: <CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Etienne Girard <etienne.g.girard@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 15:58:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoXQH-0000My-F7
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 15:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbbJTN5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 09:57:49 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33261 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbJTN5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 09:57:48 -0400
Received: by obbwb3 with SMTP id wb3so14578056obb.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 06:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GF8O+Z/BnGB9LWeSSiqykDNeMfCO0JZeH2N4/NJbzbA=;
        b=LrDe3lWIt5n4YfS6qCRat3ZP1yG4cSBKwakGsOOKEuGnEgu/5wzDVZbmHkeFh9Zpyc
         6GylH5rciEuwEoH0GsedL8F7FuXPqsGgxx9Zqaxb8r0aeIwtxG9IwVQLsIfFX90MSh4A
         YuHJQ1awmC/1Mw7bDTaLWW+OeFyugPeQRhLOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GF8O+Z/BnGB9LWeSSiqykDNeMfCO0JZeH2N4/NJbzbA=;
        b=MxbopO/lC9dfvZ0dr192Z21kXoezJMkTN8g7NMsgmrsyIgxPr3YCj4Fa4u9kWhyunN
         IIlygRPYl/+ynauF7U40Y5Cl5XWFDVyzyt0EaCLcz4K175c4bv/ZnDS2E/baCuUSicrq
         T+kGPKjilAlK1SsanJwsfOTHRJVxmGAE4R7sk8q8zV1of+MErt5SiftLm1zGdiOO9xlt
         /Fo+gD28OSMPXvR5rf+Z/HoSvDIspdoTEqtry4s7ajhJwhEoqFfe5iPLaMNov5m6JNjh
         JWcY3SdZZWeQjGtTCnedr+FDjkFlMTsk/djFCs02K5kxHACNODe27Vn2vNNrK4LFIovV
         u/NA==
X-Gm-Message-State: ALoCoQkJG5K/J/efRigyaPQY5UkVfIIFAHA2Obre35L6pwYepdcqi6GrtZufxRGPEkgUnQzeG3/C
X-Received: by 10.60.67.1 with SMTP id j1mr2048121oet.61.1445349466956; Tue,
 20 Oct 2015 06:57:46 -0700 (PDT)
Received: by 10.60.34.8 with HTTP; Tue, 20 Oct 2015 06:57:46 -0700 (PDT)
In-Reply-To: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279913>

On 20 October 2015 at 11:34, Etienne Girard <etienne.g.girard@gmail.com> wrote:
> Hello,
>
> Git-p4 fail when I try to rebase with the error: "NameError: global
> name 'ctypes' is not defined". The error occurs when I use python
> 2.7.2 that is installed by default on my company's computers (it goes
> without saying that everything works fine with python 2.7.10).
>
> I'm a beginner in python, but simply importing ctypes at the beginning
> of the script does the trick. I was wondering if submitting a patch
> for this issue is worth the trouble, when a satisfying solution is not
> using a 4 years old version of python.

If you're able to submit a patch that would be great!

Thanks,
Luke
