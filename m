From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Re: Apply patch on server w/o git
Date: Tue, 25 Mar 2008 23:03:58 -0400
Message-ID: <323B72DF-3387-40ED-8235-213A9FAD6CDD@faithfulgeek.org>
References: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org> <200803252057.38326.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 04:05:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeLwe-0001d0-BI
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 04:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbYCZDEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 23:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYCZDEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 23:04:09 -0400
Received: from mail-out2.fuse.net ([216.68.8.171]:47665 "EHLO
	mail-out2.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbYCZDEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 23:04:08 -0400
X-CNFS-Analysis: v=1.0 c=1 a=VwQbUJbxAAAA:8 a=KZoMnzppOcJ4f3GpYxcA:9 a=RuS_QZMff0q8G51i8BUA:7 a=K8Qwyg0R74emVT3SKkCn1rcYVcYA:4 a=XF7b4UCPwd8A:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout2 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:64046] helo=[192.168.1.33])
	by mail-out2.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id E9/D0-05263-02DB9E74 for <robin.rosenberg.lists@dewire.com>; Tue, 25 Mar 2008 23:04:07 -0400
In-Reply-To: <200803252057.38326.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78247>

Thanks for all your replies.  Unfortunately, I cannot use git apply  
because I will not have access to git on the server where I'm doing  
the patch.  I will try Jan's suggestion of ignoring whitespace.

-Joe

On Mar 25, 2008, at 3:57 PM, Robin Rosenberg wrote:

> Den Tuesday 25 March 2008 19.25.58 skrev Joe Fiorini:
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
>
> You can try git-apply instead of patch. It is a bit smarter (and not
> outsmarting itself either).
>
> -- robin
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
