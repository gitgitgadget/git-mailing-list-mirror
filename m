From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Tue, 10 Jun 2014 19:30:23 -0400
Message-ID: <CAPig+cQ13nATVpZFZhFLB0Bm9eBLQEyuZkao02ERNzkbGNLEGA@mail.gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
	<1402318146-5062-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuVUq-0004zk-IF
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 01:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbaFJXaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 19:30:24 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:54920 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaFJXaY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 19:30:24 -0400
Received: by mail-yh0-f47.google.com with SMTP id v1so2259797yhn.34
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1XHJshDJOhO2IxX1C9yJ9m+w2IC+J0II7N7Up5UWg7U=;
        b=YTOZrTMvp1OeZlJ63RVXup6M3Q1cQcUKkZ+jS6oxcMPjSdHOgkGC2So8vNst0wXjp+
         7NKtQgV9cPTwHuPDWQjpcfMFBp3+Hq7VgX2gwHe99CFcINno2buqkvOv/3Kc+FxKOnuh
         +NSuKkZiGz8LaQnkKuV3x9FI7EsqJ2dGWNAXllnbdNzL9SmlBJBAXGNZA0fm0FdQNpLt
         usjcn+uhL2dUaDAKxuQBwg/3K0LI3FqDf0ioHFLKxephHTbIxcxU7kMDqwUfb+Y2J97N
         zxvfUCcOwoNENihRdVJ2zTbTn+EkwEe+3zQpWEH+cNtvD5h6jNuT0hZerASKpwZNZyPb
         Gx3Q==
X-Received: by 10.236.176.197 with SMTP id b45mr517395yhm.102.1402443023788;
 Tue, 10 Jun 2014 16:30:23 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 16:30:23 -0700 (PDT)
In-Reply-To: <1402318146-5062-2-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: 6XZAGV0oH_Oj-TE6vkSBmocGZzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251324>

One other minor point...

On Mon, Jun 9, 2014 at 8:49 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Subject: config: Add hashtable for config parsing & retrival

s/retrival/retrieval/

> Add a hash table to cache all key-value pairs read from config files
> (repo specific .git/config, user wide ~/.gitconfig and the global
> /etc/gitconfig). Add two external functions `git_config_get_string` and
> `git_config_get_string_multi` for querying in a non-callback manner from the
> hash table.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
