From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] In the commit dialog, deal with Signed-off-by not
	on the last line (WAS: [PATCH JGIT] Deal with the signed-off in the
	commit text dialog)
Date: Wed, 11 Feb 2009 11:40:58 -0800
Message-ID: <20090211194058.GV30949@spearce.org>
References: <49917944.6030309@gmail.com> <200902110116.36172.robin.rosenberg.lists@dewire.com> <499304A2.1060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKyZ-0004je-4q
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZBKTlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbZBKTk7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:40:59 -0500
Received: from george.spearce.org ([209.20.77.23]:35129 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZBKTk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:40:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5E04038210; Wed, 11 Feb 2009 19:40:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <499304A2.1060908@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109515>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> 
> This patch should correct this assumption.

Maybe, but it can't be applied...
 
> +                    String neuSignOff = getSignedOff(neuCommitter);
> +                   
> commitText.setText(replaceSignOff(commitText.getText(), oldSignOff,
> neuSignOff));
> +                    oldCommitter = neuCommitter;

That's whitespace corruption.


-- 
Shawn.
