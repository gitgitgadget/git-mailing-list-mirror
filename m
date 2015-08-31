From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Mon, 31 Aug 2015 17:10:29 +0700
Message-ID: <CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com> <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:11:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWM3L-00009Y-Lm
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbbHaKK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 06:10:59 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:32953 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbHaKK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 06:10:59 -0400
Received: by iods203 with SMTP id s203so152587666iod.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Eh5Lp0nsmtBwjdTSOkaCtAEdFVQfPQBa0KBjgILZ2kk=;
        b=GhlZCMcRt2B9333FOuDnjOXVC7cnNYidTT/8/naVS60Rn5hKg1Cm0Ohpx9qT0jpIO/
         Lr1djjlMAIN8+jqaV0t7poXaKrjB9V5ydVeHIvrUYCppR82W6UJDQ09Wcl5bmzTgOBfX
         SZThdDcGyibS8C46CaWoq38eaU9bU/oPIs/juGnWSiQKpL7QZZ+yM7dL5RGgoN9suWAP
         ilIttA3ytBlMNwzSQnJUARcOmJAqe9wyXmwMR+bq+C9bPtuvqrMUzSmGxIQ3DEZek9hD
         mSAhAXqbgLwMeSP32dsK+Vfc0MQjd7KOe8EgOcApNqyHwmNY/qsvYuf3nE37AXtTSbNO
         3BTQ==
X-Received: by 10.107.9.11 with SMTP id j11mr22494916ioi.191.1441015858680;
 Mon, 31 Aug 2015 03:10:58 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 31 Aug 2015 03:10:29 -0700 (PDT)
In-Reply-To: <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276865>

On Wed, Aug 26, 2015 at 6:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>
> I do not see a good way to do such a safe transition with command
> words approach, *unless* we are going to introduce new commands,
> i.e. "git list-tag", "git create-tag", etc.

I'm probably shot down for this. But could we go with a clean plate
and create a new command prefix (something like git-next, git2, or
gt...)? We could then redesign the entire UI without worrying about
backward compatibility. At some point we can start to deprecate "git"
and encourage to use the new command prefix only. Of course somebody
has to go over all the commands and options to propose some consistent
UI, then more discussions and coding so it could likely follow the
path of pack v4..
-- 
Duy
