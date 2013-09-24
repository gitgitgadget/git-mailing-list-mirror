From: Ram Rachum <ram@rachum.com>
Subject: Re: Using alternate working directory
Date: Tue, 24 Sep 2013 07:27:37 +0300
Message-ID: <524114B9.40001@rachum.com>
References: <523E09D8.8090808@rachum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 06:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOKDx-0003eT-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 06:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736Ab3IXE1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 00:27:42 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:41702 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3IXE1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 00:27:41 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so2138439ead.7
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 21:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AarvrLdDZdK0p5a5R85Wq6k1zBrNWI3wG3cCY4My7oU=;
        b=pisHk4kfDie9VnKgNEeBJfJHBbDqxudgjCzO++0bLxl26fIIXW+KNnxMOn1T+4/zpC
         jSXeKgzbnH8xX/lHHem3ekstwYe/1zv6W+JJlyKj3kNufRiNqo5M4MZhUFC0oWnKwy+2
         usc+tVdAyWi4z5w3qazyFxu9UCjPYJTiVbKpP+Ei5L4uoKucT/6IYGx58Q7d7mN9TNF1
         urUoDD3Fsk9xc6L//9TgwSpzhmEGRMQWyf7dWSggIeUiN0Mk0GdWdJ6RdCemIZ9kMsu9
         DSIgUiq7R70wE9/gIdi1pct/l/ALUFCvdnMR86qKwtoBo7TonTLYJA6lt6qx6e5c9mHX
         zqFg==
X-Received: by 10.14.180.73 with SMTP id i49mr503147eem.55.1379996860236;
        Mon, 23 Sep 2013 21:27:40 -0700 (PDT)
Received: from [192.168.1.100] ([109.226.59.239])
        by mx.google.com with ESMTPSA id a43sm48689413eep.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 21:27:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <523E09D8.8090808@rachum.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235256>

Does anyone care to help? I'd really like to solve this  :(

On 22/9/2013 00:04, Ram Rachum wrote:
> Hi everybody!
>
> I need some help with Git.
>
> I'm making a script `gm` which lets me merge one branch into another 
> without having either checked out. It works for some cases but not 
> all. I'm trying to make it work for more cases.
>
> I concluded that the best way to do it would be by using an alternate, 
> temporary working directory instead of the repo itself.
>
> This is my script:
>
>     https://gist.github.com/cool-RR/6575042
>
> Now, the problem is that when I try it, it gives these errors:
>
>     git checkout-index: my_file is not in the cache and then error:
>     my_file: cannot add to the index - missing --add option?
>
> Anyone has any idea what to do?
>
> P.S. I've also asked this on Stack Overflow, so whoever comes up with 
> an answer can claim his 150 imaginary internet points on that question.
>
>
> Thanks,
> Ram.
