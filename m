From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Fri, 15 Jan 2010 01:08:09 +0200
Message-ID: <20100114230809.GA15928@Knoppix>
References: <20100113191802.GA8110@Knoppix>
 <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com>
 <20100113200629.GA8383@Knoppix>
 <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com>
 <20100113210414.GA8535@Knoppix>
 <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com>
 <20100113230023.GA9171@Knoppix>
 <32541b131001131551m38ff02acpdd08d9f0562ac84d@mail.gmail.com>
 <20100114085124.GA10298@Knoppix>
 <32541b131001141246o1f5ce816gc4a26b81343aaa2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:08:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVYnu-0007pM-1w
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab0ANXIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503Ab0ANXIU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:08:20 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:34815 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab0ANXIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:08:16 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 61F918BD52;
	Fri, 15 Jan 2010 01:08:14 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A049935E276; Fri, 15 Jan 2010 01:08:14 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 482C5E51A5;
	Fri, 15 Jan 2010 01:08:10 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <32541b131001141246o1f5ce816gc4a26b81343aaa2d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137034>

On Thu, Jan 14, 2010 at 03:46:56PM -0500, Avery Pennarun wrote:
> On Thu, Jan 14, 2010 at 3:51 AM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:

> > The client tries only one auth method instead of potentially trying
> > multiple. Witness the 'use verbose mode and check if it uses the key'
> > type stuff.
> 
> I believe this is a limitation of the client, not of the protocol.  So
> a patch to the ssh client could fix this.

This is also about interfaces to user. It effectively can't be patched.

<forking OpenSSH>

Get real.

> > And if you host the repo system too, you would get second key anyway
> > (and SSH is not too good at handling multiple keys).
> 
> I'm not really sure about this.  ssh-add seems pretty easy.
 
Anyway, two SSH keys in interactive use means which to use has to be selected,
one doesn't.

-Ilari
