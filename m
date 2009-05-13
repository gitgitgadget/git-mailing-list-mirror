From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: add comments to reflog?
Date: Wed, 13 May 2009 14:08:08 +0200
Message-ID: <4A0AB828.5090205@drmicha.warpmail.net>
References: <20090513103554.GC31593@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed May 13 14:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4DGA-0004A7-8j
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 14:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318AbZEMMIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 08:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757943AbZEMMIS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 08:08:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42662 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757670AbZEMMIR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 08:08:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CE0C4345664;
	Wed, 13 May 2009 08:08:17 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 13 May 2009 08:08:17 -0400
X-Sasl-enc: dgUvYwfuRlpdA8A2crCNhXTRJk2BrJQw8Foy0DldxPER 1242216497
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 264E8186C1;
	Wed, 13 May 2009 08:08:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090513103554.GC31593@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119040>

Michael S. Tsirkin venit, vidit, dixit 13.05.2009 12:35:
> I noticed that I am often doing this
> 
> hack commit hack commit  hack commit ...
> 
> git tag  -s works -m "works on xyz, must rewrite abc"
> git reset --hard HEAD~1
> 
> hack ...
> 
> I only tag just in case I want to revisit the design.
> However, after I reset, I often forget how did
> I name the tag. It would be nice if reflog would
> show tag descriptions, which it does not seem to.
> 
> Comments?
> 
> 

I'm not sure about your exact requirements, but maybe

git log --tags --simplify-by-decoration

does something useful for you. Also remember gitk etc. which takes the
same arguments for commit selection (those of git-rev-list). I always
forget about the power of git-rev-list options when used with log and
gitk. Thanks for reminding me :)

Cheers,
Michael
