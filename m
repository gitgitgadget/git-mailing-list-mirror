From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-compat-util.h:rewrite skip_prefix() as loop
Date: Sun, 2 Mar 2014 00:02:16 -0500
Message-ID: <CAPig+cRkRZkjTB4WpQTKxfAofC7iqn8HZvU03egQhMe0NJktpQ@mail.gmail.com>
References: <1393680724-19983-1-git-send-email-siddharth98391@gmail.com>
	<CANQLRip4zpOuF=GUsuhsQtQ4z5Z9VtCHo8yBb6vL3npuMHHgZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Siddharth Goel <siddharth98391@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 06:02:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJyXd-0006it-5b
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 06:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbaCBFCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 00:02:17 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:57890 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbaCBFCR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 00:02:17 -0500
Received: by mail-yh0-f47.google.com with SMTP id c41so2445644yho.6
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 21:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YTKuCSF1/C7eW054I1AJNn2CNp/ohycIrLp9UU2vnaA=;
        b=jSJiVt6LUs5Qh9I43zj6xNrhLEQtFwERrlO/sAI6IOKMfNVu6Xod5/djHiDT+GBzCm
         EpsAoeIhaftuUbp7kidMCghAqlSDuuFAm2XKCG+xe8yemYkrOQk/nJQrwI6Yz++7UghG
         h4R8N2NXnJc7f/p8+8qAQcqXaAi4NdbfmOWiUOIMXW7YIixGWG/t9typ08toUkAk/iTh
         SKhAxnNhWLBq8rEwWMKq61YhUprvDrJtYdBOs0uSHyOBbkuWHzTGlAhYx/okaOBcTSEt
         7WorEwalAmd+ITrw8eRUTlXGjYY3KVFgYaJoRTu2PhoAwUt8LzchuB+wmFLjN+NVekgX
         xldA==
X-Received: by 10.236.120.147 with SMTP id p19mr13601668yhh.6.1393736536547;
 Sat, 01 Mar 2014 21:02:16 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 21:02:16 -0800 (PST)
In-Reply-To: <CANQLRip4zpOuF=GUsuhsQtQ4z5Z9VtCHo8yBb6vL3npuMHHgZA@mail.gmail.com>
X-Google-Sender-Auth: _IytEHAKicvZK2XR0XI-XBGbwJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243133>

On Sat, Mar 1, 2014 at 10:22 PM, Siddharth Goel
<siddharth98391@gmail.com> wrote:
> To my surprise, git format-patch had removed the Git Notes that I had
> put to my commit (regarding GSoC). I have written this patch as a part
> of the GSoC 2014 MicroProject for Git.

You probably wanted to use the --notes option with format-patch.

> Going through the mail-chain I
> observed that many students have attempted this Microproject. So is it
> ok if I stick to this Microproject or should I go with another one?

That's okay. The purpose of the miniprojects is for you to get a taste
of what it's like to contribute to this project and to understand what
will be expected of you as a GSoC student; and to give the GSoC
mentors a chance to judge your abilities and observe how you interact
with reviewers.
