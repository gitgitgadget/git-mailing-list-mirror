From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Understanding version 4 packs
Date: Tue, 27 Mar 2007 08:46:20 +0200
Message-ID: <e5bfff550703262346q54853791scca3bab217a043aa@mail.gmail.com>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
	 <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
	 <20070325083530.GA25523@bohr.gbar.dtu.dk>
	 <20070325091806.GH25863@spearce.org>
	 <e5bfff550703260516q5da5f46et8aab2ebadcd9cceb@mail.gmail.com>
	 <alpine.LFD.0.83.0703261015110.3041@xanadu.home>
	 <e5bfff550703261010u67aa1207j1c6f0200bb7744a@mail.gmail.com>
	 <alpine.LFD.0.83.0703261417520.3041@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Peter Eriksen" <s022018@student.dtu.dk>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW5Rx-0005AC-Sd
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 08:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbXC0Gqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 02:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbXC0Gqa
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 02:46:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:22623 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965055AbXC0Gq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 02:46:29 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1822719wra
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 23:46:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ob66Y6+qgckBsU3tGRhyn1Kc8bjNSOkC1PiSo84PgHlGixxI6rjV7z7/DtM5SIeOIp+ECDY/iddWee77ml9gVzHBk4BAhqKy1iHz/bEx1Hdqhhv9bNKg+4U8msVhuTKvRWjqZblT/eGahzBjg4eW7rs9P5PctUX5YhvPVfxhz8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OqRQr+ZNWX0sI809FEQTRhAo6I/Z5/7ilDgUm7LhPMc3phBmXEEfRNSzVYl2rqVBZbMzkI+Y8ZT1ol3Pki4FZLowSDi1AcqYeOeSGcvx8nWNfkmkrfMcM0m2xN4A/VUChEkNvZD8O2AYFgdFU/5zXkhA+r4UuMS33fcq7/BdBNI=
Received: by 10.114.205.1 with SMTP id c1mr3043059wag.1174977980257;
        Mon, 26 Mar 2007 23:46:20 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Mon, 26 Mar 2007 23:46:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.83.0703261417520.3041@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43232>

On 3/26/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 26 Mar 2007, Marco Costalba wrote:
>
> Hence, the path component table would contain:
>
>         drivers
>         usb
>         host
>         Kconfig
>         Makefile
>         ehci.h
>         ehci-pci.c
>         ohci-pci.c
>         sched.c
>
> along with the mode bits for each of those path components, and this is
> what the new tree object would index into for each tree record.
>

Now I understand.

Just a question. So getting full paths does it requires some additional work?

 Marco
