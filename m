From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 7 Feb 2011 14:18:55 +0200
Message-ID: <20110207121855.GA7298@LK-Perkele-VI.localdomain>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <20110207091740.GA5391@elie>
 <20110207095713.GA19653@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 13:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmQ4k-0006GP-F9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 13:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab1BGMUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 07:20:07 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:44562 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab1BGMUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 07:20:06 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id E1035C7F34;
	Mon,  7 Feb 2011 14:20:04 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0681FDD68C; Mon, 07 Feb 2011 14:20:04 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 2C5E14047;
	Mon,  7 Feb 2011 14:19:57 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20110207095713.GA19653@do>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166258>

On Mon, Feb 07, 2011 at 04:57:13PM +0700, Nguyen Thai Ngoc Duy wrote:
> 
> Perhaps it's not a good approach after all. What I wanted was to make
> pre-1.8.0 tolerate empty trees created by 1.8.0. Perhaps it's better
> to just let pre-1.8.0 refuse to work with empty trees, forcing users
> to upgrade to 1.8.0?
> 
> The (untested) patch below would make git refuse to create an index
> from a tree that contains empty trees. Hmm?
 
Remember, many distros ship with old versions of Git. Debian stable
is now at 1.7.2.3 (Squeeze became Debian 6.0) and it'll take years
before next release. What about these?

Making previous versions refuse to work with empty trees isn't exactly
trivial, as the tree parser seems to be written to be extremely
liberal on what it accepts.

-Ilari
