From: Joe Perches <joe@perches.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 08 Aug 2011 18:41:43 -0700
Message-ID: <1312854103.1643.34.camel@Joe-Laptop>
References: <4E3EF38A.9010307@gmail.com>
	 <20110808211726.GA18619@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Daniel Mack <zonque@gmail.com>, git@vger.kernel.org,
	Greg Kroah-Hartman <greg@kroah.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 03:44:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqbMi-0003Qo-VK
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 03:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032Ab1HIBlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 21:41:45 -0400
Received: from wondertoys-mx.wondertoys.net ([206.117.179.246]:55772 "EHLO
	labridge.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750984Ab1HIBlp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 21:41:45 -0400
Received: from [173.60.85.8] (account joe@perches.com HELO [192.168.1.152])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 17987468; Mon, 08 Aug 2011 18:41:44 -0700
In-Reply-To: <20110808211726.GA18619@elie.gateway.2wire.net>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179016>

On Mon, 2011-08-08 at 23:17 +0200, Jonathan Nieder wrote:
> (+cc: some send-email people)
> Daniel Mack wrote:
> > I'm looking for a way to suppress certain Cc: fields that are normally
> > automatically added for addresses mentioned in Cc: lines found in patches.
> Makes sense.  Could you please add a quick commit message, following
> the guidelines in Documentation/SubmittingPatches (i.e., explaining
> the problem this intends to solve and justifying how it is solved)?

It seems an odd use case to me.
Why are these added addresses undesired?

Also this does not work for cccmd addresses.
You'll need to add similar logic to recipient_cmd
uses.

cheers, Joe
