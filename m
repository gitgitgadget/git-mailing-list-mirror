From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: [Virtual PATCH] Add an option to wrap a patch in <pre> in   git-imap-send
 which ironically results in a cleaner patch from Thunderbird.
Date: Fri, 13 Feb 2009 07:50:38 -0600
Message-ID: <49957AAE.7070505@codeweavers.com>
References: <499446D0.90602@codeweavers.com> <7viqnfezo5.fsf@gitster.siamese.dyndns.org> <49955860.80504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ben Bucksch <ben.bucksch.news@beonex.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 14:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXyTo-0007h4-0Z
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 14:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZBMNv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 08:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbZBMNvz
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 08:51:55 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:42401 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434AbZBMNvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 08:51:52 -0500
Received: from localhost
	([127.0.0.1] helo=[10.0.0.16] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LXySM-0002hL-64; Fri, 13 Feb 2009 07:51:50 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <49955860.80504@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109749>

Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 13.02.2009 05:19:
>> I do not think of a reason, other than to trigger the workaround you
>> mentioned in the documentation part of the patch, why any sane user would
>> want to send a patch as HTML.  This configuration variable sounds more
>> like "imap.forceThunderbirdToSendNonFlowedTextByExploitingItsBug" than
>> "imap.html", in other words.

With Michael's proviso well in hand (it's a feature, not a bug), I
did want to say that I otherwise think this is a reasonable analysis.

In fact, calling the option imap.thunderbird-fixed-html is arguably a
better name.

Finally, I know it's my patch, but for the record, I won't be hurt if
it's round filed.  You can make a clean case that not taking
it in leaves pressure on the joint dev communities to find a better 
solution.

But the only better approach I can imagine is if Thunderbird were
to respect a 'format=fixed' injected in a message body.  However,
as I think about that, I believe a correct Thunderbird implementation
of that would require having a per message setting for format.
The Thunderbird team is very reluctant to expose any UI on
f=f (see https://bugzilla.mozilla.org/show_bug.cgi?id=86607),
so having a per message UI element certainly sounds like a dead
idea walking :-/.

Cheers,

Jeremy
