From: Alberto Fanjul Alonso <albertofanjul@gmail.com>
Subject: Fwd: Add git ignore as builtin
Date: Sat, 15 Nov 2014 12:22:05 +0100
Message-ID: <CA+mQAOU_UnPuSk0f9d1sUnxBj8M4zEX7bwa4Dw_z_PJV3Lp4LA@mail.gmail.com>
References: <CA+mQAOXPZSv2B8tVfC=4eJ7X_2j8Di4BkuE=z43=U2+VNpdQQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 12:22:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpbQj-0005Kp-CF
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 12:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbaKOLWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 06:22:08 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:44244 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbaKOLWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 06:22:07 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so1669515wid.9
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 03:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=CT+rDScXUClBlZZt9EvmEvYCj9Dlk6rC9zDc1u08jxo=;
        b=DZt9CMLWnzY3YHFTnxbERrhR9N0be6D0GLn702bfj4Cdg9L9N1OJg71nWnu0QNyeRi
         0q6wh68v1aRCrWKSOBl25NUZUeUQkr6Sd4x6gIkoJZlXfonYhcYjEM5hnnE9easwBp9N
         aJZQysU3Q3btZLEdO8jd8N1OybA4HLInI/TsHKGWy2sgv0xLpNbHOZjXxazHhhVv4zjE
         GbtEN3ojQTB6N5zdt5mzdrAoaNVJ0Z1dPTAVHW7jjcatwiqKSu3ZhXlZkuKYsyWtp2hW
         HV7QaVDma9VX/HjgZeJYqbxGYeMDXcY/EhytUEAt+/FU8jSZ9Yn1t1iw/m7se8IL94ZP
         d1wQ==
X-Received: by 10.194.47.226 with SMTP id g2mr21921895wjn.68.1416050525471;
 Sat, 15 Nov 2014 03:22:05 -0800 (PST)
Received: by 10.27.176.9 with HTTP; Sat, 15 Nov 2014 03:22:05 -0800 (PST)
In-Reply-To: <CA+mQAOXPZSv2B8tVfC=4eJ7X_2j8Di4BkuE=z43=U2+VNpdQQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After seeing -e option in git config (open config files in editor)

http://git-scm.com/docs/git-config

I decide it's time to propose to incorporate an alias really useful to me

git ignore

The repo is on https://github.com/albfan/git-ignore

basically:

git ignore <whatever> adds <whatever> to .git/info/exclude

and git ignore -e starts an editor to tweak your excludes

by default it operates con exclude file, but it can also work with
.gitignore using -i option

I find it invaluable for IDE project files, TODOs, test files...
