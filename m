X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 07 Dec 2006 10:03:01 +0100
Message-ID: <87zma06ptm.fsf@wine.dyndns.org>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 09:03:19 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Thu\, 7 Dec 2006 00\:42\:42 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33561>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsF9x-000523-Jd for gcvg-git@gmane.org; Thu, 07 Dec
 2006 10:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031868AbWLGJDL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 04:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031871AbWLGJDK
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 04:03:10 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:45658 "EHLO
 mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031868AbWLGJDH (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 04:03:07 -0500
Received: from adsl-84-227-138-209.adslplus.ch ([84.227.138.209]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GsF9k-0000OC-MD; Thu, 07
 Dec 2006 03:03:05 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 003574F672; Thu, 
 7 Dec 2006 10:03:01 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * js/shallow (Fri Nov 24 16:00:13 2006 +0100)
>> 
>>  Probably with a better documentation of its limitations and caveats, 
>>  this should be mergeable to 'master'.
>
> The more I see the missing reaction, the less sure I am this is a sensible 
> thing to do.

I'm not sure what reaction you expect, but this is something a lot of
our occasional Wine users are requesting. The Wine full history is
80Mb, and that's a big download if you just want to try a quick
patch. Now of course you won't see these users around here hacking on
shallow clone, most likely they just went and downloaded Wine from the
CVS mirror instead. But it's a shame to have to maintain a CVS mirror
just for that purpose...

-- 
Alexandre Julliard
