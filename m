From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gitk and --no-walk don't play together
Date: Mon, 08 Sep 2008 12:19:39 -0700
Message-ID: <7viqt6fnsk.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0809081223360.1621@fbirervta.pbzchgretzou.qr>
 <adf1fd3d0809080934s67b2a8b1w19aeb3d8e5f8b4ab@mail.gmail.com>
 <alpine.LNX.1.10.0809081310260.1621@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi Bejar <santi@agolina.net>, git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 21:21:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcmIF-0008Oc-Qs
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 21:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYIHTTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYIHTTx
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 15:19:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbYIHTTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 15:19:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 737815FF8D;
	Mon,  8 Sep 2008 15:19:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1983D5FF89; Mon,  8 Sep 2008 15:19:46 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0809081310260.1621@fbirervta.pbzchgretzou.qr>
 (Jan Engelhardt's message of "Mon, 8 Sep 2008 13:25:12 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C26AA94-7DDB-11DD-9FD6-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95294>

Jan Engelhardt <jengelh@medozas.de> writes:

> On Monday 2008-09-08 12:34, Santi Bejar wrote:
>>
>>> in an attempt to only show only the tags in the graph, gitk barfs:
>>
>>Use the "List references" in the file menu.
>
> Nope, the intention was to have gitk display something like
>
> * Linux 2.6.26
> |
> * Linux 2.6.25
>
> without any intermediate commits.

Aren't you being unreasonable?  How would gitk know to draw the line
between .25 and .26 without walking the history?
