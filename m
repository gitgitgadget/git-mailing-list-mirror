From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: Re: [Patch] git-cvsimport: tiny fix
Date: Thu, 18 May 2006 15:29:57 +0200
Message-ID: <20060518132956.GA19476@memak.tu-darmstadt.de>
References: <20060510173703.GA10335@memak.tu-darmstadt.de> <7vd5eccvns.fsf@assigned-by-dhcp.cox.net> <46a038f90605172153mac96f40id9a50d2f29c75915@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 15:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgia1-0003CM-Im
	for gcvg-git@gmane.org; Thu, 18 May 2006 15:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWERNaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 09:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWERNaJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 09:30:09 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de ([130.83.48.97]:64987
	"EHLO baerbel.mug.maschinenbau.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S1751021AbWERNaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 09:30:07 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de (localhost [127.0.0.1])
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4) with ESMTP id k4IDTvUA019767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 May 2006 15:29:57 +0200
Received: (from tacke@localhost)
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4/Submit) id k4IDTvGJ019765;
	Thu, 18 May 2006 15:29:57 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Elrond <elrond+kernel.org@samba-tng.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90605172153mac96f40id9a50d2f29c75915@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: ClamAV 0.88.2/1467/Tue May 16 23:21:47 2006 on baerbel.mug.maschinenbau.tu-darmstadt.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20286>

On Thu, May 18, 2006 at 04:53:56PM +1200, Martin Langhoff wrote:
> On 5/18/06, Junio C Hamano <junkio@cox.net> wrote:
> >Could somebody who actually works with CVS import Ack this?
> >Pretty please?
> 
> Sounds sane. It would be interesting to hear about what repo (and
> server) this was seen against. Elrond, can you tell us more about
> this?

This is a private local repository.
git-cvsimport starts a local "cvs server" for this.

I tried to create a minimal repo, that would trigger the
same behaviour, but didn't succeed. My current guessing is,
that this happened in cooperation with "cvsps" caching.
(cvsps is a tool used by git-cvsimport).

I will move the cvsps cache for my problematic repo out of
the way and try a git-cvsimport from scratch to verify that
the above mentioned issue is related to cvsps caching.
But I still think, that handling all cvs pserver replies
should be done anyway in git-cvsimport (when it relies on
this mode of operation).


    Elrond
