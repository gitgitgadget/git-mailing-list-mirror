From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Tue, 3 May 2016 07:15:38 +0700
Message-ID: <CACsJy8B16SWsu5xTHdPcR4dz4_z+Br5EGGbJ+B5SChA=sWo-bg@mail.gmail.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
 <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com> <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
 <20160427101833.GA5536@lanh> <xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
 <20160501002852.GA3963@lanh> <20160501060009.GA30748@lanh> <xmqqk2jcuzx7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 02:16:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axO0i-0007X1-QM
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 02:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbcECAQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 20:16:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33259 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbcECAQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 20:16:10 -0400
Received: by mail-lf0-f65.google.com with SMTP id p64so408070lfg.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 17:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i0+WZa1ACTxWRCmod+FoRgxl5i6NRoGO0szMEnj1ASU=;
        b=K516k9CA2idxxmndjlmck77lvqLZNpj/MvxO3am4CXCBKd+267Kem/MWyWng+9ZbiQ
         3/E/jwtxQG4NS/P81WtMR46JljNKxniu/RQApfP7SyG4wlRGsLFWDWBRkQOVpTQBSMt/
         CjIjcbjByO1wAZ8XZq/LsGz9giZLxY54FwTPYIqvMPSL7Vfy7LN0TPFlYPc4a9YzzpS7
         uwRH6aRo7oc6EXCk9PrYDim4kUtA1PsFK/RXRfKOoHXmgvQi62KMx06vLuaHrCjuCeaU
         7bPuqkKJbHXXNKvzJeH3UPccIZIkOboZVcWHlHEBixfvfZvfP+jnV+c+XYjKerSyVDc1
         JpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i0+WZa1ACTxWRCmod+FoRgxl5i6NRoGO0szMEnj1ASU=;
        b=Ybef6NOn9Tgm5t6FspUGWreGchxxc36TdquuLPPvVvw51Y0KmayGCskyyuBuvD9XMr
         0kaI5Tibzr7X8Csx3MD2aEM6RmN21K3voZZSNGwG5yAPzJCFfeoIn9KbXGv7L47bB32v
         Yu9mId6/Yo3jnSS23K/IoWozd5MTXLMC6kA8r71YD7VBUWtkSMXv+9xrc3i93oCWeyOY
         74EAxWHDEpjicrmoqwK713PA33M8TDGFONeiF1LdvGXyV9VXswdd/kre5NKU5u3FQGFZ
         2cjavAEvZBHfmKmBRv+sOVo6sLh/oI5X88tUFvfIv5poS94S62y5Wqf6FyXzBYOa2SBj
         Z16g==
X-Gm-Message-State: AOPr4FVj5wow9ia8cApYeQrj/hjeNYwnnkDu0WBEcBvm5agXpju5vNdtdEBrYUyX2bc/kZr/ijTFmMUy8V5Ckg==
X-Received: by 10.25.211.75 with SMTP id k72mr15593890lfg.45.1462234568475;
 Mon, 02 May 2016 17:16:08 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 2 May 2016 17:15:38 -0700 (PDT)
In-Reply-To: <xmqqk2jcuzx7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293311>

On Tue, May 3, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I may have rushed to judgement. wrap-for-bin.sh has always been the
>> dependency for bin-wrappers/*. If we force that file to change, then
>> bin-wrappers/* will be recreated when switching branches. So how about
>> this?
>
> I do not think you are "force updating wrap-for-bin" in any way in
> the patch, though.  You are building it in such a way that it does
> not have to get updated within the revision that contains e6e7530
> (assuming that this will be queued directly on top it and merged to
> everywhere e6e7530 is contained).

Yep.

> The new case/esac looks somewhat bad (its knowing that where test-*
> lives, test-* is the only thing that is special, etc. troubles me at
> the same time that case/esac is funnily formated).

We could just make some random changes in this file. That would have
the same effect.

> Where does "@@PATH@@" come from and who rewrites it?  Is that a
> misspelt "@@PROG@@"?

Yep. Should have run make distclean before testing :(
-- 
Duy
