From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rev-parse: Clarify documentation of @{upstream} syntax
Date: Sun, 17 Mar 2013 00:31:18 -0400
Message-ID: <CAPig+cTL_u_AV1-E9JhBRP2JP97vod9iWpRtM0SETX9-GL_-2w@mail.gmail.com>
References: <1363459903-32358-1-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sun Mar 17 05:31:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH5GG-0006GN-SX
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 05:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802Ab3CQEbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 00:31:20 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:49991 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3CQEbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 00:31:20 -0400
Received: by mail-la0-f45.google.com with SMTP id er20so4936984lab.4
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 21:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=FILJBCGVzrFvwCV7yLPrLMEZbULEfGkHAN1+QI41HQs=;
        b=twqJsNH6mZuseP76zcPHFTS3ySsNc/UW3+NveEwts07SLjpL9U+0tFRuDQDa7QRG7p
         20Fxrldgf5W3XHgXSFNJ2eKjUf8hcWJypqX8X0MYTfqYSeUdN+XIRTqWMOlbi/oP2KVY
         g+jbiSsBc99gHUJmJqUMa022CbJsWs9CCMoolf56t6mnNvuMNEqs81MtVSqGzS8p69pG
         ezNJ0/10dC2lctY4VNgh1OxcB3hlaE580qxH312YCQhVg6Iie/v0rc0Z67w1L4UaeRNX
         BSqBFumgU/xwDf+E7nhwtOjrvMz2blc427MgKYF3dx+rDkGp86c0CU4eHI34IfuTEs0V
         x3Hg==
X-Received: by 10.112.41.101 with SMTP id e5mr4485549lbl.120.1363494678338;
 Sat, 16 Mar 2013 21:31:18 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sat, 16 Mar 2013 21:31:18 -0700 (PDT)
In-Reply-To: <1363459903-32358-1-git-send-email-draenog@pld-linux.org>
X-Google-Sender-Auth: 5XiYzjhcoBZR7Mftr9C5xKmYgck
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218325>

On Sat, Mar 16, 2013 at 2:51 PM, Kacper Kornet <draenog@pld-linux.org> wrote:
> git-rev-parse interprets string in string@{upstream} as a name of
> a branch not a ref. For example refs/heads/master@{upstream} looks
> for an upstream branch that is merged by git-pull to ref
> refs/heads/refs/heads/master not to refs/heads/master. However the
> documentation could misled a user to believe that the string is

s/misled/mislead/

> interpreted as ref.
