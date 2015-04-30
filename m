From: Paul Tan <pyokagan@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Thu, 30 Apr 2015 08:18:25 +0800
Message-ID: <CACRoPnR13XZURd4MxiqEQk3tYQmaO-3H4TrV63LMyd+VzvAJDQ@mail.gmail.com>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
	<xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 02:18:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YncBT-0007YM-QA
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 02:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbbD3AS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 20:18:27 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36568 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbbD3AS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 20:18:27 -0400
Received: by lbbqq2 with SMTP id qq2so32513264lbb.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=diVptZ85rJTNaAiTV23/nEuLTHV3Rk1r/dkFBgaL1Ts=;
        b=FhR/wfY8iTZnPUwWslvpOXElTB6KlVw/kaxSUaz41qc4JlYJUiYzFEAN7zpmMxPABl
         iaNVsXj345ll0++eQQnxp7VQZ8rnzmVFKa9gegeSvtM43SsMys9l6kTarp4NbgJMjnGu
         V0uvNUQedZ/2BJA1qaJdIjuGHC12cdtVkhAc3gpY0aNsodTnCn38y7up/y2dlnBCdlfr
         fKyynG8qQqnQhU6EmyeYG3/FmJZ03ehn14oPzwKZMg74bi4X4rMUez3WYan5NEhWT+HG
         bAMc6PGM9EN03Nk5pY94bVgwFCeVur2RGN3QVeCQ8wLw+KqYdkN1PFtWCGnF2i7uYXAv
         ARKA==
X-Received: by 10.152.120.70 with SMTP id la6mr1364740lab.65.1430353105876;
 Wed, 29 Apr 2015 17:18:25 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 29 Apr 2015 17:18:25 -0700 (PDT)
In-Reply-To: <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268038>

Hi Junio,

On Thu, Apr 30, 2015 at 6:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> * pt/xdg-config-path (2015-04-12) 7 commits
>>  - path.c: remove home_config_paths()
>>  - git-config: replace use of home_config_paths()
>>  - git-commit: replace use of home_config_paths()
>>  - credential-store.c: replace home_config_paths() with xdg_config_home()
>>  - dir.c: replace home_config_paths() with xdg_config_home()
>>  - attr.c: replace home_config_paths() with xdg_config_home()
>>  - path.c: implement xdg_config_home()
>>  (this branch uses pt/credential-xdg.)
>>
>>  Seen some discussions.
>>  Waiting for a reroll ($gmane/267518).

Only the first patch of the series needed changes, though I'm waiting
for any final reviews. Do you need me to resend the other patches?

Thanks,
Paul
