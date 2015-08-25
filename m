From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2015, #04; Tue, 25)
Date: Tue, 25 Aug 2015 16:38:09 -0700
Message-ID: <CA+P7+xph-EtxL1sB71uF5qH=VmTM1YwZF9+Y3ez0-VmpWWjytw@mail.gmail.com>
References: <xmqqegirvtg5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 01:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUNnV-0006nM-GL
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 01:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbbHYXia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 19:38:30 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37728 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbbHYXi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 19:38:28 -0400
Received: by igui7 with SMTP id i7so23898407igu.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EQXucs8Av0FIPgSN0UNOHZVlCJxO/nZevN9HXDy/C60=;
        b=iAn2+ARyNB33Vv1f6f04nTnrn4Jv6OBzV40UsuT5wsfcw9Zy2r1UyDrFGdwSUwOV1f
         6KVKjibUon/TKPAEsd8KQ0MnOYEptv2fEVt5f+ncwS67mapEXmaolboJoKj1HhTNfUCx
         B3+ludnQqcIS8MXBhom83VgVoQ/F1D/ujPlX/CzYqXgoUoIAeGiUHp2+A5bdJp3cgGTg
         aIutuNpJB4YhHHho5mAhBiL2exHHMBnNJ21QpWYciRg4G0zztu0UEHoe9ygMK8Qn1sOd
         q1JRqlvctMiiilPbiG95CuoHURJE/6u8V2RrO/OJFvVTp2mY72jewov0AY2sEtUmCCDj
         f2QQ==
X-Received: by 10.50.118.104 with SMTP id kl8mr7162658igb.92.1440545908335;
 Tue, 25 Aug 2015 16:38:28 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 25 Aug 2015 16:38:09 -0700 (PDT)
In-Reply-To: <xmqqegirvtg5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276586>

On Tue, Aug 25, 2015 at 4:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * jk/notes-merge-config (2015-08-17) 6 commits
>  - notes: teach git-notes about notes.<name>.mergeStrategy option
>  - notes: add notes.mergeStrategy option to select default strategy
>  - notes: add tests for --commit/--abort/--strategy exclusivity
>  - notes: extract parse_notes_merge_strategy to notes-utils
>  - notes: extract enum notes_merge_strategy to notes-utils.h
>  - notes: document cat_sort_uniq rewriteMode
>
>  "git notes merge" can be told with "--strategy=<how>" option how to
>  automatically handle conflicts; this can now be configured by
>  setting notes.merge configuration variable.
>
>  I think this is ready for 'next', but did I miss comments that need
>  to be addressed before it happens?
>

I believe I got all the comments fixed in the most recent series. I
was not aware of any other comments so if someone has them letting me
know would be helpful as I had no plans to re-roll anything at
present.

Regards,
Jake
