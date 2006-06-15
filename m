From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Thu, 15 Jun 2006 13:26:27 +0200
Message-ID: <8aa486160606150426q19b0a661s@mail.gmail.com>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 13:26:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqpzb-00032n-Ke
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 13:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWFOL02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 07:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWFOL02
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 07:26:28 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:16901 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030226AbWFOL02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 07:26:28 -0400
Received: by wx-out-0102.google.com with SMTP id h28so255084wxd
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 04:26:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mGMGOIn7BqgxIC2TuvNWIrUOoavcZNGw1enxaVWhXKV5o6x0pxtESU91eBHPbHXQjlcf1WyKZlqKyc2zHox5TT8I0i0++8KjvlvKyp5MEzl3LBU8vMxxVMEv9L12vpAEXNF/alsEtZmMrizUjH3xRUan9dsd7ZoXG5HQQrl0wFk=
Received: by 10.70.116.8 with SMTP id o8mr2068161wxc;
        Thu, 15 Jun 2006 04:26:27 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Thu, 15 Jun 2006 04:26:27 -0700 (PDT)
To: "Yakov Lerner" <iler.ml@gmail.com>
In-Reply-To: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21889>

Wed, 14 Jun 2006 22:26 +0300, Yakov Lerner <iler.ml@gmail.com>:
> Many times, I mistakenly used 'make prefix=... install' where prefix value
> was different from prefix value during build. This resulted in broken
> install. This patch adds auto-detection of $prefix change to the Makefile.
> This results in correct install whenever prefix is changed.

I do this each time I install packages from source. I keep them with
"stow" and the usual sequence is:

make prefix=/home/santi/usr
make install prefix=/home/santi/usr/stow/git
cd /home/santi/usr/stow/
stow -v git

so with this auto-detection I'll compile some programs twice.

Santi
