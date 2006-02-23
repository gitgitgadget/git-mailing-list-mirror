From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 09:00:24 +0100
Message-ID: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060220191011.GA18085@hand.yhbt.net>
	 <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
	 <43FB9656.8050308@vilain.net>
	 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 09:00:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCBOq-0003Px-SR
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 09:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWBWIA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWBWIA1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 03:00:27 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:33656 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751478AbWBWIA0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 03:00:26 -0500
Received: by nproxy.gmail.com with SMTP id b2so1069927nfe
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 00:00:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sKcNRh2l0NbACprotDIWL3+9RofgjBoavkri90SmC2ONxQzmPBHwBSwypA/WlSja2zxwU3BG/gk8TvDQy3l4uqFxNWKKekLoWyNemyY4Ucj4zzw4ThkQmOX5htsj647c8BqIJLW8adsLAtaG3R/FBoJzXv6Agm8qVsbBF1MSK5o=
Received: by 10.49.18.20 with SMTP id v20mr2252865nfi;
        Thu, 23 Feb 2006 00:00:24 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 00:00:24 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16633>

On 2/22/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > IPC::Open2 works!
>
> Note that there is a notable decrease in performance in my preliminary
> tests (about 10%).

I'll keep that in mind. But there are places where a safe pipe is unavoidable
(filenames. No amount of careful quoting will save you).
