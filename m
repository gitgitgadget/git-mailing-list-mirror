From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Fri, 13 Mar 2009 18:06:11 +0100
Message-ID: <49BA9283.9090607@drmicha.warpmail.net>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>	 <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>	 <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>	 <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>	 <49B7E670.7060606@drmicha.warpmail.net> <gp95vf$gp1$1@ger.gmane.org>	 <49B8EF3E.2070208@drmicha.warpmail.net>	 <20090312170931.GB19175@inocybe.teonanacatl.org>	 <49BA356D.8050007@drmicha.warpmail.net> <76718490903130918r733e3ef4meae49311883969b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Todd Zullinger <tmz@pobox.com>,
	Alejandro Riveira <ariveira@gmail.com>, git@vger.kernel.org,
	Tom Holaday <tlholaday@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiAsa-0004Ju-Ft
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 18:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760945AbZCMRG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760939AbZCMRG0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 13:06:26 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40109 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760933AbZCMRGZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 13:06:25 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A58C92EF620;
	Fri, 13 Mar 2009 13:06:23 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 13 Mar 2009 13:06:23 -0400
X-Sasl-enc: S3lSYXbtZMcjnZ8HYjWCCZ+ZWqLsLxF/NvyK16m1HUbx 1236963983
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BDA6034D9D;
	Fri, 13 Mar 2009 13:06:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090313 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <76718490903130918r733e3ef4meae49311883969b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113209>

Jay Soffian venit, vidit, dixit 13.03.2009 17:18:
> On Fri, Mar 13, 2009 at 6:29 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> On a related issue: Does anybody know which asciidoc versions need
>> asciidoc7compatible to be set? 8.2.5 and above certainly don't, so we
>> should not advise using it. asciidoc's hg repo doesn't go back much more
>> (the initial revision does not need it either), and I haven't dug for
>> their earlier history yet.
> 
> I'm using 8.3.1 and set asciidoc7compatible. I don't recall why I set
> it, but I'm sure I had a good reason for it. :-)

And you don't have any issues with _emphasis_? E.g. in git help
filter-branch, "positive" in the second paragraph should be emphasized,
possibly underlined.

OK, I just checked myself. At least 8.2.7 still had problems, but 8.3.0
is fine, even 8.4.1 is. asciidoc needs to be convinced forcibly to look
for its config in its own location (rather than /etc), which is what
tripped off my first tests...

So, asciidoc version 8.3.0 and above is fine with asciidoc7compatible
(at least regarding emphasis), 8.2.4~23 through 8.2.7 is not. Below
their hg history ends.

Oh well, the doc tool chain. Dig into it and feel chained to a stool, in
need to see a doc. Lame pun, time to go home :|

Michael
