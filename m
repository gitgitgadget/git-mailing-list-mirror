From: Sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] separate .git from working directory
Date: Wed, 11 Oct 2006 18:48:44 -0400
Message-ID: <BAYC1-PASMTP04304774C74D3847D50C60AE140@CEZ.ICE>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
	<81b0412b0610110741q698e6512xc8a4188bac0294a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 00:49:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXmsd-0008V4-5r
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 00:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWJKWsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 18:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWJKWsr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 18:48:47 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:25798 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S965228AbWJKWsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 18:48:46 -0400
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.42.136]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 11 Oct 2006 15:48:46 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GXmsW-0004Ee-NM; Wed, 11 Oct 2006 18:48:44 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
Message-Id: <20061011184844.40b1205d.seanlkml@sympatico.ca>
In-Reply-To: <81b0412b0610110741q698e6512xc8a4188bac0294a4@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 11 Oct 2006 22:48:46.0461 (UTC) FILETIME=[68FFF2D0:01C6ED87]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 Oct 2006 16:41:03 +0200
"Alex Riesen" <raa.lkml@gmail.com> wrote:

> You can even leave the name as is: it is impossible to misunderstand
> a file for directory (except on AIX). Or put the information in extended
> attributes.

Actually, if you just make .git a symlink to the real $GIT_DIR find won't
recurse into it.

Sean
