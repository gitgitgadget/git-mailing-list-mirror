From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Deltification library work by Nicolas Pitre.
Date: Thu, 19 May 2005 08:36:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505190833380.2322@ppc970.osdl.org>
References: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191019180.20274@localhost.localdomain>
 <Pine.LNX.4.58.0505190736020.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu May 19 17:35:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYn2V-0006Zs-RT
	for gcvg-git@gmane.org; Thu, 19 May 2005 17:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVESPeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 11:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVESPeZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 11:34:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:45512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262501AbVESPeU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 11:34:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JFYFU3023941
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 19 May 2005 08:34:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JFYEg1026310
	for <git@vger.kernel.org>; Thu, 19 May 2005 08:34:15 -0700
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0505190736020.2322@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ This goes to the list because Davide can apparently receive the list 
   emails, but for some reason apparently doesn't like my osdl.org 
   address ]

Davide,

would you mind signing off on me adding the lines

  *  This file is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
  *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  Use of this within git automatically means that the LGPL
+ *  licensing gets turned into GPLv2 within this project. 
  */

(If you just send me an ack and your "signed-off-by" line, I'll edit 
Nico's patch appropriately, and check it in with all of our sign-offs).

That way there's no question about the dual-licensing.

		Linus
