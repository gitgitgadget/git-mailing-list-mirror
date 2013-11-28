From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 09:35:27 +0100
Message-ID: <5297004F.4090003@gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com> <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com> <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, zhifeng hu <zf@ancientrocklab.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 09:35:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlx4O-0005rk-N3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 09:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab3K1If3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 03:35:29 -0500
Received: from mail-ea0-f171.google.com ([209.85.215.171]:64405 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab3K1If2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 03:35:28 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so5543531eak.30
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 00:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=z10LeFkTIyoshgeodrzO/D+K9hnXkNvQH/rtp1XH6mw=;
        b=a9AYkLfPzSq/SvkIwnKfxFmib9rsB+ZBAzVlDjqupSG4zxOicexxctwGh3YolVzLh7
         MyiTYiOMOr02qp1pw+EB5s1IHx0VLnXkcU1u8pUcgzQQx+/OlJRaWrVc/Mv6YAnHx+NX
         ml621mV88K/fOvYay6ivl5wBh/7hAx6KH2ScEBI6D5KaDFrZtas/hk4NM1SmTHcAcQWW
         GypxQZXd5PdnnEVF0hgmLQZYYkxcd5m3y/vYrFiGBG9/JuN4YiWvddcqrUxfO5ThYK+B
         LIOwZCCbR4zP2a+/4UXnqj9stBOrrXqpTXKsY9Jkcs0Ivw31SmmE1DZbi55dKsDrvyfh
         kWsQ==
X-Received: by 10.15.91.3 with SMTP id r3mr47110469eez.18.1385627726862;
        Thu, 28 Nov 2013 00:35:26 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id j46sm27412498eew.18.2013.11.28.00.35.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Nov 2013 00:35:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238478>

Am 28.11.2013 09:14, schrieb Duy Nguyen:
> On Thu, Nov 28, 2013 at 2:41 PM, zhifeng hu <zf@ancientrocklab.com> wrote:
>> Thanks for reply, But I am developer, I want to clone full repository, I need to view code since very early.
> 
> if it works with --depth =1, you can incrementally run "fetch
> --depth=N" with N larger and larger.
> 
> But it may be easier to ask kernel.org admin, or any dev with a public
> web server, to provide you a git bundle you can download via http.
> Then you can fetch on top.
> 

Or simply download the individual files (via ftp/http) and clone locally:

> wget -r ftp://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> git clone git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> cd linux
> git remote set-url origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
