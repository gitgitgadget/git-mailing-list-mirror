From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] commit: don't use-editor when allow-empty-message
Date: Mon, 27 May 2013 19:37:58 +0530
Message-ID: <CALkWK0nm71QAM1FSwuL4sK8JQXmaUtXegjsLMmYOK-1Aaro39A@mail.gmail.com>
References: <195A1F16-B587-4217-97BF-6A92DA8C0786@gmail.com> <1369663431-2405-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Mislav_Marohni=C4=87?= <mislav.marohnic@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 16:08:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugy6N-0006Ia-M0
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 16:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab3E0OIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 10:08:39 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:53608 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587Ab3E0OIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 10:08:39 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so18557846iet.14
        for <git@vger.kernel.org>; Mon, 27 May 2013 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ii4c7P8C6CeQlzJmzE057qsd5znrz1UP0GSsbB4VI0g=;
        b=DMlQ690QQETebDUVGOKdEIpBa8AxnTU3fdcyIUyotJa0i9W1syAMtdUFveJK+1Um4d
         kE7Zt27Hh4ecM6P6onRjYL/0qGqHfcpz+J5/08udQ33/FiRZSl4B5b/wCb/7w1k7WLAW
         OOMIk1UMV0CgfojvXoAJ5MinuF6nxMNfX1bZJaouOEoh1QAR38c5JOphkQNpI7h4JHs4
         bMP0eGHH13ohBamAhP2c/tsVDwiGxcLvnFjj76L4gGqs78/mQurgGnPlfTgNMYrpmxfJ
         rALRq6f08NzjSQIVdV9vjZseuBG8giZ0VPRLean539CCMjSalo4i0sNPXKjt+ZUBLgbe
         c3cQ==
X-Received: by 10.50.32.8 with SMTP id e8mr2624643igi.89.1369663718866; Mon,
 27 May 2013 07:08:38 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Mon, 27 May 2013 07:07:58 -0700 (PDT)
In-Reply-To: <1369663431-2405-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225590>

Ramkumar Ramachandra wrote:
>  builtin/commit.c | 2 ++
>  1 file changed, 2 insertions(+)

I just made this dependent on the order in which options are parsed.
If --allow-empty-message is specified before -m "", it works.
Otherwise, not.

Sorry about the stupidity.
