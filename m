From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Mon, 23 Feb 2009 17:35:06 -0800
Message-ID: <7vab8cpqgl.fsf@gitster.siamese.dyndns.org>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
 <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com>
 <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com>
 <20090223161657.GL22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Marius Storm-Olsen <git@storm-olsen.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmE0-0001nW-7T
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbZBXBfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbZBXBfP
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:35:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbZBXBfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:35:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A49CA2BCAE;
	Mon, 23 Feb 2009 20:35:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BB4852BCAB; Mon,
 23 Feb 2009 20:35:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 613B1040-0213-11DE-A335-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111192>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Marius Storm-Olsen <marius@trolltech.com> wrote:
>>
>> ^shrug^ at this point you and Junio can discuss what to do, as Junio  
>> already said
>>
>>   | "I do not understand the need for GIT_DIR! thing even
>>   |  less, but since we have that there already, I do not
>>   |  see a reason not to add this to the queue."
>>
>> And I have to agree with him. At this point, __git_ps1() is actually  
>> removing useful information from the prompt; at least it does for me.
>
> *sigh*
>
> OK.  I guess we include it then.
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Reverting GIT_DIR! ugliness is certainly a possibility.  As long as people
who chdir into there are the only ones who suffer from the ugliness I do
not particularly care that much, though ;-)

Will apply anyway.
