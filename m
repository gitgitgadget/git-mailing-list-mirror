From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 2/2] grep --no-index: don't use git standard
 exclusions
Date: Wed, 28 Sep 2011 13:01:21 -0700
Message-ID: <7vehz0zbam.fsf@alter.siamese.dyndns.org>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com> <7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com> <7vmxe5pp4n.fsf@alter.siamese.dyndns.org> <CAKPyHN2ewwLf6am3VQr_z4c3_Q5=saeLcZtuY-fEtUGr-41rKQ@mail.gmail.com> <7vty7xwrsf.fsf_-_@alter.siamese.dyndns.org> <CAKPyHN3=mbtEkyFUBdZAJCEVXfJhwPVhVFWkNNfX-yhtw9498w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 22:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R90Jv-0005J5-D6
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 22:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab1I1UBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 16:01:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754653Ab1I1UBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 16:01:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C95AF6096;
	Wed, 28 Sep 2011 16:01:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJGhsrCLwG43LPhzRelYcKowzVQ=; b=L5Laye
	YnPFJVDQaTFuShQMP/2RfcU5eorcauo7cG02YmVk96UxXM1Ruk4KSEYqlJgWhWzR
	0Uc8XKJ357IqZ/MxQT92PpM97/qzj3JZV5qDM6Mb6EMzKBJBM9FxrjtEtM+nCkPC
	p2ksA99AODULqBKn8OBVVtVHDv6jwJEwqi6sU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tokdpt6j+b5qvN8OqEqAgPhDiUZ1Yx9A
	Sl6K8CUWyEItMp9TvjX5yyqe8TPKXOg10sc57h5vi/HySy8QGjCpNHq12Nx1B28V
	tox2FWH+IBn6iL9SNFLzEhsn84dhFc3RjJ1GC1I9JhtBVZJ+XOKM8ntd83pDTgNm
	cBoDZlxbLOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0BBA6095;
	Wed, 28 Sep 2011 16:01:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CF5A6093; Wed, 28 Sep 2011
 16:01:23 -0400 (EDT)
In-Reply-To: <CAKPyHN3=mbtEkyFUBdZAJCEVXfJhwPVhVFWkNNfX-yhtw9498w@mail.gmail.com> (Bert
 Wesarg's message of "Wed, 28 Sep 2011 21:19:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A402B4C6-EA0C-11E0-9730-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182364>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> I would still vote to name the option --exclude-standard, like it is
> done in 'git ls-files'.

Thanks for catching.
