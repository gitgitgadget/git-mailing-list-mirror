From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 20:40:50 +0100
Message-ID: <20100113194050.GA11688@inner.home.ulmdo.de>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi> <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com> <20100113135753.GA7095@Knoppix> <20100113141218.GA17687@inner.home.ulmdo.de> <20100113144745.GA7246@Knoppix> <20100113161711.GB17687@inner.home.ulmdo.de> <20100113173610.GA7609@Knoppix> <20100113183520.GA23674@inner.home.ulmdo.de> <20100113191802.GA8110@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:41:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV95Q-0007fv-UM
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab0AMTk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912Ab0AMTk5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:40:57 -0500
Received: from continuum.iocl.org ([213.146.114.200]:62097 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab0AMTk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:40:56 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0DJeop13948;
	Wed, 13 Jan 2010 20:40:50 +0100
Content-Disposition: inline
In-Reply-To: <20100113191802.GA8110@Knoppix>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136862>

On Wed, 13 Jan 2010 21:18:02 +0000, Ilari Liusvaara wrote:
...
> That feature is grossly underdocumented (and also nonportable). Unix(7)
> should document it, except that it doesn't for me (it documents that
> SO_PASSCRED takes a boolean, except that what the server implementation
> passes is something completely different).

Actually, I meant how you plan to map credentials (however obtained)
into allowed actions inside git-daemon (or the hooks).

...
> And how many (relative) use client ceritificates with SSL? Keypairs with SSH?
> Why you think this is?

Because ssh is much more popular than ssl client auth. Obtaining client
certificates isn't much more complicated than getting an ssh account,
once you have scripts for the stuff ready.

But I wonder: When you want keypair auth, why not just use ssh?
I didn't quite understand the use case yet, it seems. With ssh
I have all the infrastructure like ssh-agent in place already;
with gits: (any kind of) it will be asked for sooner or later.

Andreas
