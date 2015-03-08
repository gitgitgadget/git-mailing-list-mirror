From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is
 empty
Date: Sun, 08 Mar 2015 11:06:13 +0530
Message-ID: <54FBDFCD.9030703@gmail.com>
References: <1425640688-26513-1-git-send-email-karthik.188@gmail.com> <CAPig+cTkC1Y1sWJLpG0iUHju3GOMnvOT-nsAU51GykeV2QB+vA@mail.gmail.com> <54FAD7D7.4030008@gmail.com> <CAPig+cRDkoH-zmYhk9ag+Yiwg1h452hOpS2fx2H5xmu5KUNqiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 06:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUTva-000788-73
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 06:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbbCHFgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 00:36:18 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46449 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbCHFgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 00:36:17 -0500
Received: by pabli10 with SMTP id li10so63479123pab.13
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 21:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FneyEeHnvjJKch61Q8PzGQ+/c9Ax649KscwFqRAQ69w=;
        b=WBP7L/W4X5XJfFAwLnk6Z8KYpLFx9hs1c6asL94LM4XhVFFKqiNDC7s7ujCdPjrdRX
         kQK7ES/psNP9dC71D1yKhdoK90nZSS77zEEEycQD5TmQ1PDXotLmKhI85Nd+IDeFWfha
         KXJ4d3+x6cibm2D0d17J65vkIczoNNj4Bbl/nw4tshcK4Ry8RSYlpGL2O6KNfMNTt/lL
         4KE/BWa73hOyX+lNddewIc2AtHEplstT8mC0c20YJUVuyXNV27DLdstkP+XKQQxpmyv5
         6i8SkTAWCryaRHhxQd5NQpgbCQqlImpH9DlChtgOkaYqHv5u5xZu7Ymgp0PMdiRujprX
         n24g==
X-Received: by 10.68.68.240 with SMTP id z16mr40027410pbt.77.1425792976840;
        Sat, 07 Mar 2015 21:36:16 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id bt2sm13932293pad.12.2015.03.07.21.36.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 21:36:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cRDkoH-zmYhk9ag+Yiwg1h452hOpS2fx2H5xmu5KUNqiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265031>


On 03/08/2015 10:08 AM, Eric Sunshine wrote:
> On Sat, Mar 7, 2015 at 5:49 AM, karthik nayak <karthik.188@gmail.com> wrote:
> >> This iteration looks sensible, except that the Subject reads
> >> strange.  Will queue with minor tweaks to the log message,
> >> and perhaps with a fix to unreadable *(*argv)[1] that was
> >> mentioned elsewhere.
> >
> > Hey could you tell me what seems strange, so I can improve on
> > it the next time.
>
> Junio means that you somehow botched the Subject: line when you copied
> the commit message I suggested into your new version of the patch.
> Instead of <path>, you wrote <treat>.
>
Oops! I'm too anxious i guess.
> > Also "*(*argv)[1]" seems more readable to me, maybe more of a perspective?
>
> I also had considered suggesting (*argv)[1][0] as more readable, but
> it is primarily personal taste, and I didn't want to bike-shed the
> issue.
>
Thanks.
