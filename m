From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/GSoC 3/3] Nousage message in error
Date: Thu, 24 Mar 2016 12:54:10 +0530
Message-ID: <CAFZEwPM_YBD+gd0huxfi9c36imU5uG03S+x6HQQrHEVwxnMXrA@mail.gmail.com>
References: <1458785018-29232-1-git-send-email-dj.dij123@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Diwas Joshi <dj.dij123@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:24:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aizct-0008J2-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 08:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbcCXHYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 03:24:12 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35910 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbcCXHYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 03:24:11 -0400
Received: by mail-yw0-f169.google.com with SMTP id g3so48849432ywa.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5JPcSrN9gku0fYFMRutH39dB4RQEL9ZrEwdfR+DzDdA=;
        b=BJ2TMfWCMsNvRjsGDSAnoi/mU7IdzdFQ+3/GKywSDTfoqKO1XR4cowD3ghPXavyCUP
         NntynpfKoTBbCk5esR7kX9kBxs/5l04LD0zWQh8xHT7INsSeDLfZd9h1sVAeFKS3SpLE
         hlu+jeQ7ZF+L8VThXxHURDJj31vN+l5ZMdpaocTLNtdj1q9Dldi3MY+gomdJ3lw5GHP4
         DeExKWAZVAhHwN/DXz7qXgn/vmL7PEVCOfaGRAIR/LUzAgNu57rfeK1DrgyS91FmVOAo
         KWwdEWbY+as0RR5Kpuf6jrKBiP/wuu10nLMkmRPmrJ3mnlziiJq3fqufJMBNRuYuZfCa
         c09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5JPcSrN9gku0fYFMRutH39dB4RQEL9ZrEwdfR+DzDdA=;
        b=Hb+VKkptkh7cBsqkQnAIg4WK3fcSL2VJYpCalJU2+r6O4xo/heRYPmeYLrOZ7Qt8XA
         9GGxJRcEzlXAtNGBzMtDJ3NEAG7jr2EYbkkWU47YmWnRG246GsgKYgPTZ2qo7zEMPp4T
         Lxf2tAwoOGEAFND3gXqGu6101n7Xe6Bd3N7b8GGJcU4qcrwL7dAro1ZxAQ7c5svL2Q9Z
         fUX7YUviOox/e97gCIbGLlrKVu70vryvWh5UGBNbP+NS6KWMWhKwgQrprpz70ll42Z6I
         5FrxqBQzDwYNCT1BHoBMs1vHz3QsPTyXCPxr2BluMnO5tPZRRkrUHSFuYKzt1i+rwMbO
         vniw==
X-Gm-Message-State: AD7BkJKK1GKn6R44v5bMyZbA5DOmjSgywWb9TYLKBsbGmZ5leLkHL4tI9c7XXsokHq5lUnbk/md79fBPjlAPNA==
X-Received: by 10.13.252.67 with SMTP id m64mr3812923ywf.67.1458804250234;
 Thu, 24 Mar 2016 00:24:10 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 00:24:10 -0700 (PDT)
In-Reply-To: <1458785018-29232-1-git-send-email-dj.dij123@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289718>

On Thu, Mar 24, 2016 at 7:33 AM, Diwas Joshi <dj.dij123@gmail.com> wrote:
> - To show only error text instead of full usage message
> - Adds exits to callback function in parse-options-cb.c instead of returning -1 which results in display of usage message.

I forgot to mention that this microproject is already picked up by
someone else. Try attempting another microproject from the list. The
thread for the discussion of this is :
http://thread.gmane.org/gmane.comp.version-control.git/289312/focus=289336
