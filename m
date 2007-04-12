From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-clone: Better handling of failed fetches of HEAD over HTTP
Date: Thu, 12 Apr 2007 13:38:30 +0200
Message-ID: <20070412113830.GA26445@diana.vm.bytemark.co.uk>
References: <11763699332101-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Apr 12 13:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbxdb-0004OA-FY
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 13:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbXDLLij convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Apr 2007 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbXDLLij
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 07:38:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4207 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161195AbXDLLii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 07:38:38 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HbxdG-0006uL-00; Thu, 12 Apr 2007 12:38:30 +0100
Content-Disposition: inline
In-Reply-To: <11763699332101-git-send-email-martin@catalyst.net.nz>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44337>

On 2007-04-12 21:25:33 +1200, Martin Langhoff wrote:

> +		die "Could not retrieve $1/HEAD nor $1/refs/heads/master ."

The "nor" should be just "or", I believe. Otherwise, this would have
to be

  Could retrieve neither foo nor bar.

which sounds a bit too formal. But a native English speaker should
probably verify that my advice is correct.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
