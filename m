From: Ram Rachum <ram@rachum.com>
Subject: Using alternate working directory
Date: Sun, 22 Sep 2013 00:04:24 +0300
Message-ID: <523E09D8.8090808@rachum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 23:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNULz-00056x-HT
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 23:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab3IUVE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 17:04:28 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:58661 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3IUVE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 17:04:28 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so847347wib.4
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=mnmlwhnKKz2QQwCDn/sc1m+3rRy6sI22iJeseeOoClc=;
        b=G62WVtMWXNA+4Hak4vfLRltiReZqWsBfvaRJ+ghb5XCATzpHq4Exx2o5V+pjrkZQUl
         WtUWPzcVn0/FsQ4BYRWDO4GVrjWm1db9ADN94LhzPwwNLEDSa5UFVRmwh1ZC4BoJXW9o
         zDh2UbsisN0pg7bs797dHYh38IyDVFwehau4nWvnqIlUgU15AKZ5ctt2IDLfLw7NMVV2
         gysRcDoe3NcyzR66qmRAkj9fTADLueynXDtRkOsHfYrFLRUyZ6iS0MzQPjCWm9c34qX5
         OhXmmrTH43W6JPZqCZ1ND1n/o55IFW8vcAO37ok1PFzGRgTvXHZTbOHpdtTqe1ctvWDe
         zDHA==
X-Received: by 10.180.9.69 with SMTP id x5mr7529497wia.41.1379797467126;
        Sat, 21 Sep 2013 14:04:27 -0700 (PDT)
Received: from [192.168.1.100] ([109.226.59.239])
        by mx.google.com with ESMTPSA id mb7sm14511120wic.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 14:04:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235146>

Hi everybody!

I need some help with Git.

I'm making a script `gm` which lets me merge one branch into another 
without having either checked out. It works for some cases but not all. 
I'm trying to make it work for more cases.

I concluded that the best way to do it would be by using an alternate, 
temporary working directory instead of the repo itself.

This is my script:

     https://gist.github.com/cool-RR/6575042

Now, the problem is that when I try it, it gives these errors:

     git checkout-index: my_file is not in the cache and then error:
     my_file: cannot add to the index - missing --add option?

Anyone has any idea what to do?

P.S. I've also asked this on Stack Overflow, so whoever comes up with an 
answer can claim his 150 imaginary internet points on that question.


Thanks,
Ram.
