From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 20:36:01 +0700
Message-ID: <fcaeb9bf0701230536p536f3326w36f2b272c869c5cf@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <200701222127.09601.johannes.sixt@telecom.at>
	 <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 14:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Lov-0003io-N0
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbXAWNgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXAWNgH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:36:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:51269 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965067AbXAWNgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 08:36:04 -0500
Received: by wr-out-0506.google.com with SMTP id i22so976874wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 05:36:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k7FaBb1O7QuzaUK/NuGtkVMNJo0NGGwaN01P1/E/uEAmWcSlthjsNkxdKliPU8iz3F9X23E1zh4TpPDBRTa/rVu16ANRIDhlWhVsob10m9L/oXfXmmss4T2/WcVtheM0PmIxVv4kHJB4EQY4tqpd/HYGwMYP3eJ7EJntqLvqHRY=
Received: by 10.78.200.3 with SMTP id x3mr342347huf.1169559361216;
        Tue, 23 Jan 2007 05:36:01 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 23 Jan 2007 05:36:01 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37517>

On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On the third hand, I fully expect git on Windows to be used only by GUI
> wieners who cannot handle the command line, let alone a pager! ("WTF! How
> do I go back to that dollar thingie? You know, where I type git-blabla?")

If I have to use git on Windows (very likely now that this port seems
to work), I'd much prefer command line interface. cmd.exe may be not
good enough so I think we should include bash in git-win32 package.
Many git commands are still bash scripts and new commands are often
coded as bash scripts. So we need bash in Windows anyway unless
Windows Git users accept a limited git version. (no-perl git is
acceptable to me).
-- 
Duy
