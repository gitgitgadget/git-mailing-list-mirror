From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: How git affects kernel.org performance
Date: Fri, 12 Jan 2007 21:54:43 +1100
Message-ID: <1168599283.2744.5.camel@nigel.suspend2.net>
References: <45A083F2.5000000@zytor.com>
	 <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
	 <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org>
	 <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org>
	 <368329554.17014@ustc.edu.cn>
	 <Pine.LNX.4.64.0701090821550.3661@woody.osdl.org>
	 <20070110015739.GA26978@mail.ustc.edu.cn>
	 <1168399249.2585.6.camel@nigel.suspend2.net>
	 <20070110140730.GA986@mail.ustc.edu.cn>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Fri Jan 12 11:55:06 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5K3q-0000oV-Q9
	for gcfe-linux-ext4@gmane.org; Fri, 12 Jan 2007 11:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbXALKy6 (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Fri, 12 Jan 2007 05:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbXALKyr
	(ORCPT <rfc822;linux-ext4-outgoing>);
	Fri, 12 Jan 2007 05:54:47 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:37849 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161037AbXALKyp (ORCPT
	<rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jan 2007 05:54:45 -0500
Received: from [127.0.0.1] (nigel.suspend2.net [127.0.0.1])
	by nigel.suspend2.net (Postfix) with ESMTP id 569EDE8D42;
	Fri, 12 Jan 2007 21:54:43 +1100 (EST)
To: Fengguang Wu <fengguang.wu@gmail.com>
In-Reply-To: <20070110140730.GA986@mail.ustc.edu.cn>
X-Mailer: Evolution 2.8.1 
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36667>

Hi.

On Wed, 2007-01-10 at 22:07 +0800, Fengguang Wu wrote:
> Thanks, Nigel.
> But I'm very sorry that the calculation in the patch was wrong.
> 
> Would you give this new patch a run?

Sorry for my slowness. I just did

time find /usr/src | wc -l

again:

Without patch: 35.137, 35.104, 35.351 seconds
With patch: 34.518, 34.376, 34.489 seconds

So there's about .8 seconds saved.

Regards,

Nigel
