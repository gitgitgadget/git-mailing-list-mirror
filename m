From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] --color-words: Make non-word characters
 configurable
Date: Sat, 03 May 2008 23:45:14 -0700
Message-ID: <7vk5iar2it.fsf@gitster.siamese.dyndns.org>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 08:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsXzK-0000rk-Ua
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 08:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbYEDGp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 02:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbYEDGp2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 02:45:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbYEDGp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 02:45:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2453D32F6;
	Sun,  4 May 2008 02:45:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4288132F5; Sun,  4 May 2008 02:45:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AC431508-19A5-11DD-B749-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81148>

Ping Yin <pkufranky@gmail.com> writes:

> A more sensible implementation is to use 'insert' instead of 'replace'.
> Say, to insert a line break between runs of word characters and non-word
> characters or between non-word characters.
>
> That is, "foo>=bar" will be rewritten as "foo\n>\n=\nbar" instead of
> "foo\n\nbar".

Hmmmm.

I am not sure if/why you would want a separator between '>' and '=' in
that example.  Shouldn't that be "foo <sep> >= <sep> bar"?
