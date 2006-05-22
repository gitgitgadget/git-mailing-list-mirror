From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 07:46:23 +1200
Message-ID: <46a038f90605221246l6df6662dsb79d524ba2f0780d@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <446FA262.7080900@gentoo.org>
	 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	 <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
	 <44713BE4.9040505@gentoo.org>
	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <Pine.LNX.4.64.0605221013020.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 21:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiGMF-0006VS-C3
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWEVTqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWEVTqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:46:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:35195 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750758AbWEVTqY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 15:46:24 -0400
Received: by wr-out-0506.google.com with SMTP id 68so304448wri
        for <git@vger.kernel.org>; Mon, 22 May 2006 12:46:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=afrytZj5SA2z6MpYDlNMkjzKwt3oHTSpUov7cTdsa80kyMpPwTct1V0HLWBpS0lZJcj58LzvLzFKHcVVD0snt4pQEsfcQVWhLLctoTtdk71pRnijNZ30e8VFPdasK8FYxFu3yikkXW+eHjqstDTb1rPS8oB/goUFhFG/XddlBAE=
Received: by 10.54.132.6 with SMTP id f6mr2243260wrd;
        Mon, 22 May 2006 12:46:23 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 22 May 2006 12:46:23 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605221013020.3697@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20527>

On 5/23/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Ok, initial results are promising. git-cvsimport appears to be still
> slowly growing, but it's at 40M (ie pretty tiny, considering that cvsps
> grew to 800+MB on this archive) and growth seems to actually be slowing.

That's great news. The cvs archive seems to have large commits every
once in a while, so I suspect the residual memory growth may be
related to those. Or to a smaller leak I haven't nailed.

My test box is bloody slow it seems. I'll try and get hold of a faster
machine to run this if I can.

> As to packing, it doing something like

Given that we are running batch, it is safe and simple to stop the
import, repack, prune-packed, and keep going. Don't think we'll win
any races by running it in parallel ;-)

cheers,


martin
