From: Graham Hay <grahamrhay@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 15:14:31 +0000
Message-ID: <CAABECY2x=G+nYdSyxpz8MvE4G6RSwcGSXu1LzwAKYG7Mqwk1kA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 16:14:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYFg6-0002XN-5J
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 16:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbbCRPOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 11:14:33 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35982 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbCRPOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 11:14:32 -0400
Received: by oigv203 with SMTP id v203so38835050oig.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tq8j9Z8Dnx9hzIAa/7HwKe/ex8hepsjaPvy5Lc0CJoQ=;
        b=foaEtp8xxQ8ztUaK4l4Qt/kVrADhdlao3JY/EWJssIsntUccy5NM2/Awgiifu5Jmbu
         p6MUnnOaFwea0WBHmleDJek+FiQPpqVySOAeZOQrIXKa/BGe72hTtMPIrd2OhLgGJ+F9
         Gw5Pr/3/nj0V/y3kuEj3ZoEZXXA65K33S5rP6PtO7VwJtEmXUio/6UoX0DeYE5xc3XXq
         Ms1yhEOmBew/nUIS0NfK7u3xB6iA6o1wmNNriXh8+iRFm6Sfkp8EGjAj6aV0pbT75+qt
         kDXJoB1ZCyYUB+xwqKw9a+cgqa+2kJf+5BMhdAzP/ekwd4lfp4xkG+DOX5vM2OthqdeB
         GSlQ==
X-Received: by 10.60.16.202 with SMTP id i10mr49232461oed.16.1426691672007;
 Wed, 18 Mar 2015 08:14:32 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Wed, 18 Mar 2015 08:14:31 -0700 (PDT)
In-Reply-To: <CACsJy8D16ERGH=P4etGRpZM_3BR9iYZBsUnWBGAbayVqmEhhXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265737>

Got there eventually!

$ git verify-pack --verbose bar.pack
e13e21a1f49704ed35ddc3b15b6111a5f9b34702 commit 220 152 12
03691863451ef9db6c69493da1fa556f9338a01d commit 334 227 164
... snip ...
chain length = 50: 2 objects
bar.pack: ok

Now what do I do with it :)

On 18 March 2015 at 13:33, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 18, 2015 at 8:16 PM, Graham Hay <grahamrhay@gmail.com> wrote:
>> I created a repo with over 1GB of images, but it works as expected
>> (only pushed 3 objects).
>>
>> Sorry, I must have done something wrong. I put that script in
>> ~/Applications, and checked it worked. Then I ran this:
>>
>> $ GIT_TRACE=2 PATH=~/Applications:$PATH git push --set-upstream origin git-wtf
>
> I think I encountered the same problem. Inserting
> --exec-path=$HOME/Applications between "git" and "push" was probably
> what made it work for me. Haven't investigated the reason yet. We
> really should have an easier way to get this info without jumping
> through hoops like this.
> --
> Duy
