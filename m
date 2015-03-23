From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Mon, 23 Mar 2015 17:05:58 +0700
Message-ID: <CACsJy8AqrBc4HKEKSHmkSq2wKwUgUEWrZu3=9-WGsM+txR8S-g@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
 <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
 <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
 <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
 <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
 <CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
 <CACsJy8BqA2dm8DpDrrFN4FxHG+4gnG3Q7c3kM=YmBrkuHftvog@mail.gmail.com>
 <CAABECY13XT3+rEGGtKfe3Xwg4RtzcWtpL=Nm7aivv4_35TvL0w@mail.gmail.com>
 <CACsJy8D16ERGH=P4etGRpZM_3BR9iYZBsUnWBGAbayVqmEhhXw@mail.gmail.com>
 <CAABECY2x=G+nYdSyxpz8MvE4G6RSwcGSXu1LzwAKYG7Mqwk1kA@mail.gmail.com>
 <CACsJy8B=Dx2+OWch1zx_xg91de9yhttVMwgE1SxDOuSTns2b_w@mail.gmail.com> <CAABECY063__YDW2jXPSnuvxp0kj=jB+k09mOEW3suEn5syAyXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:06:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZzFi-0006pk-I1
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 11:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbbCWKGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 06:06:30 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33808 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbbCWKG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 06:06:29 -0400
Received: by igcau2 with SMTP id au2so29769577igc.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3BmHvwkdgV7itNpPLG+2txxDP16/Ph5UTvoyOx2w+Sw=;
        b=m5zXw3hvAwEdjJZQwPdgiSyBlXj0wS9LKS5bxMlTXAW20bva2So80Iu2qEvkgahWVA
         +TF6s60OsyabMfeXOWQ2ZS/cYCpx710sPdWvE1GQJirrnDvsFgENncIfPXaTk44U3VcA
         hH7jAoieqyoaaFZopT0sywqlUM4NHX5iiag2096821EEkugnqmm29FZEqb5yUHyw4gLl
         vfy1nu4oNwe4yzlZam5bGles6up4Yni/4/MpIS+7vw2oRkOidhpsAuhJjDKWBFC+Ofz1
         VXr+0NictfzizlaPRumBwWgRPok9/fHFUJyLApBqWxnU1Ka5czAURWAT8lp3SiIKwnvc
         /uHg==
X-Received: by 10.50.147.99 with SMTP id tj3mr13137773igb.41.1427105188391;
 Mon, 23 Mar 2015 03:06:28 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 23 Mar 2015 03:05:58 -0700 (PDT)
In-Reply-To: <CAABECY063__YDW2jXPSnuvxp0kj=jB+k09mOEW3suEn5syAyXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266131>

On Thu, Mar 19, 2015 at 6:11 PM, Graham Hay <grahamrhay@gmail.com> wrote:
>> Try "fast-export --anonymize" as that would help us understand this.
>
> Attached.

The bad news is it seems to be working for me (I recreated the remote
repo from this dump). I notice that you have two remotes, one shares
many refs (the remote "ref39"). The other, "ref2", does not share any
SHA-1 with refs in ".git/refs/heads/". Any chance you push to a
no-share remote, which results in a lot of objects to be sent?
-- 
Duy
