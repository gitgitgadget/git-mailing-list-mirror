From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 20:48:48 -0800 (PST)
Message-ID: <20071205.204848.227521641.davem@davemloft.net>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	<20071205.202047.58135920.davem@davemloft.net>
	<4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: dberlin@dberlin.org
X-From: git-owner@vger.kernel.org Thu Dec 06 05:49:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08fe-0000MI-2v
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbXLFEst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 23:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbXLFEst
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:48:49 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47820
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752242AbXLFEst (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 23:48:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 56C8FC8C15C;
	Wed,  5 Dec 2007 20:48:48 -0800 (PST)
In-Reply-To: <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67234>

From: "Daniel Berlin" <dberlin@dberlin.org>
Date: Wed, 5 Dec 2007 23:32:52 -0500

> On 12/5/07, David Miller <davem@davemloft.net> wrote:
> > From: "Daniel Berlin" <dberlin@dberlin.org>
> > Date: Wed, 5 Dec 2007 22:47:01 -0500
> >
> > > The size is clearly not just svn data, it's in the git pack itself.
> >
> > And other users have shown much smaller metadata from a GIT import,
> > and yes those are including all of the repository history and branches
> > not just the trunk.
> I followed the instructions in the tutorials.
> I followed the instructions given to by people who created these.
> I came up with a 1.5 gig pack file.
> You want to help, or you want to argue with me.

Several people replied in this thread showing what options can lead to
smaller pack files.

They also listed what the GIT limitations are that would effect the
kind of work you are doing, which seemed to mostly deal with the high
space cost of branching and tags when converting to/from SVN repos.
