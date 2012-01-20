From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-i18n: detect and avoid broken gettext(1)
 implementation
Date: Fri, 20 Jan 2012 12:26:19 -0800
Message-ID: <7vbopydst0.fsf@alter.siamese.dyndns.org>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
 <1327063775-28420-1-git-send-email-avarab@gmail.com>
 <7vobtydu0o.fsf@alter.siamese.dyndns.org>
 <CALxABCZJATyVRf9akmfpn3WpJ8Xt80Ky0isFOTwDGpFKvFp3nw@mail.gmail.com>
 <7vfwfadt10.fsf@alter.siamese.dyndns.org>
 <CALxABCZnz-8BuXf=-HrH7UZXi6pQ3VzL4HrOKgKHqWwUMnwJQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 21:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoL2Y-0002Nv-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 21:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab2ATU0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 15:26:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485Ab2ATU0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 15:26:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 646895442;
	Fri, 20 Jan 2012 15:26:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ovbKO+fdZjQ6w1IIGaOaD2rH6FQ=; b=ZHSkz6
	94J/+sXqfUllly6k3E/Kyye2QqDSwc2VcgUqQo00FdzSXXICeKrj6V1LGPrNGOWu
	Co5IXghqhF0/TwI89KEizc2MnS3dJFT+EFCCdUJaW2v43EahIvWg9wLlz9NGP8ga
	8xVvfBSIbiUXksNPxefYWO2ozqtwONBmLEYPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E11ShYk9c7G1gosj1qHs+ugxHb1Qrcle
	fZcq6sfLNUe9o6liNs0Dck+3S1KhOLSOQP6rGSHrIP407YpiiiJ6BZNXJYuDEpNs
	z3zLQEkV6lrZ8vXIigR+saCgzZZdvadtqeHZW4r+GNsDH1xwIbC/wns6cptNXtY4
	NIpb/dPaNNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AF3E5441;
	Fri, 20 Jan 2012 15:26:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2F5B5440; Fri, 20 Jan 2012
 15:26:20 -0500 (EST)
In-Reply-To: <CALxABCZnz-8BuXf=-HrH7UZXi6pQ3VzL4HrOKgKHqWwUMnwJQA@mail.gmail.com> (Alex
 Riesen's message of "Fri, 20 Jan 2012 21:24:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03C00840-43A5-11E1-BB6F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188902>

Alex Riesen <raa.lkml@gmail.com> writes:

> .... Besides, the current version
> wont have problems with such an upgrade.

Yes, but at what cost?
