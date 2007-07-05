From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 05 Jul 2007 09:46:11 -0700
Message-ID: <7vsl82dcj0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
	<81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 18:46:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6UTA-0002UT-Ef
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 18:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbXGEQqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbXGEQqN
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 12:46:13 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:40721 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbXGEQqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 12:46:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705164613.RXRJ11062.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Jul 2007 12:46:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KsmB1X00Z1kojtg0000000; Thu, 05 Jul 2007 12:46:12 -0400
In-Reply-To: <81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
	(Alex Riesen's message of "Thu, 5 Jul 2007 15:10:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51684>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 7/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>> We have a working implementation of rerere since long ago, and we even
>> make sure that it works as expected in a test case.  It is also a very
>> useful feature, so why not turn it on for the benefit of users who are
>> not even aware of it? This patch does that.
>
> Maybe just create in template directory?

Sounds saner.
