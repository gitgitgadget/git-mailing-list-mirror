From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 10:09:41 -0800
Message-ID: <7vprw1r6ai.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
	<ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com>
	<alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com>
	<alpine.LSU.1.00.0801161341430.17650@racer.site>
	<alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com>
	<D3716EB3-10B1-4D96-AB12-BD86CBB189CB@wincent.com>
	<alpine.DEB.1.00.0801161643480.5260@bender.nucleusys.com>
	<7vwsq9r6mf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCiV-0003Gm-20
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYAPSJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYAPSJy
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:09:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYAPSJx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 13:09:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5294E4BA2;
	Wed, 16 Jan 2008 13:09:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 961024BA1;
	Wed, 16 Jan 2008 13:09:43 -0500 (EST)
In-Reply-To: <7vwsq9r6mf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 16 Jan 2008 10:02:32 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70712>

Junio C Hamano <gitster@pobox.com> writes:

> Petko Manolov <petkan@nucleusys.com> writes:
>
>> On Wed, 16 Jan 2008, Wincent Colaiuta wrote:
>>
>>> If the exact contents of these large binaries *really* don't matter,
>>> as you say they don't, than why don't you just commit one and never
>>> touch it again?
>>
>> Unfortunately those binaries does change, although the process is slow
>> and not very frequent.  And this is why it pokes me in the eye - for
>> changing a few bytes i end up with much larger repository.
>
> For changing a few bytes you get with much larger repository?
> What happened to our packfiles?
>
> Is it possible for us to take a look at two versions of such a
> binary blob, one before the change and one after such a change
> that touches only a few bytes?

I replied before reading the rest of the thread.  Please ignore
me on this one.
