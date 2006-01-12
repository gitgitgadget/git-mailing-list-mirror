From: Greg KH <greg@kroah.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Wed, 11 Jan 2006 17:37:06 -0800
Message-ID: <20060112013706.GA3339@kroah.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de> <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 17:02:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex4sV-0004rp-MO
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 17:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWALQAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 11:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWALQAg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 11:00:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:52945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030451AbWALQAd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 11:00:33 -0500
Received: from [192.168.0.25] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k0CFx2L02762;
	Thu, 12 Jan 2006 07:59:02 -0800
Received: from greg by press.kroah.org with local (masqmail 0.2.20) id
 1EwrOk-0rw-00; Wed, 11 Jan 2006 17:37:06 -0800
To: Adrian Bunk <bunk@stusta.de>
Content-Disposition: inline
In-Reply-To: <20060110201909.GB3911@stusta.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14567>

On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
> 
> I am using the workaround of carrying the patches in a mail folder, 
> applying them in a batch, and not pulling from your tree between 
> applying a batch of patches and you pulling from my tree.

Ick, I'd strongly recommend using quilt for this.  It works great for
just this kind of workflow.

thanks,

greg k-h
