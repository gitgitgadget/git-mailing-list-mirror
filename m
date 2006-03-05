From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: What's in git.git
Date: Sun, 5 Mar 2006 23:15:31 +1300
Message-ID: <46a038f90603050215v7afcbd4crc145e85a4da416a7@mail.gmail.com>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90603050121u6bccbb71ve78de69ae45b96ad@mail.gmail.com>
	 <87irqtjjr1.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 11:15:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFqH2-0007Aa-2R
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 11:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWCEKPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 05:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCEKPd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 05:15:33 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:28280 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751316AbWCEKPd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 05:15:33 -0500
Received: by wproxy.gmail.com with SMTP id 70so949407wra
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 02:15:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K8nFb/IAoIJ8nYvO5wX+nZGDvzPJ1OnKyOnDlJYrYfPBatrkfMIPTh6bFHMMPL/+y1klO00E88kH8Rd97AG3uxaRYIui0IIzJdU68OJ1F6CBx9o1361dwJ2p1soUBsyBooDScPB0LcLQZrsJlIjV9SoedSxO9RdmbBW+7RKFtQQ=
Received: by 10.54.117.14 with SMTP id p14mr16114wrc;
        Sun, 05 Mar 2006 02:15:03 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Sun, 5 Mar 2006 02:15:31 -0800 (PST)
To: "Alexandre Julliard" <julliard@winehq.org>
In-Reply-To: <87irqtjjr1.fsf@wine.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17219>

On 3/5/06, Alexandre Julliard <julliard@winehq.org> wrote:
> You can use both. The VC backend is a per-file mode, that's handy when
> you are editing a file and want a quick diff/revert/commit of just
> that file; the commands are executed directly from the buffer
> containing the file. When making bigger changes, you should use the
> git-status mode (the one in git.el), which is a tree browser that
> gives you a view of the whole project.

So I should use a combination of both? Hmmm. Worth exploring, can you
give us a quick guide on getting started with it? (Or where should I
read? I'm not that good with emacs)...

> > Can we get a new merge conflict mode that generates .rej files? Emacs
> > is superb at dealing with conflicts formatted that way. OTOH, it may
> > be able to deal smartly with diff3-style conflicts if it knows how to
> > talk with the VC backend -- I think the cvs mode can do that.
>
> What emacs mode do you use to resolve conflicts?  From the git-status
> buffer, if you edit a file with 'f' it will automatically turn on
> smerge mode if there are conflicts, or you can edit it in ediff merge
> mode with 'd E' like under pcl-cvs. Is that what you mean?

Oh. Ah. Ok! I'll have to try this! So far, I've had good luck
following this guide:

    http://wiki.gnuarch.org/Process_20_2a_2erej_20files

which is targetted pretty much at dumb emacs users. Like me ;-)


martin
