From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 09:47:42 +0600
Message-ID: <200702140947.43527.litvinov2004@gmail.com>
References: <45CFA30C.6030202@verizon.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org> <20070213204248.GA21046@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 04:48:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHB7h-0006hC-NI
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 04:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbXBNDrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Feb 2007 22:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXBNDrx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 22:47:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:60236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXBNDrw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Feb 2007 22:47:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so52176uga
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 19:47:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=r9F0RLFpC5FQxgKnrxDxjRDPLtB/rbuzIrXKDrzwvvHLaOEx08wDsL8po459PNHPTj/7Q7K35O8H93y0uEorUgHxuvu/BZR1w15M9oWDeeSSU63o7vzk60gTsofR4stIhJQp58GJAwtOkGon+nSssR61dIovZbbRcJtyb7cDrZw=
Received: by 10.67.119.9 with SMTP id w9mr17257641ugm.1171424871254;
        Tue, 13 Feb 2007 19:47:51 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 34sm166295uga.2007.02.13.19.47.49;
        Tue, 13 Feb 2007 19:47:50 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <20070213204248.GA21046@uranus.ravnborg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39614>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Wednesday 14 February 2007 02:42 Sam Ravnborg =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB(a):
> I wonder what we are really trying to address here. Or in other words
> could the original poster maybe tell what Windows IDE's that does
> not handle UNIX files properly?
MS VC has text file for project file but don't like \n line endings, on=
ly=20
\r\n.
