From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Tue, 10 Oct 2006 11:57:25 +1300
Message-ID: <46a038f90610091557l2dcfb7bbn7fe2c512af7c4f3c@mail.gmail.com>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
	 <4529B77A.707@gmail.com>
	 <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
	 <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
	 <Pine.LNX.4.63.0610100045430.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Liu Yubao" <yubao.liu@gmail.com>,
	"Dongsheng Song" <dongsheng.song@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 00:57:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX43t-0005tx-UW
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 00:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWJIW51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 18:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWJIW51
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 18:57:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:32993 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751894AbWJIW50 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 18:57:26 -0400
Received: by nf-out-0910.google.com with SMTP id x30so97286nfb
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 15:57:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q/VUwOqBgn3kuBeQOfRN5c126AyIZn/baI79E6eGsoHb1x82OiAoYI0ApjIvjeYNrsBY3hCjG9Wgb0+Q1vom0YhLC99PvJQ+DorSg9MfQ+yvyfwQPOyaJaoXQB8rSwh6wj5+9UY8pKdvEKLzUsSH1uLSYICKVL000DlzqdrYHZ4=
Received: by 10.49.90.4 with SMTP id s4mr472378nfl;
        Mon, 09 Oct 2006 15:57:25 -0700 (PDT)
Received: by 10.49.11.5 with HTTP; Mon, 9 Oct 2006 15:57:25 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610100045430.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28585>

On 10/10/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> If you have the path, you can reuse the whole algorithm for finding
> the best delta base.

Can I do that from Perl/bash? (how?)

> However, if you do not have the path, you might as well just give up (if
> there is no perfect match for the SHA1), since the SHA1 is _not_ similar
> for similar contents. IOW, you'd literally have to search _all_ objects in
> the repository, which usually takes a long, long time.

So the delta base algorithm doesn't work without a path. I thought we
had a quick way to find blobs of similar size. If the user can't even
give us a filename (that we can use to try and build a likely path)
then they have bigger problems than the delta ;-) -- at some point we
have to provide git-paddedcell for the remaining <ahem> users.

cheers,


maritn
