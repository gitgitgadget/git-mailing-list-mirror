From: "Jonas Bang" <email@jonasbang.dk>
Subject: RE: Git feature request: Option to force Git to abort a checkout if working directory is dirty (i.e. disregarding the check for conflicts)
Date: Thu, 3 Apr 2014 20:42:45 +0200
Message-ID: <000601cf4f6c$81b72740$852575c0$@jonasbang.dk>
References: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk>	<xmqqk3bfedqi.fsf@gitster.dls.corp.google.com>	<002001cf4b44$fe3550c0$fa9ff240$@jonasbang.dk>	<xmqqha6e8f67.fsf@gitster.dls.corp.google.com>	<002a01cf4dd3$d88c8640$89a592c0$@jonasbang.dk> <xmqq7g77vcnk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:42:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVmbG-0002dq-TS
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 20:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbaDCSmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 14:42:50 -0400
Received: from mail5.surf-town.net ([212.97.132.45]:37072 "EHLO
	mailgw11.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753100AbaDCSmt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 14:42:49 -0400
Received: by mailgw11.surf-town.net (Postfix, from userid 65534)
	id AF849A3B02; Thu,  3 Apr 2014 20:42:47 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by mailgw11.surf-town.net (Postfix) with ESMTP id 8703DA3B0C;
	Thu,  3 Apr 2014 20:42:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw11.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw11.surf-town.net ([127.0.0.1])
	by localhost (mailgw11.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 668AWLbwuQ6V; Thu,  3 Apr 2014 20:42:45 +0200 (CEST)
Received: from Mainframe (unknown [5.103.38.58])
	(Authenticated sender: email@jonasbang.dk)
	by mailgw11.surf-town.net (Postfix) with ESMTPA id 2D0CEA3B02;
	Thu,  3 Apr 2014 20:42:43 +0200 (CEST)
In-Reply-To: <xmqq7g77vcnk.fsf@gitster.dls.corp.google.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQNHwG5eq+VqsEUk7jNiAAPbKL6k0gDp71pIAwWu0U4C0+NR5gGAbXqkAZ2CHreXwEuEIA==
Content-Language: da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245748>

> "Jonas Bang" <email@jonasbang.dk> writes:
> 
> >> >> ...  The default behaviour would cover their use case so your
> >> >> proposal would not hurt them, but I wonder if there are things you
> >> >> could do to help them as well, perhaps by allowing this new
> >> >> configuration to express something like "local changes in these
> >> >> paths are excempt from this new check".
> >> >
> >> > Yes, those people would probably use the default 'false' behavior
> >> > as it is already. If they however would like to use e.g. the 'true'
> >> > or 'include-untracked' setting as a configuration variable, then
> >> > they can use the command line option 'false' if they wish to do a
> >> > 'git checkout' even with modified files in the working tree.
> >>
> >> So in short, you are saying that "The added code necessary to
> >> implement this feature will not help them in any way, it is just that
> >> we will make sure it does not hurt them".
> >
> > I didn't realize they needed help.
> 
> If so, then you could have just stated that way, instead of saying they
have
> an escape hatch ;-)
> 
> It is perfectly fine to answer to "I wonder if there are things you could
do?"
> with "No, I am not going to help them with this series; I only make sure I
do
> not hurt them."  and that is perfectly fine, as long as:
> 
>  - you do not directly hurt them with your series; and
> 
>  - you do not make it harder for those who are interested in helping
>    them to build on top of your work in the future.
> 
> > How and who to decide if this is a reasonable feature request to accept?
> 
> As this project primarily works on "scratch your own itch" basis, somebody
> who (1) thinks that the proposed feature is worth having in our system and
> (2) is interested in working on it will pick it up.
> 
> If nobody is interested, then usually nothing happens.

Thanks for your replies and your time.

I'll cross my fingers for someone other than me and my identified group of
users seeing the benefit of this feature request.

Br,
Jonas
