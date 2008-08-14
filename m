From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Adding a challenge-response authentication method to git://
Date: Thu, 14 Aug 2008 09:13:28 +0200
Message-ID: <20080814071328.GB9680@cuci.nl>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <20080813173757.GE12200@cuci.nl> <20080813180857.GH3782@spearce.org> <20080814001029.GA14939@cuci.nl> <20080814005723.GM3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 09:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTX2X-0002VI-Ss
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 09:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYHNHNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 03:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYHNHNa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 03:13:30 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38832 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbYHNHNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 03:13:30 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id E3B565465; Thu, 14 Aug 2008 09:13:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080814005723.GM3782@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92330>

Shawn O. Pearce wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> wrote:
>> I'm not trying to solve all management problems, I'm just trying to
>> offer a simple solution for the small-user-base-central-repository case
>> without a lot of code-bloat on the git side.
>> If it doesn't fit ones needs, use ssh or something else; but it does
>> have its merits for the simple centralised setups.

>- Add to git-daemon a new service command, "git-authenticate-user".
[...implementation suggestion omitted...]

Sounds like a plan.  I'll see if it is workable.
-- 
Sincerely,
           Stephen R. van den Berg.

"Hold still, while I inject you with SQL."
