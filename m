From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 19:34:44 +0700
Message-ID: <CACsJy8BqA2dm8DpDrrFN4FxHG+4gnG3Q7c3kM=YmBrkuHftvog@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
 <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
 <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
 <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
 <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com> <CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 13:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYDBy-0002X1-2W
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 13:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbbCRMfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 08:35:18 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34836 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbbCRMfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 08:35:16 -0400
Received: by igcau2 with SMTP id au2so61108205igc.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7lhYHSpzDlM2jXl/GVmj4IZlwSffRG22fjOwp+uoZxs=;
        b=sqc8wDFXHfqn5T8bm/FJhnfbaTQNer8fkYk785bSySMCgbpjSNgOiXTpew6RBud/KY
         HUWmcVn1gOXRRVnl4+BoibdbWcYuv/s+gGfOp0iChXgZeo+xnZOFwc2/ivHsJV/QKaFL
         Ceb+ZgZ4H8P3pZantXKfaGrg+ZcOgZBHexFa+kWOWV6GyQx0MZqsuiYB9pkh81YIGNnw
         LEfbjNfTJkguJg8nlgkeGtzDJvN0AJK/k/XRdvTfb0yP2PzblHRIZ4oZq01mrjv837zx
         6YUYmI4Q2g9wo4BOFZs1gk06GY5/KXZqKez72aBv5a+NfI77rcHhlPaVGuY9+c6DXHUi
         2Nww==
X-Received: by 10.107.11.226 with SMTP id 95mr31710280iol.5.1426682115952;
 Wed, 18 Mar 2015 05:35:15 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 05:34:44 -0700 (PDT)
In-Reply-To: <CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265726>

On Wed, Mar 18, 2015 at 7:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> It's quite a lot of work :) I created this script named "git" and put
> it in $PATH to capture input for pack-objects. You'll need to update
> "/path/to/real/git" to point to the real binary then you'll get
> /tmp/stdin

Forgot one important sentence: You need to push again using this fake
"git" program to save data in /tmp/stdin. Also you can stop the push
when it goes to "compressing objects" phase.
-- 
Duy
