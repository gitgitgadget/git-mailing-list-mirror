From: Junio C Hamano <gitster@pobox.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 09 Nov 2007 09:45:56 -0800
Message-ID: <7vy7d7tiqz.fsf@gitster.siamese.dyndns.org>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com>
	<458BC6B0F287034F92FE78908BD01CE814472B3D@mtlexch01.mtl.com>
	<6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com>
	<200711090613.17566.chriscool@tuxfamily.org>
	<6C2C79E72C305246B504CBA17B5500C9029A36F1@mtlexch01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christian Couder" <chriscool@tuxfamily.org>, <git@vger.kernel.org>
To: "Yossi Leybovich" <sleybo@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXvx-0006BP-FF
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbXKIRqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbXKIRqF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:46:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50239 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbXKIRqE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:46:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0E33A2F2;
	Fri,  9 Nov 2007 12:46:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 79DB293132;
	Fri,  9 Nov 2007 12:46:20 -0500 (EST)
In-Reply-To: <6C2C79E72C305246B504CBA17B5500C9029A36F1@mtlexch01.mtl.com>
	(Yossi Leybovich's message of "Fri, 9 Nov 2007 14:16:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64231>

"Yossi Leybovich" <sleybo@mellanox.co.il> writes:

> Just tried it :
>
> sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
> $ git-cat-file.exe -p 4b9458b3786228369c63936db65827de3cc06200
> error: corrupt loose object '4b9458b3786228369c63936db65827de3cc06200'
> fatal: Cannot read object 4b9458b3786228369c63936db65827de3cc06200
>
> Is this say something ?

Linus gave a good description of how to diagnose and assess the
extent of damage and potentially recover, so I won't repeat it,
but I am more interested in understanding how the object got
corrupted in the first place.

One thing the above says, with the .exe extension, is that you
are using it on some DOS derived platform.  Is this Cygwin?  Is
this WinGit?  Is this (infamous) "text mount"?
