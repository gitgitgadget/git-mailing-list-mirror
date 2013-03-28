From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] t: check that a pattern without trailing slash
 matches a directory
Date: Thu, 28 Mar 2013 18:21:08 -0400
Message-ID: <CAPig+cRyPMg_icgK1+5-WdXeaAZ9ytYQgFLgbVohRJaC9qzZQA@mail.gmail.com>
References: <20130328214358.GA10685@sigill.intra.peff.net>
	<20130328215004.GF10936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 23:21:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLCV-0007Zm-F1
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 23:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab3C1WVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 18:21:10 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:49693 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab3C1WVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 18:21:09 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so36498lab.6
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=nVy2ssu3Vf8SwryTMfnUoTNNZaJW+AK52RUVNMZQ/k0=;
        b=MDsn5RS39jaWKGVGdKBqucNxGtN6B5zZ1eHnN+NHGBtmuDLLmztpHaxN83cAN7sADs
         jVlba9tQFCXVMS7r8v9TIkZZ3YiEAYtCl37tNknbuhA+Utexx9E9nc6WANw/pZu2K0Fc
         LFO67DotXTTWRApKMCJmMSw5c5JQKDAi900gJuRyPPkRntpBeVuws6APYTmcXUWSkH0b
         uz1ZKRNSQLkc+ulMAAfn4QDiTX0ezUhnEFDEWXLpYWXopObp8ysrQkoLgvQ5E+dMy8Xl
         yvUsK7emGy/lB0/Q2RZdPuyijiCPkEPcHXccqIKwcNVlYQBxrFj5moh5v/CtYE4oB/h/
         v9/g==
X-Received: by 10.152.47.242 with SMTP id g18mr109055lan.42.1364509268201;
 Thu, 28 Mar 2013 15:21:08 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Thu, 28 Mar 2013 15:21:08 -0700 (PDT)
In-Reply-To: <20130328215004.GF10936@sigill.intra.peff.net>
X-Google-Sender-Auth: MJ4L4EMebRjNHZ6JuF-3k2_wGcY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219469>

On Thu, Mar 28, 2013 at 5:50 PM, Jeff King <peff@peff.net> wrote:
> A pattern "subdir" should match any path "subdir", whether it is a
> directory or a non-diretory.  A pattern "subdir/" insists that a

s/diretory/directory/  [1]

> path "subdir" must be a directory for it to match.

[1]: http://article.gmane.org/gmane.comp.version-control.git/219185/
