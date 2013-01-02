From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Add --unannotate
Date: Tue, 01 Jan 2013 16:32:37 -0800
Message-ID: <7va9ss77bu.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-3-git-send-email-greened@obbligato.org>
 <7v623ga8vs.fsf@alter.siamese.dyndns.org>
 <87sj6kfsbz.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Wed Jan 02 01:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqCGS-00085m-So
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 01:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3ABAcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 19:32:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab3ABAcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 19:32:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F6DB33D;
	Tue,  1 Jan 2013 19:32:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M0JLzC7KqQRh2UYJSiXt+1Mo4/Q=; b=UwJCTf
	A76gw+VTKB9/bAIBZzs67aIEYMpy6nfdkkvhypQYbzswqqylEuHOcrulFjNuHZS6
	NlHoY816i6d8WI+/Vra+vQY7SCEskPPF7pT50P7nrjgvtWx/67Ok68vEcbCb7CUx
	o/vFAXHYmswQzD1UpPTQ7KzVkSTEsxqlT+9uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ka9pVCoTQGoxB/oHWX9O0OrY68EdsPvB
	tXqei8z3HmpbhIXG/vrAOtwS3CxNP//JSOFROBuTxupYCHgK6tiz/OisfirXWjCZ
	Thj677yRYQxABufHj5+K4fzKPJK6mCBXGNIuSrmgryjlXf5iukSmAP2OY/k6y7Kw
	n9l6o/jCxe4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AB97B33C;
	Tue,  1 Jan 2013 19:32:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8D74B33A; Tue,  1 Jan 2013
 19:32:38 -0500 (EST)
In-Reply-To: <87sj6kfsbz.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Tue, 01 Jan 2013 16:31:44 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E96648B6-5473-11E2-9EFA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212477>

greened@obbligato.org writes:

> In the meantime, will you apply the patch or do you prefer a new design?

The --unannotate option will become a baggage you will have to keep
working until the end of time, if we applied it.  I think it is not
too uch a baggage, so it probably is OK.
