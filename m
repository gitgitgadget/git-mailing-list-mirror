From: David Kastrup <dak@gnu.org>
Subject: Re: metastore
Date: Sat, 15 Sep 2007 16:16:14 +0200
Message-ID: <85ejh0aua9.fsf@lola.goethe.zz>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYRc-00012P-Qo
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbXIOOQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbXIOOQV
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:16:21 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:57864 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbXIOOQU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 10:16:20 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id C6C312F2B7F;
	Sat, 15 Sep 2007 16:16:19 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id B59A02DA967;
	Sat, 15 Sep 2007 16:16:19 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-048-000.pools.arcor-ip.net [84.61.48.0])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 6C17522D163;
	Sat, 15 Sep 2007 16:16:15 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 168DE1C0024C; Sat, 15 Sep 2007 16:16:14 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709151507310.28586@racer.site> (Johannes Schindelin's message of "Sat\, 15 Sep 2007 15\:10\:01 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4279/Sat Sep 15 14:53:34 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58248>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 15 Sep 2007, martin f krafft wrote:
>
>> The problem with metdata getting corrupted, which Nicolas reported,
>> may well have to do with the use of a single file.
>
> Then the tool is corrupt.  Introducing a shadow hierarchy, as you
> propose, is very inefficient.
>
>> Anyway, this *really* should go into git itself!
>
> No.  Git is a source code management system.  Everything else that
> you can do with it is a bonus, a second class citizen.  Should we
> really try to support your use case, we will invariably affect the
> primary use case.

That's what bad design is all about, after all.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
