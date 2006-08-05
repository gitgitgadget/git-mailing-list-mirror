From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git files data formats documentation
Date: Sat, 5 Aug 2006 01:48:23 -0400
Message-ID: <9e4733910608042248s18443277j436298229ed5ec05@mail.gmail.com>
References: <44D42F0D.3040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 07:48:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9F1Q-0008Rv-B4
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161419AbWHEFsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161462AbWHEFsZ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:48:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:43841 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161419AbWHEFsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:48:24 -0400
Received: by nf-out-0910.google.com with SMTP id k26so120375nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:48:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rll4bUAvUQ3C+kAnjQYOQ+g2aP2OS+LJr7URAl7VYdvpQ5T5Q9DakUAVOWn2Wct9JKDGq3WuAVgkS04O9AX+h+jeBtusfv5bpYZ27X7201+IHdOP5AvKmDFvRO4MYhTGu+2wNln5UavCPbmhJARH4kjOrBS/XuyE8GvKOYwVuVA=
Received: by 10.78.136.7 with SMTP id j7mr1813648hud;
        Fri, 04 Aug 2006 22:48:23 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 22:48:23 -0700 (PDT)
To: gitzilla@gmail.com
In-Reply-To: <44D42F0D.3040707@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24888>

You might make some notes about old format headers and new format ones
and the use_legacy_headers flag.

I started off looking at packs so I knew about TYPE_AND_BASE128_SIZE.
Next I wanted to write objects so I looked at sha1_file.c. If you
don't look at the code closely write_binary_header() will lead you to
believe that object files use TYPE_AND_BASE128_SIZE. It took me a
couple of hours to notice use_legacy_headers and discover that it
defaults to on.

Jon Smirl
jonsmirl@gmail.com
