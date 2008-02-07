From: Luke Lu <git@vicaya.com>
Subject: Re: Compiling Git in Mac OS X Leopard
Date: Wed, 6 Feb 2008 23:32:20 -0800
Message-ID: <F1020256-19B0-4B86-A9D8-79E36A058A23@vicaya.com>
References: <E9380AA8-2E38-4733-9940-FFD51BB84700@maisniemi.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sami Maisniemi <sami@maisniemi.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 08:33:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN1G0-0000Az-6I
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 08:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbYBGHcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 02:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbYBGHcc
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 02:32:32 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:37827 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbYBGHca (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 02:32:30 -0500
Received: by wx-out-0506.google.com with SMTP id h31so3574328wxd.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 23:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=VzXVZaCaz3z4/Bm+982XYGIpSjURTEL9+5uOxHabYoc=;
        b=u5b93toxCOQI0JPeCfZLB6GPQ33E8s2iRHcqKq7DjvNYKen5RYcawLGsZX80KyJxXFqu+b22fVZCUUKEUit+EfDB5QjRhKk5d7Fj5uITn6zr/QMHaAZOohHqnZGCijG+EZAlM8BJaLfeN73Fs/DxSERpgPLD2RnjOh//U9FuLLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=iCH9IexoAt/EY7PxFXYoqISB/Cf46zqe10iqHZfN95lqEOx3fImrkcK1u4Deicfe1ehT5CdHIiVw+Lyna8p1/LgWfYL4zsTrWYS1moccKEDTXk9Wv/oE0ahAFjMyg72iY1rAs2DuDzERAhw97aPJjR29CnSXCvT7hn7QQ1BSGTg=
Received: by 10.70.67.1 with SMTP id p1mr6996460wxa.24.1202369545544;
        Wed, 06 Feb 2008 23:32:25 -0800 (PST)
Received: from ?192.168.7.7? ( [69.181.4.225])
        by mx.google.com with ESMTPS id h15sm20329259wxd.23.2008.02.06.23.32.21
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 23:32:22 -0800 (PST)
In-Reply-To: <E9380AA8-2E38-4733-9940-FFD51BB84700@maisniemi.net>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72904>

On Feb 6, 2008, at 11:09 PM, Sami Maisniemi wrote:
> Hi,
>
> I tried to compile Git in Mac OS X Leopard, because I was unable to  
> find any precompiled binaries. However, the compilation was aborted  
> due to the following error:
>
> msgfmt --statistics --tcl po/de.po -l de -d po/
> make[1]: msgfmt: Command not found
> make[1]: *** [po/de.msg] Error 127
> make: *** [all] Error 2
>
> It seems that the makefile uses an application called msgfmt that  
> is not available in Mac OS X Leopard. What is application msgfmt  
> and why it is required? Is there any kind of workaround available?
>
> Regards Sami Maisniemi

Install macports if you haven't and then

sudo port selfupdate
sudo port install git-core

macports should manage all the dependencies needed by the packages  
including gettext which provides msgfmt,  After that you can git  
clone the lastest git.git if you want to mess with git and it should  
compile without any problem.

__Luke
