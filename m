From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 17:39:27 -0400
Message-ID: <49B82F8F.5050105@xiplink.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>	 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>	 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>	 <20090310230939.GB14083@sigio.peff.net>	 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>	 <20090311020409.GA31365@coredump.intra.peff.net>	 <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org> <76718490903102222n23e0e7fdlcee2888333a2b912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 22:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWAi-0005Mb-Ok
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 22:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZCKVjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 17:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbZCKVjd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 17:39:33 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:33630 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZCKVjc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 17:39:32 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id D22AA7B918A;
	Wed, 11 Mar 2009 17:39:29 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 83F837B9632;
	Wed, 11 Mar 2009 17:39:28 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <76718490903102222n23e0e7fdlcee2888333a2b912@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112978>

Jay Soffian wrote:
> 
> Actually, for me, I find sometimes I've forgotten to setup tracking,
> or I've setup tracking and don't want it. I just fire up an editor on
> .git/config, or use git config, but I would appreciate an easy way to
> add/remove tracking to a branch after the fact.

I second that -- that's the exact situation I ran into.

Editing .git/config is scary and obscurely documented for new users (who are more likely to forget to set up tracking).  Plus encapsulating this in some porcelain makes it a bit less error-prone.

		M.
