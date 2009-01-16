From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Fri, 16 Jan 2009 14:12:16 +0100
Message-ID: <adf1fd3d0901160512i2de8f473gd471cc1dcb72afa4@mail.gmail.com>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
	 <496EE559.3060901@viscovery.net>
	 <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
	 <200901151500.01876.trast@student.ethz.ch>
	 <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
	 <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:13:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNoWH-0006U1-FS
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761811AbZAPNMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 08:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761924AbZAPNMU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:12:20 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:44231 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760424AbZAPNMT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:12:19 -0500
Received: by bwz14 with SMTP id 14so4970717bwz.13
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 05:12:17 -0800 (PST)
Received: by 10.103.102.17 with SMTP id e17mr1177557mum.119.1232111536780; 
	Fri, 16 Jan 2009 05:12:16 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105953>

2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> When HEAD is detached, --all should list it, too, logically, as a
> detached HEAD is by definition a temporary, unnamed branch.
>
> It is especially necessary to list it when garbage collecting, as
> the detached HEAD would be trashed.
>
> Noticed by Thomas Rast.
>
> Note that this affects creating bundles with --all; I contend that it
> is a good change to add the HEAD, so that cloning from such a bundle
> will give you a current branch.  However, I had to fix t5701 as it
> assumed that --all does not imply HEAD.

>From the description I understand that it only affects when the HEAD
is detached, but in t5701 the HEAD is not detached so nothing should
be fixed.

For gc for sure it is a good thing, but I'm not convinced of the
others, as a detached HEAD is a very special thing (temporary and
unnamed branch).

Santi
