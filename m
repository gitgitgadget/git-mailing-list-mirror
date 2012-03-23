From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Currently checked out branch is not bold in gitk when using ssh
 X-forwarding
Date: Thu, 22 Mar 2012 19:02:21 -0500
Message-ID: <4F6BBD8D.1050905@gmail.com>
References: <CALykgB0LCjDsMYSB1jAxBmPxsf-f6XDDFv+1nmtvCLP65ex5vw@mail.gmail.com> <4F6BB0EC.2080209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeremy Ramer <jdramer@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Mar 23 01:02:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SArxc-0008OL-Q2
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 01:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab2CWACY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 20:02:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40942 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab2CWACX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 20:02:23 -0400
Received: by ghrr11 with SMTP id r11so2336153ghr.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 17:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=4BgN0P6MjRpLICJPLEugFLxCD9Bbum79Cn/hZlKLVmw=;
        b=XTDJ3hnOox7F4lTVD+CX5pgaqa4uOle+1AmqTiEVCMB6Iicthhz5lRk6gwOUdS+LJY
         cDiTUDEgZs7+UlCkXqPokBj7Mk8Np7vaMvnDzQ3o2Ktte5MhCrdA1GtvXZqwkRTRmSwG
         64rR8+VASI/BkeolACDmVF0ZZiztx2QfKEo8b0CvhAZxPhlOnfTGFpMQHC4zd8XaRftz
         fmg205TtaL3EYZVSReLtGQZ31drC1X/pyDpd07viAFDwOrb7I3O/LgYLU342fFTKqtvB
         cgRCXAET/aidnWEqQf24h2nrhcXuV6/KqvsASFDjNnKBQpEONVFQuP9KVExUO6dWgzUR
         rUhQ==
Received: by 10.60.4.162 with SMTP id l2mr13023564oel.3.1332460942775;
        Thu, 22 Mar 2012 17:02:22 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id b2sm6187931obo.22.2012.03.22.17.02.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 17:02:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <4F6BB0EC.2080209@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193736>

On 3/22/2012 6:08 PM, Neal Kreitzinger wrote:
> On 3/22/2012 4:10 PM, Jeremy Ramer wrote:
>> However, when I log in from my newer Ubuntu 11.11 laptop (ssh -X
>> buildserver) and start gitk the currently checked out branch is
>> not displayed in bold font. In fact, all the fonts are a little
>> ugly, though it is the lack of bold that is the hardest to work
>> with.
>>
> FWIW, my theory is that is has something to do with your fonts. Just
> a simple end user observation. I'm not a gitk programmer.
>
> Maybe you don't have your fonts set for what-you-want in gitk. Maybe
> you don't have the fonts installed/setup on your ubuntu box for
> what-you-want in gitk.
>
> I assume gitk uses the fonts that you tell it to, or that are
> available.
>
Hint: the bold version of a font is its own font.  You could have the 
non-bold font installed, but not the bold font.  Here's a link on how to
install fonts: http://karmak.org/archive/2004/06/ttfonts.html?lang=en

*If* that is the reason for your lack of bold-ness in gitk.

Also, I see from my install log that it does do something with fonts:

  DEST /usr/share/git-gui/lib
     INSTALL 644 tclIndex
     INSTALL 644 about.tcl
     INSTALL 644 blame.tcl
     INSTALL 644 branch_checkout.tcl
     INSTALL 644 branch_create.tcl
     INSTALL 644 branch_delete.tcl
     INSTALL 644 branch_rename.tcl
     INSTALL 644 branch.tcl
     INSTALL 644 browser.tcl
     INSTALL 644 checkout_op.tcl
     INSTALL 644 choose_font.tcl

I'm not sure how closely gitk and git-gui are tied together.

Hope this helps some more.

v/r,
neal
