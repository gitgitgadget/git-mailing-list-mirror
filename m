From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Thu, 09 Jul 2009 10:42:22 +0200
Message-ID: <4A55AD6E.8080200@drmicha.warpmail.net>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu> <7vd48b6md8.fsf@alter.siamese.dyndns.org> <200907082242.51495.j6t@kdbg.org> <7vvdm26bbk.fsf@alter.siamese.dyndns.org> <20090709063735.GA22544@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:42:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpDO-00026M-JP
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129AbZGIImn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756893AbZGIImn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:42:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59633 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756683AbZGIIml (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:42:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7A1BF3B04D9;
	Thu,  9 Jul 2009 04:42:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 09 Jul 2009 04:42:40 -0400
X-Sasl-enc: bF+lQfQmcbuel61cu5yhru8fhqy3BjP5BucJnw6RDYtR 1247128960
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7877D4B45;
	Thu,  9 Jul 2009 04:42:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090709063735.GA22544@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122945>

Jeff King venit, vidit, dixit 09.07.2009 08:37:
> On Wed, Jul 08, 2009 at 03:48:15PM -0700, Junio C Hamano wrote:
> 
>>> However, if Fritz runs 'sudo /usr/local/bin/git clone ...', then the interim 
>>> PATH is "/usr/local/bin:/usr/local/libexec/git-core:/bin:/usr/bin" because 
>>> this time setup_path() finds a non-empty argv0_path, and the command works.
>>
>> Ahh, that is what I was missing.
>>
>> As I said elsewhere already, I personally do not think sudo is worth
>> supporting compared to the cost of this kind of pain resulting from its
>> misguided "safety" brokenness, but apparently it is widely used.  I think
>> what Peff suggests in this thread might be a reasonable workaround.
> 
> Yes, I find sudo's restrictions silly, considering that most people use
> it to allow arbitrary code execution, which is why I wrote this some
> time ago:
> 
>   http://peff.net/tinysu/
> 

:)

I think writing "tinysu" is really the best statement one can make about
"sudo"... although "sudoh" would have been the most appropriate name...

Your patch is welcome, of course, and also removes the somewhat
surprising special role played by "git-add".

Michael
