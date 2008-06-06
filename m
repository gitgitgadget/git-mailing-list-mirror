From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 06 Jun 2008 16:11:13 -0700
Message-ID: <7v4p86rwfi.fsf@gitster.siamese.dyndns.org>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
 <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
 <alpine.DEB.1.00.0806061911300.1783@racer>
 <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil> <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com> <alpine.DEB.1.00.0806070006150.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cedric Vivier <cedricv@neonux.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:12:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4l6b-0007Ir-5Z
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985AbYFFXLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756951AbYFFXLY
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:11:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701AbYFFXLX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:11:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E8E73A27;
	Fri,  6 Jun 2008 19:11:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B81883A26; Fri,  6 Jun 2008 19:11:16 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806070006150.1783@racer> (Johannes
 Schindelin's message of "Sat, 7 Jun 2008 00:06:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E111B87E-341D-11DD-96CC-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84135>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 6 Jun 2008, Cedric Vivier wrote:
>
>> On Fri, Jun 6, 2008 at 11:04 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> > But can't that be just as easily done by piping through sort? (I 
>> > understand there is a platform which lacks the sort utility, boohoo)
>> 
>> Yes, but sort does not have a natural sort option afaik.
>
> sort -n

That's Numeric sort, isn't it?

I sometimes dreamed of having "sort --random" for testing purposes ;-)
