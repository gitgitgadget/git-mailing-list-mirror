From: Jon Forrest <nobozo@gmail.com>
Subject: Re: [PATCH] Fixed pluralization in diff reports
Date: Sun, 31 Jul 2011 21:11:39 -0700
Message-ID: <4E36277B.9020208@gmail.com>
References: <4E3624F9.7070406@gmail.com> <7v8vrdkc19.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:12:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnjrU-0000kf-69
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab1HAEMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:12:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50235 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1HAEMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:12:08 -0400
Received: by ywn13 with SMTP id 13so506747ywn.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lY5m2AoNEgmpWuuXvYY3SFDtU4ij4Ol/8vkINSBzsmg=;
        b=ZAkBo0zXFB7gSo8cStENHEzW7SQW0z4v0mY15HDfif98SSSZWGtY1NTD1gCcFn/aSb
         sKGpxMLfd4/x2K061LscWuO6MqQvjhBCLj/bXhVeOHWNSsd9tEyEmAKyD5hgAh5CJVID
         gJztEcPBVMRavpihDQy0RGhrVyQiZ6FNgMmfk=
Received: by 10.142.221.17 with SMTP id t17mr243784wfg.275.1312171926904;
        Sun, 31 Jul 2011 21:12:06 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-150.hsd1.ca.comcast.net [98.248.228.150])
        by mx.google.com with ESMTPS id l19sm2833943wfk.23.2011.07.31.21.12.05
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:12:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7v8vrdkc19.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178308>

On 7/31/2011 9:09 PM, Junio C Hamano wrote:
> Jon Forrest<nobozo@gmail.com>  writes:
>
>> I got irritated by the
>>
>> 	 1 files changed, 0 insertions(+), 1 deletions(-)
>
> This is how the other diff implementation has always showed this line, no?

Maybe, but it's not grammatical English no matter who does it.

But, I'm in the process of asking you to disregard this change
because I noticed that the diff of my change to diff.c was

	1 file changed, 6 insertions(+), 4 deletion(-)

The last part is clearly wrong, but I don't see why
my change didn't work. It's such a simple change.

Back to the drawing board.

Sorry for the bother.

Jon
