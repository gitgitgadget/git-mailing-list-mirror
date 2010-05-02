From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFD PATCH] revlist/rev-parse: Introduce --heads and --locals
 revision specifiers
Date: Sun, 02 May 2010 15:43:05 +0200
Message-ID: <4BDD8169.9050301@drmicha.warpmail.net>
References: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net> <20100502050054.GE14776@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 02 15:43:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ZS1-0005VH-8E
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 15:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab0EBNnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 09:43:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50131 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754960Ab0EBNnK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 09:43:10 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4CBF5F2391;
	Sun,  2 May 2010 09:43:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 02 May 2010 09:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=2geJ/yLxo1ghV91kSK4jvHR/GHM=; b=UHhiQguFKrN08pq11rwEHNRchWWODiskE/8qeO7XNyFBpB8UlGMQYaJdTkZ9u9Io4Zfw4Oe70cUUHonE1udKng0y1nis4MmsYQHlWRqUd4haxuDbDTmBZkFfZ+x7sPkrtMjPbrfFV2xD5xQ1a8NLbBTV+SlMX3xd9Q0lCX/PkJw=
X-Sasl-enc: G6tpqDItiw1RzVK91aFvOj3PO+h8oE3/nutQVCbc/pOw 1272807785
Received: from localhost.localdomain (p5DCC03EE.dip0.t-ipconnect.de [93.204.3.238])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 215904D2E42;
	Sun,  2 May 2010 09:43:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100502050054.GE14776@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146176>

Jeff King venit, vidit, dixit 02.05.2010 07:00:
> On Sat, May 01, 2010 at 08:36:33PM +0200, Michael J Gruber wrote:
> 
>> Due to the increasing usage of the ref namespace (e.g. notes, replace)
>> the revision specifier "--all" becomes decreasingly useful. But
>> "something like --all" is ineeded for getting a quick overview of
>> the development state of a repository.
>>
>> Introduce --heads and --locals specifiers in order to help with that:
>>
>> --heads == HEAD --branches --remotes
>> --locals = HEAD --branches --tags
> 
> I don't have anything against the concept, but "--heads" is a horrible
> name, as it implies refs/heads (which is of course what --branches does.
> Yikes!). I know why you picked it, and once you think about it, yes, it

I second your Yikes... but won't suggest renaming refs/heads.

> does make some sense (it is all the local and remote heads), but I am
> worried that it will cause confusion.

So, your alternative suggestion is...? ;)

How about --tips? But I don't like that. We really use head as the term
for the tip (ordered end-vertex) of a branch, be it local or remote. I
would hope that ordinary users do not have to deal with the layout under
refs, and thus won't be confused. But people peel and poke everywhere
where there not supposed to :)

Michael
