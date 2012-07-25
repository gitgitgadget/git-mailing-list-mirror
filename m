From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to unignore files in certain directories?
Date: Wed, 25 Jul 2012 11:05:10 -0700
Message-ID: <7vmx2nbtt5.fsf@alter.siamese.dyndns.org>
References: <CABrM6wk+acut6EaoK=_GuQw3w9vhn_4ONoF21cj1GtEtHFWBKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peng Yu <pengyu.ut@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 20:05:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su5xZ-0007tZ-OK
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 20:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab2GYSFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 14:05:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab2GYSFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 14:05:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D19592F5;
	Wed, 25 Jul 2012 14:05:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZyWus3yv7nxRtHRZBgQJ0HgNVgE=; b=Yrg+yS
	iikzzKnk3BDSgkcKDPNEYiiXskQ1uKKFEY7q1jMhOfXrdzz8yVKTpaEFncJsVQBU
	NE8ZQrxGnqbFVko2k99sIwD+jxiLj7+Ahc3JN2Cu5CRMUff0Wq35T5MxLNymQuUl
	S/0KNMMnwoJZ+av2yL27cVK3HtR9yS8iyakRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tMJJBjgOE/V76Vbq4RAAeOm/oCHPm1NN
	oqwi4WCXvZ8nwL3lTQvKusdSRwiNusox+zRmbIXd/z+5uxE5VkiT1iW4meRQbqLz
	uw230X9R5A+RADaokcw83SnrDVbskpDVr/rvp3uQCN9JJVuUrGa1b9GJUcNa3OJQ
	NG8xyeDbU8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A67792F4;
	Wed, 25 Jul 2012 14:05:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA46F92F3; Wed, 25 Jul 2012
 14:05:11 -0400 (EDT)
In-Reply-To: <CABrM6wk+acut6EaoK=_GuQw3w9vhn_4ONoF21cj1GtEtHFWBKQ@mail.gmail.com> (Peng
 Yu's message of "Wed, 25 Jul 2012 10:48:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46F07DEA-D683-11E1-B725-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202183>

Peng Yu <pengyu.ut@gmail.com> writes:

> Hi,
>
> I have the following in .gitignore to ignore *.txt files.
>
> *.txt
>
> But I want to keep the *.txt files in, for example, data/ and all its
> subdirectories. I don't know should the the correct way to unignore
> these *.txt files. Could anybody show me the command that I should add
> to .gitignore? Thanks!

Have you checked "git help gitignore" and looked at its example
section?  I think the second example is exactly the same as what you
described above.
