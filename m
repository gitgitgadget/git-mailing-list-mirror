From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Compiling on Windows
Date: Thu, 20 Oct 2011 23:38:26 +0200
Message-ID: <4EA094D2.7050807@lyx.org>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com> <4E9E811C.10205@lyx.org> <2015B7F2CEAE4B449EA4EF744F9B8FD9@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Git MsysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 23:38:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RH0Jy-0002co-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 23:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab1JTVid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 17:38:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59108 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab1JTVid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 17:38:33 -0400
Received: by wyg36 with SMTP id 36so3357870wyg.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 14:38:31 -0700 (PDT)
Received: by 10.216.229.18 with SMTP id g18mr4955294weq.45.1319146711786;
        Thu, 20 Oct 2011 14:38:31 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id a21sm17959557wbo.10.2011.10.20.14.38.29
        (version=SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 14:38:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <2015B7F2CEAE4B449EA4EF744F9B8FD9@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184042>


>> I once wrote a little step-by-step tutorial on how to compile the 
>> native Windows Git with MSVC (Express).
>>
>> http://blog.vfrconsultancy.nl/#post0
>
> The blog post filled in a few gaps in the Msysgit README instructions 
> about where to place the various downloads described.

I updated the post a little so that it actually works again. I somehow 
like to have a real native Windows compilation of Git.

To successfully compile Git, we also need to change
> #include <sys/resource.h>
into
> #include <io.h>

I have seen some communication about this in the past, but nobody cared 
enough to fix this.

Shall I sent a patch that adds a file "compat/win32/sys/resource.h" 
which just includes "io.h" ? Or is there another more prefered way to 
fix this ?

Vincent
