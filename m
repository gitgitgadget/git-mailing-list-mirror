From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 11:04:06 -0400
Message-ID: <4E6F70E6.2070602@sunshineco.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vk49d5t8u.fsf@alter.siamese.dyndns.org> <4E6E928A.6080003@sunshineco.com> <CAEBDL5VDsc49wj6GiQ0ZaSZ0eBy_iTd73zhgqhLfOLFhnqC-5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 17:04:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3UXI-0005Yk-6t
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 17:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab1IMPEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 11:04:24 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52402 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab1IMPEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 11:04:24 -0400
Received: by qyk7 with SMTP id 7so516779qyk.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Kzx13i7R9Z5UbzAq7CUhj/uhn/fFsYTY/01PM3YjtGI=;
        b=X9/1pKgH61zPS2PdBui60jp/GGHYthZoUKVsM+3YqL8kM0DWCkZzPO4zx9hUbx3hcB
         PanOiS7ZaVKQ77ZUU/eLoZlycAzrRfyk7W0rv7KuMUxXtcQ2duebPWTNRpP9VKS55oOY
         komwcNx5s8kTzxiD1Qj1jUUHIKRZXBA4gMZDI=
Received: by 10.229.188.207 with SMTP id db15mr936969qcb.231.1315926251765;
        Tue, 13 Sep 2011 08:04:11 -0700 (PDT)
Received: from [192.168.1.1] (user-0c936tj.cable.mindspring.com. [24.145.155.179])
        by mx.google.com with ESMTPS id v6sm1761191qaz.7.2011.09.13.08.04.07
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Sep 2011 08:04:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CAEBDL5VDsc49wj6GiQ0ZaSZ0eBy_iTd73zhgqhLfOLFhnqC-5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181285>

On 9/13/2011 3:51 AM, John Szakmeister wrote:
> On Mon, Sep 12, 2011 at 7:15 PM, Eric Sunshine<sunshine@sunshineco.com>  wrote:
> [snip]
>> Shouldn't the last entry be?
>>
>>         "*.m diff=objc",
>
> Or maybe not there at all?  We tend to do quite a bit with Matlab, and
> Matlab scripts also end in ".m".  Unfortunately, it bears little
> resemblance to Objective-C.

This default mapping is provided as a convenience only. Users can edit 
.gitattributes as needed. If we assume that the number of Macintosh and 
iOS (iPhone, iPad, iPod Touch) programmers heavily outweighs the number 
of Matlab users, then the convenience of having .m in the default list 
may be justified.

It also is reasonable to ask if the "*.m diff=objc" mapping actually 
produces an inferior diff hunk-header[1] for Matlab files than when 
"diff=objc" is not present.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/180103/

-- ES
