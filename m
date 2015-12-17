From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/4] git-gui: remove duplicate entries from
 .gitconfig's gui.recentrepo
Date: Thu, 17 Dec 2015 02:45:14 -0500
Message-ID: <CAPig+cQd2f7zHJAwS29-zuL3xvC2thu9pvU-i1GXVTm_3E6rAQ@mail.gmail.com>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
	<1450105743-2432-1-git-send-email-philipoakley@iee.org>
	<1450105743-2432-2-git-send-email-philipoakley@iee.org>
	<CAPig+cQ8=WKwew5GNqyAPFuYJDgM+ae6rxaJQg=jhrxn61rNbQ@mail.gmail.com>
	<B283141DAA2647EF9917F27A817CC7FA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 08:45:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9TFb-0003Nj-C6
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 08:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbbLQHpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 02:45:17 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34591 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbLQHpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 02:45:15 -0500
Received: by mail-vk0-f44.google.com with SMTP id j66so41612540vkg.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 23:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7jI+vA/eT5gjnosPiWM68qq3qfT6eDxN4GNNYbriw/4=;
        b=nPorogQQULUJlnYUZfemxbJL8aZtAqqM/yFibbPKsaTxhE+O3s/RG/Xlv9eCBw6mKe
         NTbnbDFeEEs1vJqZTR4udpMisQ2LyVFs04wdHtbHDkp5bjSQ5BwlMnr6CYjF3Y3FpFN7
         sIMizaRZ9ln5MxiXRon60bn/QPt0yBZyA9/cZAlRyVvzruG8KfTR/RFv13u5EAvTrLeW
         edDu1lB7CFkC+UUEdFWkh/5BzmdppbBEESoR7QYH4gmMAyzaueoNK3kjGQN3Ae3Cw33i
         XlXGpjWxkij/pib/hub57qyG4DVVAkK13TEcDOHv5g7wE4IehO4wu+WpnnBht+gCCeqD
         qcsA==
X-Received: by 10.31.56.18 with SMTP id f18mr33226126vka.19.1450338314434;
 Wed, 16 Dec 2015 23:45:14 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 16 Dec 2015 23:45:14 -0800 (PST)
In-Reply-To: <B283141DAA2647EF9917F27A817CC7FA@PhilipOakley>
X-Google-Sender-Auth: _eS2CT_Omzo8nBk3zA0H6xhc8L0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282636>

On Wed, Dec 16, 2015 at 6:41 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
>> On Monday, December 14, 2015, Philip Oakley <philipoakley@iee.org> wrote:
>>> The git gui's recent repo list may become contaminated with duplicate
>>> entries. The git gui would barf when attempting to remove one entry.
>>> Remove them all - there is no option within 'git config' to selectively
>>> remove one of the entries.
>>>
>>> This issue was reported on the 'Git User' list
>>> (https://groups.google.com/forum/#!topic/git-users/msev4KsQGFc,
>>> Warning: gui.recentrepo has multiply values while executing).
>>
>> s/multiply/multiple/
>
> The original report has that mistake. I'll quote the thread title.

Ah, I had checked the screenshot included with the original report and
saw that it was correctly spelled, thus assumed that the typo was
yours. I didn't pay much attention to the title in the original
report, which indeed already contains this misspelling.
