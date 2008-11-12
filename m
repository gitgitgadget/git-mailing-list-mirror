From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Wed, 12 Nov 2008 12:47:27 -0800
Message-ID: <7vy6zon02o.fsf@gitster.siamese.dyndns.org>
References: <1226028387-23867-1-git-send-email-tuncer.ayaz@gmail.com>
 <4ac8254d0811101543q612917b5ib83e7e657d17ef3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0MeE-0005DF-OK
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 21:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYKLUrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 15:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbYKLUrz
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 15:47:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbYKLUrz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 15:47:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EC24B16895;
	Wed, 12 Nov 2008 15:47:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 11AAD1688A; Wed, 12 Nov 2008 15:47:33 -0500 (EST)
In-Reply-To: <4ac8254d0811101543q612917b5ib83e7e657d17ef3c@mail.gmail.com>
 (Tuncer Ayaz's message of "Tue, 11 Nov 2008 00:43:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A09BB4E-B0FB-11DD-8456-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100814>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> On Fri, Nov 7, 2008 at 4:26 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> Implement git-pull --quiet and git-pull --verbose by
>> adding the options to git-pull and fixing verbosity
>> handling in git-fetch.
>
> Junio,
>
> is there anything still missing in this patch?
> Maybe the name of the test-case is bad.

It seems to break t7600.
