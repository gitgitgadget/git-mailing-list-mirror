From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect code 125 - "WFT?"
Date: Wed, 16 Mar 2011 14:36:38 -0700
Message-ID: <7v1v267no9.fsf@alter.siamese.dyndns.org>
References: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzyOo-00080t-K4
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 22:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab1CPVgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 17:36:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab1CPVgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 17:36:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5110833F5;
	Wed, 16 Mar 2011 17:38:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TTw0Ly5xGy6BriGFWjIVjfZjyKU=; b=JeN74F
	7mHk+ToiXQVgKVR8PAsurR5XkehooBTBnSpMx91PLH9inRT5hrbGRf2x+15QPSAG
	9DOLxZ8VsiajsM2/BSvbeDIYByMLf0mQlyoc72wkSg+vpbSqK3FNGQOsl1DMpzD3
	ucT/xFfU7sDryLKCofb19ucCpVJxeJZWE0DMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UjfzaYLsbNQ7SkHZ/8lJLOQ3+LsF0mNe
	xdP6mQJT2mRN6hJ+MA3FphZ6E4PV6Ek4zLUYY5uXe1VzyLHIDjAuYVtOKatJMeoK
	/MCng07w801MWO++WYJv3CPyMlFRXcOwxi6yXM+3enOcZgCORSqDsJ7Ijot66FmE
	VUUx3odsBRs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BB6B33F4;
	Wed, 16 Mar 2011 17:38:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 11E7633F3; Wed, 16 Mar 2011
 17:38:12 -0400 (EDT)
In-Reply-To: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com>
 (Piotr Krukowiecki's message of "Wed, 16 Mar 2011 21:44:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B446CB10-5015-11E0-B349-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169199>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Opinions? Would it be possible to change the meaning of the codes now
> (in 1.8.0)?

How about just documenting why it is a bad idea to use 126 or 127 as you
found out somewhere, and stopping there, iow, without changing the code to
use 126/127 that we consider it is a bad idea to use and avoided using so
far?
