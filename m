From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] tag: support --sort=<spec>
Date: Wed, 26 Feb 2014 18:31:58 +0700
Message-ID: <CACsJy8An3GH7LMx4=s-7hO3waphcC2nGK1N-CvPYbh+=Zzngqw@mail.gmail.com>
References: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
 <1393330935-22229-1-git-send-email-pclouds@gmail.com> <20140226090511.GA32537@sigill.intra.peff.net>
 <CACsJy8CW9p-PDJC9zXBwXrxOk9GhBFk1nVtG1Xn76g3FN+KgaA@mail.gmail.com> <20140226110803.GG25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcj4-0002NI-LV
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbaBZLca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:32:30 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43050 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbaBZLc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:32:29 -0500
Received: by mail-qa0-f46.google.com with SMTP id k15so2083552qaq.33
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6zLiYxpDHRqHpArNu4XQ8KWuuLkd+9eaOVsHy1HKNAI=;
        b=jTDktCBrCFAnoXWaV8A/pjbtmirlyE/ZtEcZMf6lyak7/1hnlPuHKAMPRcmPgr2AE3
         04DZ2jViTbu6gPmfC2rI1sQjOOnOnO9K2NR7D3BNrvifeHNoDaU4ckD6+Pq3T7OiyIuV
         dA98rWl992iOFtvpoI44IElyzmPChBVOv/h1vqXK6IDvxZ4I1DEDLkLk8U4im8twR701
         PieCaqdHsJ6gRsIbmtc5CySO2K8RIgHUsLze8V+qvKb6MYTDzwgiDi+6FSLjhDQKQV8Z
         1nnk0OQyAMoNPWdGbRB6iHGonKKCtr8zMjQ5ibznoG/bXdqBNdcVChFs10fWB0KXpTNk
         Efhw==
X-Received: by 10.224.19.199 with SMTP id c7mr7135728qab.78.1393414348411;
 Wed, 26 Feb 2014 03:32:28 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 03:31:58 -0800 (PST)
In-Reply-To: <20140226110803.GG25711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242727>

On Wed, Feb 26, 2014 at 6:08 PM, Jeff King <peff@peff.net> wrote:
> But before thinking about that, I'd want to know why
> glibc behaves as it does.

Pure guess. It may be because it targets more than software version.
In strverscmp man page, the example is "jan1, jan10, jan2...".
versionsort() in glibc might be the reason that strverscmp was added
and it's used to compare/sort dir entries, so the target might be
numbered log files.
-- 
Duy
