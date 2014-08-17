From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 00:01:45 +0200
Message-ID: <CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
References: <ygfvbpqooog.fsf@corbe.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Daniel Corbe <corbe@corbe.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 00:08:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ8d6-0007L1-CS
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 00:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbaHQWC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 18:02:27 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:52244 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaHQWC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 18:02:26 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so6400346igd.11
        for <git@vger.kernel.org>; Sun, 17 Aug 2014 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WvK++9rwE1pOIzpuy2iDsfO3H9xDUwluPh/M53rFzr0=;
        b=L92CqcrwXSHEOlbjLBbmhmo2PP9rheTL5J3IvQYnsj7uGg8Yap4ncm4LGhOQ7Ldv/c
         dN/pIzj6GeuzPXHG91oTex4Uoo/FMbwi9xkM0XX4vM/E2m5NRpGtXa7T/Va1rWK/VHtF
         WJS+/zIqRRsReuz+lXsRBaOwM94IuiswEmlifmYg7oUCV0GP1vqK9JNijJpxLA6uLHMC
         mQ3R9DbLBf+77LpYSKYPQw3Q+Q8P2aHlc+JB6KnRKOuA+IFWY4LN0Q4GNBgDYDf9frUF
         HMW7xAv2OOKM0m2pFy6tOV6FeqhYbrwuoE+lWpKIxSLByCkeTY03koGzAgSzu69vlUHZ
         dPTQ==
X-Received: by 10.50.33.73 with SMTP id p9mr78978646igi.24.1408312945607; Sun,
 17 Aug 2014 15:02:25 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Sun, 17 Aug 2014 15:01:45 -0700 (PDT)
In-Reply-To: <ygfvbpqooog.fsf@corbe.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255377>

On Sun, Aug 17, 2014 at 10:18 PM, Daniel Corbe <corbe@corbe.net> wrote:
>
> I installed git on my Windows machine while it was connected to my
> corporate network.  It picked up on that fact and used a mapped drive to
> store its configuration file.
>
> As a result, I cannot currently use git when disconnected from my
> network.  It throws the following error message: fatal: unable to access
> 'Z:\/.config/git/config': Invalid argument
>
> Obviously this value is stored in the registry somewhere because I made
> an attempt to uninstall and reinstall git with the same results.
>
> Can someone give me some guidance here?

Git looks for the per-user configuration in $HOME/.gitconfig, and if
$HOME is not set, it falls back to $HOMEDIR/$HOMEPATH/.gitconfig. My
guess would be some of these environment variables are incorrectly set
on your system.
