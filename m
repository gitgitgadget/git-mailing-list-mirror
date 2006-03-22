From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning from sites with 404 overridden
Date: Tue, 21 Mar 2006 20:13:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603212011430.26286@g5.osdl.org>
References: <20060322025921.1722.qmail@science.horizon.com>
 <20060322031200.GB17954@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 05:13:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLuix-0005er-NN
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 05:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWCVEN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 23:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWCVEN3
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 23:13:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750740AbWCVEN2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Mar 2006 23:13:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2M4DMDZ013902
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Mar 2006 20:13:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2M4DLvo015566;
	Tue, 21 Mar 2006 20:13:21 -0800
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060322031200.GB17954@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17802>



On Tue, 21 Mar 2006, Shawn Pearce wrote:
>
> '0' x 40.  :-) There's some places already in the GIT source
> which would have ``issues'' if they got an object with this hash.
> Not sure if it is actually an entirely impossible hash or just one
> that is highly improbable.

The all-zeroes hash is as improbable as any other one, and finding a 
"collision" (ie a "real object") with that hash is as improbable as any 
other collision, ie we can (and do) depend on it beign a unique identifier 
for "does not exist".

			Linus
