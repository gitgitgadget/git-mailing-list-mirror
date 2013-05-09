From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 15:54:10 +0530
Message-ID: <CALkWK0m3AG5iw1gCAAepmzJeZD_s9cm-eYC-cnSaVmn=FvSNag@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
 <1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
 <CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com> <CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 12:24:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaO1v-00074C-De
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 12:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab3EIKYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 06:24:51 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40449 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab3EIKYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 06:24:50 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so5189314iej.2
        for <git@vger.kernel.org>; Thu, 09 May 2013 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/LLH1wsF41F7s0pI2D8WEQsUBW3PJNXMcKDxwqwEqfo=;
        b=vLsdVBqpW1npXKqcW44TZjbfX2M17g+NIddkjMW5/GFl8QYYJGYq/6fxOxfHBDFmNj
         9BciFKAo3THAcT0dimjEvwltlUzLnGlT/0APt+afYsECS7qghmjv2uudcxCgtRPa2VUB
         IIJ1b8DunAIeD9pEbUnp0QW4KLRo9RMyZdD1gWV5/r3hw0wSHj/ve1QgMK1DM79qn1TW
         aO79mW4g/1oQHAyN5AeobVpmzdSSekl6Ckf2XG24xv/XzNaerDP47Bz+8LVlEbQG/yOb
         MsM/C7Srd3y5h3YnHDoyyp6q/kdKs16u2jReZsdSoKAJV430PQXtXpWhWiiCfOr+7/LB
         plIg==
X-Received: by 10.42.27.146 with SMTP id j18mr3985402icc.54.1368095090292;
 Thu, 09 May 2013 03:24:50 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 9 May 2013 03:24:10 -0700 (PDT)
In-Reply-To: <CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223725>

Felipe Contreras wrote:
> AFAIK neither the git or the Linux code-style specify how multiple
> lines with open parenthesis should align.

git style inherits from linux style.  See Chapter 9 of
Documentation/CodingStyle in linux.git.  It has elisp snippets you can
stick in your .emacs.
