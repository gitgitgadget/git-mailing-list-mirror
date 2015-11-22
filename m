From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v1] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 09:56:14 -0600
Message-ID: <CAOc6etYXHjGRT7dBsP835VntTQL2NyQnYTQXwbzreBR-5sSiSQ@mail.gmail.com>
References: <1448169116-32335-1-git-send-email-eantoranz@gmail.com>
	<CAOc6etbfzrqT4-5dorCAq_=5Oh9wXV4LgRwK9hrEqjmSYHiBEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Max A.K." <max@max630.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 16:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0X00-0006B6-T2
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 16:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbbKVP4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 10:56:15 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35481 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbbKVP4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 10:56:14 -0500
Received: by pacej9 with SMTP id ej9so166029209pac.2
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 07:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5mjM9YB/9lb6UVUQiP+JKkMcdNrOIYle0q2iGRRejIo=;
        b=MBI3aHLqxNUbgshCYXgjPwjKor3m5U8iZMkANa4MV0jRVgE6WbL2anrl8UGz8r5BvA
         mHeUGv5eLHodmi3t7pdbIYChpzezz9pdBtW+BPfGusDt10ER+gDISqaMaA/J05bjehOi
         svbD+j4/CaZpafjOJv0yZNbsGKXPL+vqAJr5niU996zxAK+jl5Q5ljCM+vxPrAn2zs6t
         lltHtZaT8BJIVZ13aa4S1zNg/hhps7+faXM9E1ByyHXbHNqGjAyx5PSDGTUKJkNpFWO2
         Kxvebo6PnqNON9TAEMr/sAh68r5IZ5Kts2xUxLQyPMzNsWaWo5omOeZZoPMYhACKk607
         Kf8Q==
X-Received: by 10.98.1.6 with SMTP id 6mr11005223pfb.132.1448207774331; Sun,
 22 Nov 2015 07:56:14 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sun, 22 Nov 2015 07:56:14 -0800 (PST)
In-Reply-To: <CAOc6etbfzrqT4-5dorCAq_=5Oh9wXV4LgRwK9hrEqjmSYHiBEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281565>

On Sat, Nov 21, 2015 at 11:27 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> -static void assign_blame(struct scoreboard *sb, int opt)
> +static void assign_blame(struct scoreboard *sb, int opt, int show_progress)
>
> Would it be better to include show_progress as a binary flag in opt
> instead of a separate variable?

What is the point of having 'global' variable and not using it as such?

I'm sending a second version of the patch where I'm taking care of
most of my previous comments. Let's hope that one holds water.

Thanks in advance.
