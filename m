From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use of tac in git-rebase--interactive
Date: Tue, 29 Apr 2008 17:25:37 -0700
Message-ID: <7vod7s429q.fsf@gitster.siamese.dyndns.org>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
 <200804270733.m3R7XW72012537@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 02:26:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr09h-0006Fi-UF
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 02:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbYD3AZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 20:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbYD3AZq
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 20:25:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380AbYD3AZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 20:25:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0ED093AFC;
	Tue, 29 Apr 2008 20:25:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5F80C3AFA; Tue, 29 Apr 2008 20:25:40 -0400 (EDT)
In-Reply-To: <200804270733.m3R7XW72012537@mi1.bluebottle.com>
 (nanako3@bluebottle.com's message of "Sun, 27 Apr 2008 16:33:25 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F89E808E-164B-11DD-BE8E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80773>

しらいしななこ  <nanako3@bluebottle.com> writes:

> Quoting Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> Commit d481bcc9: "Do rebase with preserve merges with advanced TODO
>> list" uses the command tac, apparently to reverse the TODO command
>> list.  (I don't use rebase -i much, if you can't tell.)
>
> That is very sloppy job on Junio's part.  He usually is very picky about shell portability, and I remember that he earlier rewrote somebody else's commit that originally used tac command.

Heh, sorry about sloppiness.  I've been swamped lately outside git...
