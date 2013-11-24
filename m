From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: slow git-cherry-pick.
Date: Sun, 24 Nov 2013 19:47:10 +0700
Message-ID: <CACsJy8CAAov1nSGPx79U+md4xROsCydidHPcipOb_sdFwNdSkA@mail.gmail.com>
References: <2142926.gg3W3MsbJZ@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: pawel.sikora@agmk.net
X-From: git-owner@vger.kernel.org Sun Nov 24 13:48:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkZ6W-0008CC-7T
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 13:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab3KXMrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 07:47:42 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:44623 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3KXMrm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Nov 2013 07:47:42 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so2048744qap.18
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=94gmKSFB0a5WKEI9F3JJMOHy0+bkUexnrDua/bZYVBE=;
        b=VDEWfkJ9Xrm6AFWsMmEzYKBc7WN7d/pM4oYMxDP1CJ/HUI0X49K5f7paAWHXVQnI5e
         MvQ5+KZSE2SgeL0ZoC1YOO37sQ7D+8p34qGyLRJkCoSasx7nP3PmV5nQB4SwsgengqJv
         T99TjI15mjv0+HrT+G8LJ4f8dxrkqxiaMWMSXfwk47hfYMwohRw41I1IVvxV5VwY2TiG
         VA6fCDFmQRhGKeZF/KR7B+D7oxNQQ5T5w4UrFlqEPs5lg0IdU7X0w/YNpqVR/YRXM0ze
         CBki3qMSFEB6Sfwjq6W1Dpmuy930h7Snpa1KkGkqszEngWVa205b3d9WPT1rEOpIMej5
         pNdg==
X-Received: by 10.229.49.8 with SMTP id t8mr37351306qcf.21.1385297260398; Sun,
 24 Nov 2013 04:47:40 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sun, 24 Nov 2013 04:47:10 -0800 (PST)
In-Reply-To: <2142926.gg3W3MsbJZ@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238256>

On Sun, Nov 24, 2013 at 5:45 PM, Pawe=C5=82 Sikora <pawel.sikora@agmk.n=
et> wrote:
> i've recently reinstalled a fresh system (fc20-beta) on my workstatio=
n
> and observing a big slowdown on git cherry-pick operation (git-1.8.4.=
2-1).
> the previous centos installation with an old git version works faster
> (few seconds per cherry pick). now the same operation takes >1 min.

What is the git version the reinstallation? Do you cherry-pick on one
commit or a commit range?
--=20
Duy
