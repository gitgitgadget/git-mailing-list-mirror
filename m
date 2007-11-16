From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: New repo quickly corrupted
Date: Fri, 16 Nov 2007 06:45:03 +0100
Message-ID: <200711160645.04352.chriscool@tuxfamily.org>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com> <alpine.LFD.0.9999.0711151708470.21255@xanadu.home> <alpine.LFD.0.9999.0711151434290.4260@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jason Sewall <jasonsewall@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 06:38:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IstuZ-0003RG-D9
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 06:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbXKPFiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 00:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXKPFiX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 00:38:23 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48238 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbXKPFiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 00:38:22 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D8BC21AB2B4;
	Fri, 16 Nov 2007 06:38:20 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9C35B1AB2B6;
	Fri, 16 Nov 2007 06:38:20 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.9999.0711151434290.4260@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65192>

Le jeudi 15 novembre 2007, Linus Torvalds a =E9crit :
> On Thu, 15 Nov 2007, Nicolas Pitre wrote:
> > Does "dos2unix" override file access bits?  Because the object stor=
e is
> > always made read-only.
>
> Almost all programs like that will entirely ignor the fact that somet=
hing
> is read-only.

What if the .git/objects/ sudirectories were also read-only ?

Christian.
