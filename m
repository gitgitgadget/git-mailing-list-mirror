From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Sun, 19 May 2013 21:47:58 -0400
Message-ID: <CAPig+cQV4goutofOhHBYtc1SfEChdOwYvXpcv+pxyZd8qVNZdQ@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 03:48:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeFCn-0001TF-IO
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 03:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab3ETBsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 21:48:00 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40939 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab3ETBr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 21:47:59 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so3657622lbh.27
        for <git@vger.kernel.org>; Sun, 19 May 2013 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=PfXlWl5iI/QaDR0D+6MBVQRvLZAVcsNwOzDF43mGw/k=;
        b=WGal6nkQFFmROUUr6tgOHmy/pH3ghJ3lWAwMPMFPKnR0TQyB/q7S43nkDihFmurm2V
         3AlWmLnhbgDpG/kRdOSSQzbMDMSwOOd4nR/Xqlz37G2i89Mzw7XEDw23Bw4LmSd2YPvT
         hSSRAwb5US3NEjMakckAPo/00KDlaoV1JqBZhpCnI2N6I5VxXDpwsy+tDXavUmu1zrHp
         cttNh/rqg8RmYKzZNWagz7qeS9/uBODbXwfJ7ltuUwycjCiQhEBTaZu/DccqdfXwCmp+
         r1YcPBsrn63BhoEf2TERLlD8cjMjVCK+zlySbO8mrA+vkUy+bc407H3ZzxeOO4tJVKu+
         ungQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr26347067lbb.59.1369014478146;
 Sun, 19 May 2013 18:47:58 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sun, 19 May 2013 18:47:58 -0700 (PDT)
In-Reply-To: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: CVn-xqOgw-3PKqinfCkl-vbDl9I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224930>

On Sun, May 19, 2013 at 11:53 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This script find people that might be interested in a patch, by going

s/find/finds/

> back through the history for each single hunk modified, and finding
> people that reviewed, acknowledge, signed, or authored the code the
> patch is modifying.
>
> It does this by running 'git blame' incrementally on each hunk, and then
> parsing the commit message. After gathering all the relevant people, it
> groups them to show what exactly was their role when the participated in
> the development of the relevant commit, and on how many relevant commits
> they participated. They are only displayed if they pass a minimum
> threshold of participation.
>
> For example:
>
>   % git related 0001-remote-hg-trivial-cleanups.patch
>   Felipe Contreras <felipe.contreras@gmail.com>
>   Jeff King <peff@peff.net>
>   Max Horn <max@quendi.de>
>   Junio C Hamano <gitster@pobox.com>
>
> Thus it can be used for 'git send-email' as a cc-cmd.
>
> There might be some other related functions to this script, not just to
> be used as a cc-cmd.
>
> Comments-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
