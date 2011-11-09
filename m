From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Wed, 9 Nov 2011 01:27:03 +0100
Message-ID: <CAGdFq_jPfSFidb59m-5Tsyusw3yQFRnxU9nqBVosVPuzbt86GA@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
 <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
 <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
 <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com>
 <CAGdFq_iY92Gc=WLFVVMpi8w5JNZMo5bSk5=wjHyCmjXmP4RXrQ@mail.gmail.com>
 <CAOpHH-W30umoP6CuvrXgiSPBC2NjLvNWUX0uxhU4SU3kBB4H-A@mail.gmail.com>
 <CAGdFq_hSnywznK=3JgWBVigGZmS0ry_WHuuDww5tvPrcsPd7cQ@mail.gmail.com> <CAOpHH-X3bgJpRpiJMy-iDDpaFbUy8yZK+GFEwVB2vGHd-GpUiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 01:27:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNw18-0001Lp-MP
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 01:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524Ab1KIA1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 19:27:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47187 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab1KIA1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 19:27:46 -0500
Received: by ggnb2 with SMTP id b2so1162028ggn.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 16:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mqGln1/30dGrQLmw7F7DsWn/aj40Z2UtmsF7HDinRpk=;
        b=MZFnHPlC56F3X8X8zRu29CC2WV5I7KRXP08C2UXla4YoQZLH580sAs1jFavw4a7HhS
         GG3wrgl/O1rgsbG0zHmUMRkL30xh2nBZZu2GLtZfBrBBts/8Hk9GaVlFnMPLhXAKJG5n
         Fi/45ZfcTCi3rlKezVBhrWIr+E6+rJP5Rl3JY=
Received: by 10.182.13.3 with SMTP id d3mr30264obc.20.1320798465154; Tue, 08
 Nov 2011 16:27:45 -0800 (PST)
Received: by 10.182.52.3 with HTTP; Tue, 8 Nov 2011 16:27:03 -0800 (PST)
In-Reply-To: <CAOpHH-X3bgJpRpiJMy-iDDpaFbUy8yZK+GFEwVB2vGHd-GpUiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185122>

Heya,

On Wed, Nov 9, 2011 at 01:24, Vitor Antunes <vitor.hda@gmail.com> wrote:
> On Thu, Oct 27, 2011 at 3:36 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Ok, so the problem is that fast-import notices that a tree that was
>> written out as part of a checkpoint is later removed and doesn't like
>> that? Shouldn't we just teach the check about trees deleted by the
>> drop command?
>
> That was exactly my intention when I used release_tree_entry(). But I
> guess I'm doing it wrong, because without the delete_ref() part this
> does not work (just noticed there's a missing semicolon there...
> sorry). Any advices/guidance, please? :)

ENODATA. What do you mean with "does not work"? Can you run it through
gdb and see what's going on?

-- 
Cheers,

Sverre Rabbelier
