From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/7] Coding style fixes.
Date: Fri, 23 Jan 2015 10:36:33 -0800
Message-ID: <CAGZ79kYPHv7UCy1jzf=0WeRP7od+3pZ61Rps9NK6_qbwER_Jjw@mail.gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
	<CANCZXo4Ga5a0OjNhqSOP39p76RfOOX+N5cZhA8j9hjhKodTqcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEj5z-0007qU-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 19:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbbAWSgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 13:36:35 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36312 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351AbbAWSge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 13:36:34 -0500
Received: by mail-ie0-f177.google.com with SMTP id vy18so8706735iec.8
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1uPAVwMWp7sC36DIi/4+9RUubWDKjYAgwIAkmLjuiSQ=;
        b=Oxm30r3OzfiUpVPy6GrmoEEZvBtUxBQ8G0gwAherkVp52JkqPoizre8WPK8A2LRMq+
         uU5i582YYCR615gy531Aw7kxBJQPQ8y2DViqchtee1vRRlUozIhUcJqHbvq2nkrgcBiw
         QmLlJsVpxoM79nqDvZmR6mX5RvY4rPuRl9lH/tiO8f9eaoc3DGJuqSX9V/ZCyOWFkCBM
         hsIxN3lyLFNORe+Vib/euQOz30DTYfrVtnrkLSGJA15pdwo1XOx6sSXt14dWO1IBGgWW
         2B+rEorIDMcteeZNn/Xsk+4t7+vDK+dXpezbA5oyiFrd9HWrx9FhhRVBFrlzOYvtmTk/
         6yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1uPAVwMWp7sC36DIi/4+9RUubWDKjYAgwIAkmLjuiSQ=;
        b=Ta0YItoG8aOEb1W/1Ehl5ZVc8YQwtSk9zn7GJuBcNIXBmA4CNzz+/NbL2hjqzBnAAi
         9QZ+4NVs0jbDhnvxFs0B76s3eAVCTYIZ1E81uVL3yl73glxT0jZF7W40cJVvBPwpoctK
         +VSn7JEBYkFPJwOO+k7M321LW3Q4YcJNQZO8IQ+Wqtu/EhA9g2zI2Z6YtoxZxfCxrNtd
         uSbONFGr9rIBFAi+P6t6YGXrsRDFMBzuN9nzttHNV/U8p/sZGK+qmOP2XRLYeIUCockj
         UGXA3M8FTGkvYvG2F0xb8eyjDNpqqfP5h/GmrKPoWhhpX7OmGuWsaXIXa4kG5uPuHcxO
         hQVQ==
X-Gm-Message-State: ALoCoQmR7QkzFxeLqcsG/zlatCnmnQ89hqkTn5glLL2Txr1eInpAi2gudrHUqc1AyQ1kAi4cp84P
X-Received: by 10.50.108.108 with SMTP id hj12mr3391211igb.47.1422038193616;
 Fri, 23 Jan 2015 10:36:33 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 23 Jan 2015 10:36:33 -0800 (PST)
In-Reply-To: <CANCZXo4Ga5a0OjNhqSOP39p76RfOOX+N5cZhA8j9hjhKodTqcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262941>

On Fri, Jan 23, 2015 at 4:09 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> I made separate patch for every file. Please, let me know if need to
> squash it into one commit.
>
>
> 2015-01-23 17:06 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
>> This patch set contatins minor style fixes. CodingGuidelines contains
>> rule that the star must side with variable name.
>>

The whole series is
Reviewed-by: Stefan Beller <sbeller@google.com>
