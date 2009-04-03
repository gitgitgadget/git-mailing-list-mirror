From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] Re: [PATCH] Add custom memory allocator to MinGW and 
	MacOS builds
Date: Fri, 3 Apr 2009 23:42:36 +0000
Message-ID: <a5b261830904031642j27f90501jb22e4dbc6f26040d@mail.gmail.com>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com>
	 <49D61B35.8060508@trolltech.com>
	 <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com>
	 <alpine.DEB.1.00.0904040116300.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: marius@trolltech.com, git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 04 01:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpt3c-0006HF-Mw
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 01:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758394AbZDCXmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 19:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559AbZDCXmk
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 19:42:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:20161 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390AbZDCXmj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 19:42:39 -0400
Received: by ey-out-2122.google.com with SMTP id 4so315985eyf.37
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Nuupr6Nu42r0g6dkLzdXs21WUn+OAZHgwaQ32Muzpig=;
        b=stVtwi7ZvSbEn8zMy6sJvQxwslcaO6DHLfdFPXg7s2ySKMpwFahB2yLZdULC4iSvzi
         vnwT5zR6ga49J36Rgrs97e+qEmj9d9E1jzDBzGNNACa1A7bYof/FjqD36II2xj9dk1Xi
         ImPKfJqtLerhRJrr5fOQBdEe2QPl3/jbfEO2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x+uG3GT++uGd+AVIibHwfWxnWClEwCMI51WjRFASm6PEp+z1g779eauA/amnWh4e3r
         6Oc3134IlWFg5vPZm9x/CMlPStDfSOAx0xpAHfkemXDYTVSC52G34cnndg4in+z5dcty
         8mkQ3XgtDH7uH7VGt94JDK57WSv7s9HwtNYoA=
Received: by 10.216.0.208 with SMTP id 58mr585818web.216.1238802156866; Fri, 
	03 Apr 2009 16:42:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904040116300.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115565>

2009/4/3 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Fri, 3 Apr 2009, Pat Thoyts wrote:
[snip]
>> The difference on Windows Vista is that the low fragmentation heap is
>> the default memory allocator. On Windows XP you need to enable it
>> specifically for an application. So a possible alternative to this is
>> just to enable the low fragmentation heap. (done via GetProcessHeaps and
>> HeapSetInformation Win32 API calls).
>
> Does this also work on NT?
>
> Ciao,
> Dscho

No - the low fragmentation heap was added as an option to Windows XP
and became the default heap in Vista. XP or Server 2003 are
documentated as the lowest versions supporting this on MSDN.

Pat Thoyts
