From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 12:00:37 +1300
Message-ID: <46a038f90602211500m287d82far5fd41270400652a9@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060220191011.GA18085@hand.yhbt.net>
	 <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
	 <Pine.LNX.4.63.0602212315400.12634@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Alex Riesen" <raa.lkml@gmail.com>, "Sam Vilain" <sam@vilain.net>,
	"Junio C Hamano" <junkio@cox.net>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 00:00:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBgUr-0005pC-Uu
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 00:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWBUXAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWBUXAj
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 18:00:39 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:24633 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161168AbWBUXAi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 18:00:38 -0500
Received: by wproxy.gmail.com with SMTP id i31so1226893wra
        for <git@vger.kernel.org>; Tue, 21 Feb 2006 15:00:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iOK4uI3pEV/MUL3EwmPwzdvu7C72kLgmcCh1XNZpeAeLmvqkmMV3GLzeNlYDjfnJUhk1PWkRJLDd3uAFKOYSGuRw5ZmjjYHvlsjrSW4hbuIYzWtvgAdUkwLJkQ4mDzo9c5nWWkCwM0JA8Icwdo+ACOW3W6oqfPCAn3Eh3NGcoyg=
Received: by 10.54.66.14 with SMTP id o14mr5513126wra;
        Tue, 21 Feb 2006 15:00:37 -0800 (PST)
Received: by 10.54.127.9 with HTTP; Tue, 21 Feb 2006 15:00:37 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602212315400.12634@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16572>

On 2/22/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Maybe I am stating the obvious, but it seems that
>
>         open (F, "git-blabla -option |");
>
> would be more portable.


And

    open (F, "git-blabla|", '-option', '$%!|');

would be portable AND safe ;-)

cheers,


martin
