From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Wed, 24 May 2006 09:13:33 +1200
Message-ID: <46a038f90605231413g5f9f46a6p9cf15726526484f0@mail.gmail.com>
References: <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
	 <20060523065232.GA6180@coredump.intra.peff.net>
	 <20060523070007.GC6180@coredump.intra.peff.net>
	 <46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com>
	 <Pine.LNX.4.64.0605230948280.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0605231232360.5623@g5.osdl.org>
	 <46a038f90605231329w35d10cfdg1ac413ebf8d32e11@mail.gmail.com>
	 <20060523211016.GB16164@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 23:13:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FieC9-00048g-GW
	for gcvg-git@gmane.org; Tue, 23 May 2006 23:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWEWVNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWEWVNf
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 17:13:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:35892 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932278AbWEWVNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 17:13:34 -0400
Received: by wr-out-0506.google.com with SMTP id i3so1347750wra
        for <git@vger.kernel.org>; Tue, 23 May 2006 14:13:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ts4oqgCEVlQre/4YeWKHBWF/ncc87TNJMCOS8k/wemfnN+a2YVRWORcHJOKy1zsG65DFUMOZB7w1uqjJoOzUyFVDbkbWgzX41cccYEbLzaqJ0DdJf6lz6TKe2FCl3t9dd/xrOaeE06fGTbnllRR8ow+NLvWg5Utn9m1uTRLG1HY=
Received: by 10.54.153.18 with SMTP id a18mr6386420wre;
        Tue, 23 May 2006 14:13:33 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Tue, 23 May 2006 14:13:33 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Matthias Urlichs" <smurf@smurf.noris.de>, git@vger.kernel.org
In-Reply-To: <20060523211016.GB16164@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20640>

On 5/24/06, Jeff King <peff@peff.net> wrote:
> On Wed, May 24, 2006 at 08:29:07AM +1200, Martin Langhoff wrote:
>
> > Strange! Cannot repro here with v5.8.8 (debian/etch 5.8.8-4) but
> > initialising it doesn't hurt, so let's do it:
>
> I can reproduce with debian perl 5.8.8-4. The bug is only triggered by
> 0-length files, so presumably your test repo doesn't have any.

Given that we are all working off the gentoo repo here, it means that
my machine is slower than Linus' unreleased Intel box. And that I am
too impatient...

In any case, the fix is correct as Junio points out.

cheers,


martin
