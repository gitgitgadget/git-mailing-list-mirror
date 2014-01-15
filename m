From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Error logging for git over ssh?
Date: Tue, 14 Jan 2014 23:40:58 -0500
Message-ID: <CACPiFCLuqNMerSZhBtE=3X34Z9FYk+D9XukBzUOtuOWZKEqRGg@mail.gmail.com>
References: <CACPiFCKBK49Zm8oYcGMVfmsgRwDrPyzWcU7vM6DwJeQitBNsnA@mail.gmail.com>
 <CACsJy8Cp4Tw4_5px_fp4JY4TDdK2uH+1fYdiM8CBmbisbBbCmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 05:41:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3II7-0000n4-JS
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 05:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaAOElU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 23:41:20 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:41278 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbaAOElT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 23:41:19 -0500
Received: by mail-we0-f178.google.com with SMTP id t60so1252509wes.23
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 20:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pbcbjFX2tyxksQZjTFhgAJJJ7e09Cv4lIZCk7Xu+32s=;
        b=PPpUI1vXz6BlY4GbU/4BZPbslOErz2YZVd0gkbJ7Ar9PsOF4GifK38j1s/60k8lO/I
         hyeGr/Kyq7qLpDmVkZQDGT7krazcBMt1kKpHQD2mE+WhbSPrUBrBGyofrG1bQSBWf6T6
         kDtsCiCjIO3dj9QPLtAzr8Kz3euGeHU2pwDOOhRizwMVhJwwLiKioMy/0/K3N34bK1d8
         hh2q1z0e7wijBNpp1KT898ZodrprYBSkFlcZq23YaP+BCZ+NOVWBRzTqbfAJS80HSZSV
         anhTQePZ8GtabNgIhxD6veLLkSUH5CfOBDS6WHhJVwXRWstw/Fwzr2YybB+Iwog2vlew
         kyZw==
X-Received: by 10.194.23.201 with SMTP id o9mr217306wjf.67.1389760878144; Tue,
 14 Jan 2014 20:41:18 -0800 (PST)
Received: by 10.216.64.66 with HTTP; Tue, 14 Jan 2014 20:40:58 -0800 (PST)
In-Reply-To: <CACsJy8Cp4Tw4_5px_fp4JY4TDdK2uH+1fYdiM8CBmbisbBbCmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240430>

On Tue, Jan 14, 2014 at 8:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> We'll need to output the error side bands to stderr
> too in case side-band is used.

Agreed, we'd need to "tee" the output so it gets to the logger _and_ to stderr.

I thought perhaps daemon.c would have something in this spirit, but
the trivial implementation is not what I had expected...

cheers,


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
