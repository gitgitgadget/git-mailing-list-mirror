From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 13:04:26 -0700
Message-ID: <7vwrx1fpv9.fsf@alter.siamese.dyndns.org>
References: <20100323232055.GV7038@pixar.com>
 <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
 <4BA9DCDD.6060109@viscovery.net>
 <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
 <20100324134048.GB10190@pixar.com>
 <81b0412b1003240659u4e6de405t7750b66ca9292cdc@mail.gmail.com>
 <7vpr2tu1bd.fsf@alter.siamese.dyndns.org>
 <81b0412b1003241207s4951b32cpbe105e7b3623f61a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Damerow <lars@pixar.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuWol-0007V5-CP
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab0CXUEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 16:04:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab0CXUEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 16:04:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23CBBA50D8;
	Wed, 24 Mar 2010 16:04:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jdIQHo8TuxHRz2J1KageT3vfvZs=; b=oWBMLJ
	Bm+wuZ9NooGhGLgb0UBJewrR4v8Wm3tqjJIzvaPbMFUVa5Zi67qNTqHFW+nYY2Il
	elQYE9HQvgcnwFBSINcfcoKgmvqIuCpzyrjYri48xeybzQC8St2/FzaKDgH6ih8d
	6A5S84tDVQJNiBP/OpJOOryOfldaGRDJd2Jmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OrnxqXwvrHLpPc/fW8ukD/FK6q5wecdS
	UdOxcGLmNZGoTDCLugqVzzEoNvEMqRG1ZoksSEijDj/9yCVh5H5iXGePcFFE1Haf
	lyych7laNhXCIQPSvRqgulsB8fXYgHb3XRwVZsezkCbQ2Mc8ntIEJOpEF/p7k+e1
	5IJbP39A3rY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCFCDA50D5;
	Wed, 24 Mar 2010 16:04:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F926A50D1; Wed, 24 Mar
 2010 16:04:27 -0400 (EDT)
In-Reply-To: <81b0412b1003241207s4951b32cpbe105e7b3623f61a@mail.gmail.com>
 (Alex Riesen's message of "Wed\, 24 Mar 2010 20\:07\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76834B18-3780-11DF-B1E4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143112>

Alex Riesen <raa.lkml@gmail.com> writes:

>> When would you invoke this feature as "one-off"?
>
> Maybe when I want to make sure git status does not go all over an
> NFS mounted submodule.

But then what would you do after finding it out that it might?  You stop
working on that project?  Doesn't --ignore-submodules do the same thing?
