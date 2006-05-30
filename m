From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsimport problem
Date: Tue, 30 May 2006 13:56:33 +1200
Message-ID: <46a038f90605291856s30724967pb71b5acc5e4e139f@mail.gmail.com>
References: <Pine.LNX.4.63.0605300236270.25988@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 30 03:56:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FktTL-0006I9-L0
	for gcvg-git@gmane.org; Tue, 30 May 2006 03:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWE3B4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 21:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWE3B4f
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 21:56:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:29563 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWE3B4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 21:56:34 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1001430wra
        for <git@vger.kernel.org>; Mon, 29 May 2006 18:56:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=etOIbBeQUFhWwSygkppb5TohjbNhNvNC/kQEKTzq/Ax8sl/I/bJhVk1rMtPoL+2zoYLLCg0dTBsuuvx9UGkDhNtWsYj0vAkSGBtAuwyGF0bj44PEllMI2J1aQLzRc3nfgfIukdozYT9qh8PbQ4V8zpcq8920V+iNscC7GoHOqZE=
Received: by 10.54.130.19 with SMTP id c19mr681773wrd;
        Mon, 29 May 2006 18:55:29 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Mon, 29 May 2006 18:56:33 -0700 (PDT)
To: "Grzegorz Kulewski" <kangur@polcom.net>
In-Reply-To: <Pine.LNX.4.63.0605300236270.25988@alpha.polcom.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21004>

On 5/30/06, Grzegorz Kulewski <kangur@polcom.net> wrote:
> I think I hit some problem in git-cvsimport or maybe cvsps or maybe (but
> unprobable) in network communication.

Looks like a cvsps issue. From ps, grab the whole commandine that is
used for the cvsps invocation and try to run it manually. cvsps has
some debugging flags, I would try adding -x -v to see more output, and
perhaps try with --no-cvs-direct

The other thing affecting you is the version of the remote cvs server.

cheers,


martin
