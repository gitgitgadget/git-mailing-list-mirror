From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Sun, 9 Nov 2008 22:12:14 +1100
Message-ID: <18710.50575.738.7798@cargo.ozlabs.ibm.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-2-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-3-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-4-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-5-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-6-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-7-git-send-email-angavrilov@gmail.com>
	<18708.11537.229423.296701@cargo.ozlabs.ibm.com>
	<81b0412b0811070639q47244bc4t10791781fb0ec43b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 12:13:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kz8Eb-0007Ne-CZ
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 12:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbYKILMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754415AbYKILMW
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 06:12:22 -0500
Received: from ozlabs.org ([203.10.76.45]:51530 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbYKILMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 06:12:21 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 42845DDE00; Sun,  9 Nov 2008 22:12:20 +1100 (EST)
In-Reply-To: <81b0412b0811070639q47244bc4t10791781fb0ec43b@mail.gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100439>

Alex Riesen writes:

> > Is there any reason to call tk::PlaceWindow under Linux or MacOS?
> > If not I'd rather add an if statement so we only call it on Windows.
> >
> 
> Yes, please. I rather like the smart placement in compiz.

Do you mean "please add the if statement", i.e. don't call
tk::PlaceWindow under Linux?  Like Johannes Sixt, I find your request
ambiguous. :)

Paul.
