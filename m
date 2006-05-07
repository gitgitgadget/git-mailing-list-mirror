From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Mon, 8 May 2006 11:27:24 +1200
Message-ID: <46a038f90605071627i6a335f61lf5e35291bfbe340c@mail.gmail.com>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <87mzdx7mh9.wl%cworth@cworth.org>
	 <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
	 <e3fqb9$hed$1@sea.gmane.org>
	 <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
	 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
	 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
	 <20060507120149.40e9f749.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 01:27:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcsew-0001XF-R1
	for gcvg-git@gmane.org; Mon, 08 May 2006 01:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWEGX1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 19:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWEGX1Z
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 19:27:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:11524 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750817AbWEGX1Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 19:27:25 -0400
Received: by wr-out-0506.google.com with SMTP id 68so849853wri
        for <git@vger.kernel.org>; Sun, 07 May 2006 16:27:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EvjwhD5td3P9Zp/oAAJU2DMMg9V8eRaNNQEybI+oyQRNefQOOjifLss0QOpLEohUSUr4syV0isufbHR5MKQN2fvL9j5vtP/0Ywuf7uoPqficLqnH2BOEwQ08XBvnccgmCeY7E4qm0G5/0qPTR2PnX6GN2QCDL8JNb9NkysTGnk8=
Received: by 10.54.98.15 with SMTP id v15mr1612752wrb;
        Sun, 07 May 2006 16:27:24 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Sun, 7 May 2006 16:27:24 -0700 (PDT)
To: "Sergey Vlasov" <vsu@altlinux.ru>
In-Reply-To: <20060507120149.40e9f749.vsu@altlinux.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19722>

On 5/7/06, Sergey Vlasov <vsu@altlinux.ru> wrote:
> For linux v2.6.16:
>
> 7,3M commits-b41b04a36afebdba3b70b74f419fc7d97249bd7f.pack
>  24M commits_trees-8397f1c2a885527acd07e2caa8c95df626451493.pack
>  97M full-c7b2747a674ff55cb4a59dabebe419f191e360df.pack

With this pack arrangement, do you get any noticeable difference in
walking commits? How about walking commits+trees with git-log <path> ?

I wonder whether segregating packs by object type would make things better...

cheers,



martin
