From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Git over cvs
Date: Tue, 24 Nov 2009 18:07:22 +0100
Message-ID: <4B0C12CA.4060203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 18:08:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCysX-0006aE-15
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 18:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933624AbZKXRIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 12:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933561AbZKXRIZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 12:08:25 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:45821 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932859AbZKXRIY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 12:08:24 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A1748C1EA1
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 12:08:30 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 24 Nov 2009 12:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=3XJwv8zQSuWN9O5s0Y1jAeO0bMk=; b=sWowFVgfaJGqkreANrdrStC8ydSz4G/hqaWXPlclQ9yuf5EtOmab6h2ow4AQlhmu1xdkE0vq8M76bT4TG0amJzCYdqg3tYguURrXk83ZgSi3ICoAw2uYrXKYhlQ9Lbsojp2OsUTE6UjFwyXwTe57JI2/bb300xDA3sR7sL8UnYM=
X-Sasl-enc: YWUTCVsDRghXqnpkmZxqkMKflPpyjO/itderg+wN6nIc 1259082507
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 17A6CCEAE
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 12:08:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091121 Lightning/1.0pre Shredder/3.0.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133582>

Hi there,

I got so annoyed by (my own incompetence using) cvs on mozdev that I got
myself to use git cvsimport/cvsexportcommit now, just shortly before it
gets obsoleted by the new shiny remote helpers, and knowing how many
failing tests we have for it now.

Setting up a convenient roundtrip with minimal exposure to cvs required
collecting some scattered info. I thought this makes a good first blog
entry (the one after the zeroth) for reference, so in case anyone is
interested:

http://grubix.blogspot.com/2009/11/git-over-cvs.html

I guess it does require some acquaintance with Git, that's intentional.
(In short it uses the combined work tree, -W approach.)

Cheers,
Michael

P.S.: There's AdSense on there. I assume you block it anyway using
NoScript, AdBlock etc.  if you don't like it.
