From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 4 Mar 2016 19:36:46 +0700
Message-ID: <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info> <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Fri Mar 04 13:37:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abozJ-00063M-3f
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 13:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbcCDMhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 07:37:21 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35199 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbcCDMhS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 07:37:18 -0500
Received: by mail-lb0-f180.google.com with SMTP id bc4so59331409lbc.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 04:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wo1ShB5RnBoe2CNNOa6DWfJYoIxMW0kStyFu2DF2r0I=;
        b=jRVogVY1D5FMRLduKpu0iGrl50YK8Uvd1nrjJYnbwzS+6vPShIsEgDgfl+XySts0H5
         xScX11NUpf7iN5VJud40mWpCemHuHn96MehBVBfb+/TQo0ONMxlsahSD9JE9v39aX5KY
         8blpKEnIRyQST8fozaiE74oiNvgmrIE3gti4rtQNRglznmPZPw71Zu1b4TZKC5NWsnNz
         Y6YK4QztydfvLPG9ddAPVhNyj9Z4hmzhj8vdqSEGdOr0S93HMZ/kuA2C/nNo33oZ+9WY
         xKJabW8RclkTt6i5aU15vIwAmE/a0ESSILAl3pJUdtzS1zYrsewzO6dY5IY8Pm0ftGFT
         mCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wo1ShB5RnBoe2CNNOa6DWfJYoIxMW0kStyFu2DF2r0I=;
        b=WLwvBY6Y/IAuwL13Tswn2Kvjw+8rWzdoin8pG+MS56MCGQ1UQUY7D5MvorCe0ock+W
         RhPDSsm04oB994pir5gS4FZ64Hzy0tBqyxEnuokVxf2ks13qTM8tENqRP2QrrT++E8Mf
         QhQPVFGSNF5Qjg3etRkPxa9GnR5/ZYvcBVRoLS7Lv6v1bNhDbxW7In84P3+RQcSmM3ak
         mF1DADKvLMjOoD36XVz4UK9GUlHgVdZz8OEfYk03IKfpdtIyk2a1SEndp4mphiP2P2vN
         h0uwju1CBusTHakH4u3Aba8xsr3W46iwl5ymkSd9QLF0nJuH4e/Q4dJq/5WcVE+rSNm7
         Ukww==
X-Gm-Message-State: AD7BkJIgNBZOna++hDrLdHgep6hh/lpjr4OQ3q6eD7Tg24znUzff/As7TiXoMSrRrAdd/TDFR403loabgMCfdw==
X-Received: by 10.112.140.129 with SMTP id rg1mr3175237lbb.80.1457095036442;
 Fri, 04 Mar 2016 04:37:16 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Fri, 4 Mar 2016 04:36:46 -0800 (PST)
In-Reply-To: <20160304115634.GC26609@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288253>

On Fri, Mar 4, 2016 at 6:56 PM, Kevin Daudt <me@ikke.info> wrote:
> Verified that it's different in 2.7.0, but 2.7.2 gives expected output.

Thanks. 2.7.1 reverts the faulty commit from 2.7.0 that generated two
other regression reports before this one. I guess it's all good then
(except for the people still on 2.7.0)
-- 
Duy
