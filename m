From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 11:46:57 +0100
Message-ID: <49BA39A1.9090203@drmicha.warpmail.net>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:48:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4wS-0007P0-PP
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbZCMKrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 06:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbZCMKrL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:47:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51664 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754174AbZCMKrK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 06:47:10 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id AF0B02EED16;
	Fri, 13 Mar 2009 06:47:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 13 Mar 2009 06:47:08 -0400
X-Sasl-enc: IBPI0x6dRqDBzrMI+DCsdfdOg5D8Ywy5K0v6n1JeXjYh 1236941228
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0D902FF6A;
	Fri, 13 Mar 2009 06:47:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090313 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113166>

Sverre Rabbelier venit, vidit, dixit 12.03.2009 22:34:
> Heya,
> 
> On Thu, Mar 12, 2009 at 22:19, Matthias Nothhaft
> <matthias.nothhaft@googlemail.com> > What I need is a way to
> automatically modify each file
>>
>> a) before it is written in the repository
>> b) after it is read from the repository
> 
> Have a look at smudging, you might not need to touch the git source
> code at all ;).
> 

And people asked me not to be cryptic... even though the OP explicitely
asked for encryption, of course ;)

"git help attributes" may help: look for filter and set attributes and
config (filter.$name.{clean,smudge}) accordingly. smudge should probably
decrypt, clean should encrypt.

BTW: Why not use an encrypted file system? That way your work tree would
be encrypted also.

Cheers,
Michael
