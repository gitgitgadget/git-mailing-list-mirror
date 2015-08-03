From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Aug 2015, #01; Mon, 3)
Date: Mon, 3 Aug 2015 18:41:02 -0400
Message-ID: <CAPig+cQr6tZeYwH3W4NP9_6udD2qz7t6vFR7n4haqJLrNhM62w@mail.gmail.com>
References: <xmqq38006mod.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMOPw-0004lK-5i
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbbHCWlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:41:06 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33952 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbbHCWlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:41:03 -0400
Received: by ykax123 with SMTP id x123so123542084yka.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CzsC3vNtqixQbHQoFpX0U+tGLaJLwm+PdGoQS1Fmrb4=;
        b=Jd7/9aMDoNwC/mj+08KG8kinRBE2NKcr9e9lp4tpTxSiKx1MGCGXsI+M34wveeS3iH
         kF+YCgYsTh5NkP4gOtf8j6XAPI/u81yW4K2sL3Y77H1QslfS/Y2yDlZkqnGZiA+nL0yF
         WHzobmQWTEU4fY0uJLxEqZAighEeJtNDYheQ8sfUQm13TttnwKt6T7Iaww1ISBxZRPQV
         fPV0qd6eC+KanBrlNkPV69McqXp7r+75l5fKlmP2N3sj89zMOFTFSEBxkdPVvmsWL/Jv
         IEEPmPiGtO8aKNSarLQEmGcH5jZFCIdjoZvC/pmLfGLNKyPbkDCUoGICWwWbSIJh+CQw
         K/nQ==
X-Received: by 10.13.221.213 with SMTP id g204mr475812ywe.48.1438641662682;
 Mon, 03 Aug 2015 15:41:02 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 3 Aug 2015 15:41:02 -0700 (PDT)
In-Reply-To: <xmqq38006mod.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: kweloxNmo8BteO00SqgGxK7y4G0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275223>

On Mon, Aug 3, 2015 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I've kicked a few topics out of 'next' back to 'pu' for now.
>  - I think es/worktree-add and es/worktree-add-cleanup are good
>    shape overall, but we probably would want to make them into a
>    single topic.

Is there anything I need to do to move this along, or is it something
you will be handling locally?
