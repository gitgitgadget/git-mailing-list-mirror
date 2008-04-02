From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/3] add pre-auto-gc hook for git-gc --auto (try3)
Date: Wed, 2 Apr 2008 21:34:21 +0200
Message-ID: <cover.1207164676.git.vmiklos@frugalware.org>
References: <cover.1207049697.git.vmiklos@frugalware.org> <7vhceldv12.fsf@gitster.siamese.dyndns.org> <20080402011447.GO3264@genesis.frugalware.org> <7vwsngaoqg.fsf@gitster.siamese.dyndns.org> <20080402190240.GV3264@genesis.frugalware.org> <7vtzik848t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8ji-0000aI-Cx
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbYDBTeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbYDBTeX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:34:23 -0400
Received: from virgo.iok.hu ([193.202.89.103]:24890 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757882AbYDBTeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:34:23 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E94791B25AC;
	Wed,  2 Apr 2008 21:34:21 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A84C8446A7;
	Wed,  2 Apr 2008 21:31:10 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 580B31190A16; Wed,  2 Apr 2008 21:34:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78705>

On Wed, Apr 02, 2008 at 12:07:46PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > What is your opinion here?
> >
> > 1) Just don't add such an empty template for pre-auto-gc.

Ok, here it is. Ah and I forgot to mention in my previous mail that yes,
checking for '1' in /sys/class/power_supply/AC/online is right, just
checked.

Miklos Vajna (3):
  git-gc --auto: add pre-auto-gc hook
  Documentation/hooks: add pre-auto-gc hook
  contrib/hooks: add an example pre-auto-gc hook

 Documentation/hooks.txt           |    7 ++++++
 builtin-gc.c                      |   31 +++++++++++++++++++++++++++++
 contrib/hooks/pre-auto-gc-battery |   39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/pre-auto-gc-battery
