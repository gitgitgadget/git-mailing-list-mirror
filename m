From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Sat, 10 Sep 2011 09:30:29 -0700
Message-ID: <7vehzopdga.fsf@alter.siamese.dyndns.org>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
 <7vipp1otyp.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 18:34:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2QW4-0004Yx-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 18:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440Ab1IJQad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 12:30:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933370Ab1IJQac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 12:30:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 743815AAB;
	Sat, 10 Sep 2011 12:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v88IJQh6FLmi52VXDg7OunVhIlE=; b=CePYSo
	GkCSyA9684GXoVF8bF9w56W74fEstO3A6LhKugi3Fgosfs16/k/PkLzuOCcOTjrY
	ZCPs+2C9OcFwZLGbcNCHrcLmvyKz/KuIz5rcUjwfIGMyIfDeEn7tbJNuN7OCdc4E
	9bIaheaNKGzTpdTdxw0bMZjj9BqaeK6WBbY1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pt92ryeTZ3j6B9GkcwJXr1jIqXxzEo2+
	KFI49ITm5cNN7p8vbf9NOfeyQHoSS4ebRGvoVMGYaIAdGD0LPWQpTi9Sq4zWINQm
	7fNfsW5O9jfaidmFDI/loUJrIPiON0Md5ir4afo7qc+dWGgzxpiseNJGXQ3la9WM
	O1puuewe/eQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B45D5AAA;
	Sat, 10 Sep 2011 12:30:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 051DA5AA3; Sat, 10 Sep 2011
 12:30:30 -0400 (EDT)
In-Reply-To: <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Sat, 10 Sep 2011 17:17:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33385A66-DBCA-11E0-A227-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181157>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I think this is also some further motivation to have a

Did you miss that I already mentioned that workaround?  It does not _fix_
the fundamental breakage, which is that you are _forcing_ the sending side
to keep copies, though.
