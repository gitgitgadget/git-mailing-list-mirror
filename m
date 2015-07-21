From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2b 00/16, 2 updates] Make the msvc-build scripts work again
Date: Tue, 21 Jul 2015 13:04:31 -0700
Message-ID: <xmqq1tg1uvjk.fsf@gitster.dls.corp.google.com>
References: <1437432846-5796-1-git-send-email-philipoakley@iee.org>
	<xmqq1tg2xwbd.fsf@gitster.dls.corp.google.com>
	<73004CECB3514744A5916831B4501689@PhilipOakley>
	<xmqqvbdduxd5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdmJ-0006ky-DT
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbbGUUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:04:35 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34441 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbbGUUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 16:04:35 -0400
Received: by pdbbh15 with SMTP id bh15so80116308pdb.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5ZgW39YLp4NfzRwEXERCvoYNBOUmQVr/jA7IV+9MYtE=;
        b=Aya60g5ISWyDib0z3I9aP7P5lJ576AElcvBBIXYIDXprzWvOamGVKD3EnsKnLV0sxL
         DDRzO+JgCgWa2pEVJ57eIUYJp/VCh9S/c7XUv9xfcc3lCVZ01q06zBpHAr12yELKvWBy
         4tl6IA6q0fFJkC4uvrmp6Go45k1YIijtf8ruhNdBrLEpksUb+5b/iG++Av8wjNGClvfK
         T0axlaC7agy8VjgIP0MUDIjxGaXHBC5xdoJoQcV7ZMDiQPgA8mBsPZFsVi4nAmGsRIx/
         oD6cqItYTxB/rzpG5R9II7GLqI+M7Ev0J3xHZVLEzyOrPodBfXMrACr57a9p9xmeADL0
         gLwg==
X-Received: by 10.70.37.144 with SMTP id y16mr76234206pdj.86.1437509074525;
        Tue, 21 Jul 2015 13:04:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id cz1sm29025059pdb.44.2015.07.21.13.04.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 13:04:32 -0700 (PDT)
In-Reply-To: <xmqqvbdduxd5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jul 2015 12:25:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274411>

Junio C Hamano <gitster@pobox.com> writes:

> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> ... Ideally, if part of this
>> mainstream Git, it would get picked up automatically by them
>> (rather than being local 'fixes' endlessly carried forward).
>
> Actually, that is not "ideal", but what I want to avoid.
>
> As I do not do Windows, it simply is wrong for me to apply changes
> that are very likely to affect Windows folks without seeing their
> support first,...

Just to clarify this part.  I do not do RedHat, Solaris or OSX,
either.  Also MSVC may not be what GfW folks primarily target.

But the thing is that (1) Windows is so much different, and (2) GfW
folks are much more qualified to judge platform-specific issues on
Windows than I am.

Even though I may still need to have a say in the overall structure
of the changes to the upstream tree coming from them (e.g. "Don't
sprinkle #ifdef all over the generic code; instead add a wrapper or
two in compat/ to keep the generic code generic" is something I may
tell them when rejecting a change forwarded to me), I trust them a
lot more than I trust myself when it comes to what the changes do in
the platform-specific part and how they do it.

Thanks.
