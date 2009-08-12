From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor
	for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Wed, 12 Aug 2009 07:20:49 -0700
Message-ID: <20090812142049.GA1033@spearce.org>
References: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com> <20090810155207.GW1033@spearce.org> <E861EAC5-150C-4CF8-AD0F-EBF15CEAE114@gmail.com> <20090810205907.GY1033@spearce.org> <8ACC6C83-75FD-477C-9083-96CA426FC069@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "robin.rosenberg@dewire.com" <robin.rosenberg@dewire.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 16:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbEhG-0003W3-FY
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 16:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZHLOUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 10:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbZHLOUs
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 10:20:48 -0400
Received: from george.spearce.org ([209.20.77.23]:33104 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZHLOUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 10:20:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4D013381FD; Wed, 12 Aug 2009 14:20:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8ACC6C83-75FD-477C-9083-96CA426FC069@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125699>

Alex Blewitt <alex.blewitt@gmail.com> wrote:
> On 10 Aug 2009, at 21:59, "Shawn O." <spearce@spearce.org> wrote:
>>
>>>> ./org/spearce/jgit/revwalk/RevTag.java:206: getName() in
>>>> org.spearce.jgit.revwalk.RevTag cannot override getName() in
>>>> org.spearce.jgit.lib.AnyObjectId; overridden method is final
>>
>> I can't apply this patch because getName() on RevTag is already
>> defined with a different meaning.  :-(
>
> That sounds dangerous. We now have a .name() and a .getName() with  
> different semantics. Can we not change the RevTag method name to  
> something else so that we dont have an inconsistency?

Good point.  We didn't think that RevTag.getName method through
very well.  Rename it to getTagName() ?

-- 
Shawn.
