From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [msysGit] Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 20:14:01 +0100
Message-ID: <e5bfff550712171114i40a59b11md87038a3fc13d29c@mail.gmail.com>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
	 <fk2p0f$961$1@ger.gmane.org>
	 <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
	 <fk2q1f$bbh$1@ger.gmane.org>
	 <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>
	 <fk3153$rtb$1@ger.gmane.org>
	 <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>
	 <fk5grp$7il$2@ger.gmane.org>
	 <Pine.LNX.4.64.0712171042520.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Abdelrazak Younes" <younes.a@free.fr>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4LQB-0006sv-Nu
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 20:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103AbXLQTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 14:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756946AbXLQTOL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 14:14:11 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:39160 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbXLQTOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 14:14:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1975847rvb.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yYuWOfkBETJKWDxZnbDhYHBllL9L0bq/ih+rpQdyPlI=;
        b=bO+IFCC9C77UYKUQPb+E0iiubp5wmjBJ0v5HLPoKfE5t+G8ov07XxzvkduE6PrS7bwKWaB1WR6ovaRa00N4ra9Skk59rfXQcDZgrXjWm8cIUiNo0a59Zc8JxalPZ6Ckyo7nHIaou5m3ttEKKIKpL3+/Aa6ELtqMRgqszSTYbBSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2q/Rft0aWsm6Twhr2a04mcfPbU+/Hsrd8ITA2BLppRc/UUpvruJPaWA7eaunq2Lyh6lUE0K00W1JRIXojlyVvp2ZiQxkEkaJ+BZMcwGhoGJBjSaExeaVPJXDmFpFygc4W6ex4MflBAgt1gnsE59KIQlSKyWy7NveFBQWEwdfPY=
Received: by 10.141.167.5 with SMTP id u5mr1553452rvo.71.1197918841572;
        Mon, 17 Dec 2007 11:14:01 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 17 Dec 2007 11:14:01 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712171042520.9446@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68604>

On Dec 17, 2007 11:44 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Why would anything that has to do with MSVC2005 be interesting to msysGit?
> Note the "msys" part of "msysGit".
>
> FWIW a member of our team works on compiling/including qgit into msysGit.
> But definitely not using closed-source compilers.  I would violently
> oppose that.
>

I would (violently) agree with you, but I also violently oppose to
waste a week end fighting with Qt4 + mingw compilation. MSVC2005 is
needed as a kind of "debug tool" to better understand if the problem
is with Qt4 or with mingw (as I suspect).

Abdel is very kind to try to help in caming out with a qgit.exe more
or less ready to be packaged. I'm not opposed, in this phase, to
follow different _technically_ sound paths. Then when the dust settles
down we could do our consideration regarding open source, in which I
belive very firmly, so firmly that I'm not scared to _test_ different
ways if this can be useful to shed some light on this issue.

Marco
