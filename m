From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: Re: [PATCH 2/2] describe: Add documentation for "--abbrev=+"
Date: Sun, 24 Aug 2014 09:11:15 -0300
Message-ID: <CABXqP=iGfrbBrWE8qiavcpEqtPaaR8n2S4=i0+cQ3F6BLH40Cw@mail.gmail.com>
References: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
	<1408814002-6553-3-git-send-email-jonh.wendell@gmail.com>
	<20140824063536.GB3439@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonh Wendell <jonh.wendell@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 14:11:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLWdx-00077q-6c
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 14:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbaHXMLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 08:11:16 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:62153 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbaHXMLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 08:11:15 -0400
Received: by mail-oi0-f51.google.com with SMTP id v63so1955478oia.24
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=+yI1OI3TtsMph6uOXoxxZbExNKc21M1CynjC8friZZ4=;
        b=yL6iM/ATQVyM8hk5jw6I7GmovwTlnaCmv+fZwM+gAy/X6CxqS84f8vP9HSXvsj5HN5
         fPURiW95x2nS94kzgWjnKuF+CIItsIb8+CStmrVgGLYlueq+XMakrqHs/cSbgFFO2sLj
         vpVQNYCAwNBMhQ8IfNunCLSvnFZKOzhHr+LNUOx2/mLB4R4iudi6XC025u4XVmRx7zfQ
         eJhCv5eP8faCBH3g0jn9kjGpUdkngZ0jokyS8uNFjylsK5Zl5Abq+f100MsN/avoVFT1
         01Oq/FTjFMAr/WMWZaootO6nDco226Si8458ipwQ9G5jagpfMN46eYYnQRmwzrCui+F1
         tqfA==
X-Received: by 10.60.156.198 with SMTP id wg6mr891622oeb.69.1408882275113;
 Sun, 24 Aug 2014 05:11:15 -0700 (PDT)
Received: by 10.76.11.3 with HTTP; Sun, 24 Aug 2014 05:11:15 -0700 (PDT)
In-Reply-To: <20140824063536.GB3439@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255788>

2014-08-24 3:35 GMT-03:00 brian m. carlson <sandals@crustytoothpaste.net>:
> On Sat, Aug 23, 2014 at 02:13:22PM -0300, Jonh Wendell wrote:
>> ---
>>  Documentation/git-describe.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
>> index d20ca40..e291770 100644
>> --- a/Documentation/git-describe.txt
>> +++ b/Documentation/git-describe.txt
>> @@ -54,6 +54,12 @@ OPTIONS
>>       abbreviated object name, use <n> digits, or as many digits
>>       as needed to form a unique object name.  An <n> of 0
>>       will suppress long format, only showing the closest tag.
>> +     +
>> +     +
>
> Did you intend to have two lines with just plus signs here?  I'm not
> aware of anywhere else in the Documentation where we do that.
> --

In my tests just one line was not enough to produce a proper line
break in the html output.
With two lines like above the output in man and html are ok (just 1 line break).

-- 
Jonh Wendell
http://www.bani.com.br
