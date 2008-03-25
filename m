From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Re: Apply patch on server w/o git
Date: Tue, 25 Mar 2008 15:23:23 -0400
Message-ID: <09409F50-D3C4-4290-AF94-C8985E7A52C8@faithfulgeek.org>
References: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org> <3e8340490803251141x6d199d8ch8828b396da202d81@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bryan Donlan" <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeEmc-0002kN-TY
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYCYTZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYCYTZK
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:25:10 -0400
Received: from mail-out1.fuse.net ([216.68.8.175]:58663 "EHLO
	mail-out1.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYCYTZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:25:10 -0400
X-CNFS-Analysis: v=1.0 c=1 a=KZoMnzppOcJ4f3GpYxcA:9 a=4k0xfm9b227tOFBwb98A:7 a=g3Iup5czS3o1zAzMnywuhp7kIAQA:4 a=XtdxlaU5CFAA:10 a=gi0PWCVxevcA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout1 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:63225] helo=[192.168.1.33])
	by mail-out1.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id D1/94-08390-B2159E74 for <bdonlan@gmail.com>; Tue, 25 Mar 2008 15:23:24 -0400
In-Reply-To: <3e8340490803251141x6d199d8ch8828b396da202d81@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78209>

I just tried it and no luck.  Anyone have any other ideas?

-Joe

On Mar 25, 2008, at 2:41 PM, Bryan Donlan wrote:

> On Tue, Mar 25, 2008 at 2:25 PM, Joe Fiorini <joe@faithfulgeek.org>  
> wrote:
>> I am trying to generate a diff patch on my local dev box.  I want to
>> upload this patch to a server (running Windows Server 2008) and apply
>> it to my staging code.  The catch is: I cannot install git on the
>> server to accept the patch.  Therefore, I would like to use a generic
>> patching tool (such as patch from the GnuWin32 tools).  I tried
>> generating a unified diff with the following command:
>>
>> git diff -U > diff.patch
>>
>> and then tried to apply it using:
>>
>> patch -u -i ..\other_dir\diff.patch
>>
>> and I got the error:
>>
>> "patch unexpectedly ends in middle of line" ... "Only garbage was
>> found in the patch input"
>>
>> It might be a problem with how I'm using patch, and if so, forgive
>> me.  If not, then how can I generate a generic diff format from git  
>> so
>> I can do what I want?
>>
>> Thanks all!
>> Joe Fiorini
>
> Just a guess, but the gnuwin32 tools might not like unix line endings.
> Try opening and re-saving in wordpad (or vim :set ff=dos, or $insert
> your favorite method here).
