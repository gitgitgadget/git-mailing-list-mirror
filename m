From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Sun, 8 May 2016 16:51:46 +0700
Message-ID: <CACsJy8DtFLkfqSHRjFU4N9H9C3MfVOn-XEy4yOwneQaatvvDkQ@mail.gmail.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
 <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com> <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
 <20160427101833.GA5536@lanh> <xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
 <20160501002852.GA3963@lanh> <20160501060009.GA30748@lanh>
 <xmqqk2jcuzx7.fsf@gitster.mtv.corp.google.com> <CACsJy8B16SWsu5xTHdPcR4dz4_z+Br5EGGbJ+B5SChA=sWo-bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 11:53:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNw-0003EA-Ux
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbcEHJwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 05:52:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36061 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcEHJwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:18 -0400
Received: by mail-lf0-f67.google.com with SMTP id y84so17996984lfc.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fE8KJzOLmVYQaCguKDbixoaO5ZM6aHOViHR8+5KeNcs=;
        b=X8jJvp1c9yYfNvKSRdSoCPq6GX63aSrqzRAz/hkkn63wzVFvgD98YIyldxvhG0OpuE
         T5H3NzJIM9vzkrt1jVZ4bPMNUC1vlO/bkULh1ugVzMOz2CAhLgSE7kwU8c850Ew9hv2d
         xvPGvfXh45icmdfh3iuur4+x8oAUY9d633T+JiQRm1v9AVtj7EvCoavdDL+XR7l5PGFK
         ZG9Csx3WTmb56LQSZiZfJVI4kME6EyCfCWFCrvEwpOx4YxQkXTbqOWMLOgFrcl7ODe4f
         z3lATgd3HFlEdroq0R5Rc+ALWbgxAWoR3GmiHxbrPH4PAkKFxDubgcpkSD7dFbeKIMqI
         9AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fE8KJzOLmVYQaCguKDbixoaO5ZM6aHOViHR8+5KeNcs=;
        b=k9+dK5HHv8K8E9LGO7G55HkEa+abouFsLfcgGJg7WFxz5ey1dccCYBebEw5JLhwBl5
         Mf0yt+qoOuaGKEC7xjibXIaWuIjQxb+pA+ibH6vCL0nAYK++/TDVs0SF+q81KiilapDk
         avAZC1f8SJH8haqqskjSLX4nyxI91t0dB5Ob9Ko2OYGlNOU0RKrbmoEzkRksLsM3qVqC
         HHWuAaUEfNkZipF4e64lOdNTQj521lnSENyUHwvmLlQEQW4sKwPX87Rj02BrJcqK4fyN
         wL3EE6wzgB8Ckck3xFh6xJSYaCk2S9sMmltrYzSBwpdEUuriySxTKQ4/hXr7JipE3w2S
         BwAQ==
X-Gm-Message-State: AOPr4FXURExYYLJNBi6jotAYIfyNhJhUmCu2FspMbvBpBzJaSLks3D1TI3VOuB1cFOGTPWTzd8JCNhE0IeNTIw==
X-Received: by 10.112.199.198 with SMTP id jm6mr13433692lbc.80.1462701136536;
 Sun, 08 May 2016 02:52:16 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sun, 8 May 2016 02:51:46 -0700 (PDT)
In-Reply-To: <CACsJy8B16SWsu5xTHdPcR4dz4_z+Br5EGGbJ+B5SChA=sWo-bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293946>

So among the options we have so far, which way should we go, or leave it as is?

On Tue, May 3, 2016 at 7:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 3, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> I may have rushed to judgement. wrap-for-bin.sh has always been the
>>> dependency for bin-wrappers/*. If we force that file to change, then
>>> bin-wrappers/* will be recreated when switching branches. So how about
>>> this?
>>
>> I do not think you are "force updating wrap-for-bin" in any way in
>> the patch, though.  You are building it in such a way that it does
>> not have to get updated within the revision that contains e6e7530
>> (assuming that this will be queued directly on top it and merged to
>> everywhere e6e7530 is contained).
>
> Yep.
>
>> The new case/esac looks somewhat bad (its knowing that where test-*
>> lives, test-* is the only thing that is special, etc. troubles me at
>> the same time that case/esac is funnily formated).
>
> We could just make some random changes in this file. That would have
> the same effect.
>
>> Where does "@@PATH@@" come from and who rewrites it?  Is that a
>> misspelt "@@PROG@@"?
>
> Yep. Should have run make distclean before testing :(
> --
> Duy
-- 
Duy
