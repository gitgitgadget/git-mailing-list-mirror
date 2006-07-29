From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: Re: [PATCH] Teach the git wrapper about --name-rev and --name-rev-by-tags
Date: Sat, 29 Jul 2006 19:43:29 +0700
Message-ID: <fcaeb9bf0607290543h12b70c74q54a1fbfc3c8e3b7e@mail.gmail.com>
References: <20060524131022.GA11449@linux-mips.org>
	 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
	 <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
	 <20060525131241.GA8443@linux-mips.org>
	 <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0607280952200.4168@g5.osdl.org>
	 <Pine.LNX.4.63.0607282042470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 14:43:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6oAH-0004xq-Gg
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 14:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWG2Mna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 08:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWG2Mna
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 08:43:30 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:58526 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932130AbWG2Mn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 08:43:29 -0400
Received: by wx-out-0102.google.com with SMTP id t10so44454wxc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 05:43:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CtlLT90DxlCBLXFt2+E9EdTt8Yp23ydzeuQBjbt4v6JC4NjVjZVSF+GaYuj9jXJDfdhJ3ocqERzxT0Cp7YjlxpcKq1aJW/ur6dktC7VlP+jJUnlv9BUbzmF0BKEgT+7HQAk930Ip3TEO9vYE9W5sz9q3CBdpMLriR9RzczlkXdQ=
Received: by 10.70.11.11 with SMTP id 11mr490167wxk;
        Sat, 29 Jul 2006 05:43:29 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Sat, 29 Jul 2006 05:43:28 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607282042470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24424>

On 7/29/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> You are probably right. But _I_ want to know that e.g. commit
> a025463bc0ec2c894a88f2dfb44cf88ba71bb712 is really tags/v1.4.0^0~27^2.
> Both are immutable, but the latter is nicer to people than to computers.
I think so too. I had requested a similar feature on the git survey
and was surprised to see this patch. I'd appreciate it.
