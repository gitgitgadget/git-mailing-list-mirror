From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: Re: [PATCH] git-send-email: treat field names as case-independent
Date: Sun, 6 Jan 2013 22:38:15 -0500
Message-ID: <CADGQE7HTB+s2=PWhMZ=1BpU9nruhx5OBhKOY-ngdZJz=vC61uQ@mail.gmail.com>
References: <1357522498-8086-1-git-send-email-nickolai@csail.mit.edu> <7va9sllljh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 04:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts3YK-0001aK-R7
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 04:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab3AGDih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 22:38:37 -0500
Received: from mail-vc0-f179.google.com ([209.85.220.179]:40978 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3AGDig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 22:38:36 -0500
Received: by mail-vc0-f179.google.com with SMTP id p1so19129914vcq.10
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 19:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Hf8SOl0NfYfdKbftQvu9xNaGzV+uA3IYwmq9JsOfYR4=;
        b=fMuY3Bx1yIuDkF5zNGrgDGENLc2MHCXPhxEF1sL1JIgOb1qDiknPX+6BaCS5tz5sIV
         HPLsvYzX4bIqneQdKUrD9FsuYgojv+rQOOaDp1oZocWtjeyKM6IK0GL6t6B1nPWxjJVm
         BajnRsmeLL9XaBlznYfHgxJfYD2ZoNVR2hVKUt+xd6CNPPFjD9RMIsu424rj5ON2i7De
         PtlMltQRQ29OnHaSwBz/rd2SRp7KQ43bF3Qh37zC6mLIw6paLviLCoCgXTOSuHn+BfGM
         NV6PLD4vPdEIjQAuWakkExRUEwrghldBtgf2uQjfK0jJz9vkfmZbxexIPmj22Hf6IpMQ
         bJQQ==
Received: by 10.52.33.228 with SMTP id u4mr71353922vdi.4.1357529915576; Sun,
 06 Jan 2013 19:38:35 -0800 (PST)
Received: by 10.220.70.145 with HTTP; Sun, 6 Jan 2013 19:38:15 -0800 (PST)
In-Reply-To: <7va9sllljh.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: VD47K4PBgQu5C56XH1SxhUFHvbs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212873>

On Sun, Jan 6, 2013 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> While I think this patch is a sensible thing to do, I at the same
> time wonder who is writing "cc:" in the lowercase in the first
> place, and if that is one of our tools, we should fix that part as
> well.  Such a header would leak out to the payload given to the
> underlying sendmail, doesn't it?

In my case, I wrote the "cc:" headers by hand; it was not a result of
any automated tool.  (Yes, the header makes it into the message
payload.  This makes the bug all the more annoying: other people's
replies get cc:ed to the right address, but the original message never
gets sent there.)

Nickolai.
