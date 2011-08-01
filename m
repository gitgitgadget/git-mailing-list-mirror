From: Jon Forrest <nobozo@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Sun, 31 Jul 2011 21:57:02 -0700
Message-ID: <4E36321E.2040409@gmail.com>
References: <4E362F8E.1050105@gmail.com> <CACsJy8CdfRCssfrMVOjRn2a_=vZPLyG_uEd4fS2WxzQXKZGn3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:57:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnkZU-0003qX-5Q
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab1HAE5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:57:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61276 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab1HAE5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:57:31 -0400
Received: by iyb12 with SMTP id 12so6478313iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Y/309AxzGxlXMOMo6narwUjhRhgR01kMhmj67KRkEys=;
        b=Q7KqY+NaVvKRDJKpgk0WzwCLcONZ2WVRLAuwC8Jv6KF6m1B/eIxT/Yr9jikAwGaE0t
         64KJ3a7LtqabpbabdEHks0l79ELFvl5GqqlgD3ozYIsi9ipvkgP3I+HcM23DCvDjEAtR
         7dqw9DtHAz7q1aYXlx/AWyXVn7XLvBvowN3+A=
Received: by 10.142.80.3 with SMTP id d3mr2554801wfb.363.1312174650894;
        Sun, 31 Jul 2011 21:57:30 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-150.hsd1.ca.comcast.net [98.248.228.150])
        by mx.google.com with ESMTPS id o6sm630698pbj.18.2011.07.31.21.57.29
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:57:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CACsJy8CdfRCssfrMVOjRn2a_=vZPLyG_uEd4fS2WxzQXKZGn3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178318>

On 7/31/2011 9:50 PM, Nguyen Thai Ngoc Duy wrote:

> Are you sure this does not break any tests? t3508.2 for example
> hardcodes "1 insertions" and does textual compare. I have not run the
> tests but I suspect it will fail.

I ran the tests. The only result in red that I saw that
didn't appear to be caused "by breakage" was

not ok - 3 mktemp to unwritable directory prints filename

Since I didn't do anything relating to mktemp I thought
this was probably bogus.

I'm new to this so I don't know how to find the t3508.2.
If you can give me a hint I'd be glad to look at this in
more detail.

Jon
