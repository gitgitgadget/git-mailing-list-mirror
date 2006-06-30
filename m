From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] save another call to git-update-index
Date: Fri, 30 Jun 2006 09:22:17 +0200
Message-ID: <81b0412b0606300022k68d13dg8e292d9b768df51c@mail.gmail.com>
References: <20060630002756.GD22618@steel.home>
	 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <fork0@t-online.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:22:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDKY-0003A8-T1
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWF3HWU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWF3HWU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:22:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:5478 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932119AbWF3HWS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:22:18 -0400
Received: by nf-out-0910.google.com with SMTP id o63so187386nfa
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 00:22:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Np4p6MhceBLvkwJUHQ2gFuslzqO9PScxLnpBFyl+fVYIGSTmGdZBt0ABEHtFIbydUTcHa3+hANmSFNjCSXn9Fufuh2mO4r4fN7PHA/btrwCYj3GJSzhc7OmbPgbnMEBBjhWaFBBl+9LfRcjQrXulOGKnnQUUzxz9sNvNdKSQjdU=
Received: by 10.78.177.3 with SMTP id z3mr5046hue;
        Fri, 30 Jun 2006 00:22:17 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Fri, 30 Jun 2006 00:22:17 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22962>

On 6/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> FYI I've been just battling this pipe for a couple of hours. The first
> steps were easy, but since I wanted to do it incrementally, the index has
> to be written every so often, and I seem not to be able to get that right.
>
Are you sure? Does something use the index between starting update-index
pipe and pclose?
