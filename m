From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make t8001-annotate and t8002-blame more portable
Date: Mon, 19 Jun 2006 18:35:39 +0200
Message-ID: <81b0412b0606190935g67581ebucf172acb36e53b02@mail.gmail.com>
References: <20060618203321.G2e8b0080@leonov.stosberg.net>
	 <7v3be218ri.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dennis Stosberg" <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 18:36:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsMj9-000717-9z
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 18:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWFSQfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 12:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWFSQfm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 12:35:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:18657 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964791AbWFSQfl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 12:35:41 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1859330ugf
        for <git@vger.kernel.org>; Mon, 19 Jun 2006 09:35:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AVB1seLG2YPDE1CE0B8unVM4pDUbH69Cg6zX4W1hwdBPqvT9XYMTqjM4+S9bkR/GKK5lJTAE+aDTonLIBs7QLwFmaTXuMRPaoaL9bpbNbrlZj6u9+0biHk61zA/K1PBzoU4VMneUnzuNFvg43vYLhdhh0ZNImOuT7Q9XAK8POYY=
Received: by 10.78.56.19 with SMTP id e19mr2253699hua;
        Mon, 19 Jun 2006 09:35:40 -0700 (PDT)
Received: by 10.78.137.7 with HTTP; Mon, 19 Jun 2006 09:35:39 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v3be218ri.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22129>

On 6/18/06, Junio C Hamano <junkio@cox.net> wrote:
> > +    'perl -pi -e "s/^1A.*\n$//; s/^3A/99/" file &&

activestate perl again: doesn't work without giving a backup file extension,
like this: perl -pi.bak -e ...
