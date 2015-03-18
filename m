From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 20:33:48 +0700
Message-ID: <CACsJy8D16ERGH=P4etGRpZM_3BR9iYZBsUnWBGAbayVqmEhhXw@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
 <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
 <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
 <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
 <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
 <CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
 <CACsJy8BqA2dm8DpDrrFN4FxHG+4gnG3Q7c3kM=YmBrkuHftvog@mail.gmail.com> <CAABECY13XT3+rEGGtKfe3Xwg4RtzcWtpL=Nm7aivv4_35TvL0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 14:34:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYE7A-0004Hn-9Q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 14:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525AbbCRNeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 09:34:22 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36452 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388AbbCRNeU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 09:34:20 -0400
Received: by igbue6 with SMTP id ue6so99873330igb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1A3rcaZ8OV8oTf4pYpz6R3E+Fbv8ORvUSouhaqj5AIA=;
        b=J2IRta65gb/95QbS+mEVaQMyt+8KqoI16MnkI1JOBCo+PYR8rE+ixo7yzj4NDUkRuh
         TXzs3BS/Fc2R/W5Gr2wfc39NxfY1hlwDe/D6vBzW7ye+AZlEIflmN2QiAfuWniKoxC1+
         H27Twek8ComRD3tVGtUl24/8sCPdqcVLy+4OYRCGYXE7URPq40xaHSgmUzbb58nPrBa1
         /DAAq3QXCToqjYzyuQBNq1t46AU3g6pmJa8gxlKttzWaV4r9zeyzhGLwdPnm8vCoAm0W
         5WHLIdkh3GIr9N4El7oH3rRWADUwvwh+k6UGIVMqeQcNrICX2Z/WzhLhgxK46oFi/x0y
         z7XA==
X-Received: by 10.50.107.36 with SMTP id gz4mr6835897igb.25.1426685659212;
 Wed, 18 Mar 2015 06:34:19 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 06:33:48 -0700 (PDT)
In-Reply-To: <CAABECY13XT3+rEGGtKfe3Xwg4RtzcWtpL=Nm7aivv4_35TvL0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265729>

On Wed, Mar 18, 2015 at 8:16 PM, Graham Hay <grahamrhay@gmail.com> wrote:
> I created a repo with over 1GB of images, but it works as expected
> (only pushed 3 objects).
>
> Sorry, I must have done something wrong. I put that script in
> ~/Applications, and checked it worked. Then I ran this:
>
> $ GIT_TRACE=2 PATH=~/Applications:$PATH git push --set-upstream origin git-wtf

I think I encountered the same problem. Inserting
--exec-path=$HOME/Applications between "git" and "push" was probably
what made it work for me. Haven't investigated the reason yet. We
really should have an easier way to get this info without jumping
through hoops like this.
-- 
Duy
