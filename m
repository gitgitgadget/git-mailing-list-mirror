From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault in http-push
Date: Sun, 17 Feb 2008 19:06:39 -0800
Message-ID: <7v7ih3vu80.fsf@gitster.siamese.dyndns.org>
References: <20080217220013.GA12419@hash.localnet>
 <alpine.LSU.1.00.0802172321551.30505@racer.site>
 <20080218020555.GA12814@hash.localnet>
 <alpine.LSU.1.00.0802180207360.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bob Copeland <me@bobcopeland.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:07:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQwLi-0002Fl-SI
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 04:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbYBRDGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 22:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYBRDGs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 22:06:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYBRDGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 22:06:47 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 65DC05CD4;
	Sun, 17 Feb 2008 22:06:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 9E8555CD2; Sun, 17 Feb 2008 22:06:41 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802180207360.30505@racer.site> (Johannes
 Schindelin's message of "Mon, 18 Feb 2008 02:08:09 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74221>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 17 Feb 2008, Bob Copeland wrote:
>
>> On Sun, Feb 17, 2008 at 11:23:38PM +0000, Johannes Schindelin wrote:
>> 
>> > Alas, a fix I provided for exactly this case did not make it into 
>> > master yet, let alone into any released version.  Can you please test 
>> > the current "next"?
>> 
>> Yep, next fixes it for me, thanks!
>
> Thanks for testing!
>
> Ciao,
> Dscho "who is pleased that we fix some bugs before they are reported"

Wonderful.

I take this as a go ahead to merge js/maint-http-push topic to 'maint'
before we cut 1.5.4.3.

Thanks both of you, especially Dscho.
