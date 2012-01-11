From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t2203: fix wrong commit command
Date: Wed, 11 Jan 2012 00:09:45 -0800
Message-ID: <7vmx9u7j92.fsf@alter.siamese.dyndns.org>
References: <1326252098-2891-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 09:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RktFq-0002Ng-3l
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 09:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab2AKIJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 03:09:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756117Ab2AKIJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 03:09:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A52359E2;
	Wed, 11 Jan 2012 03:09:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=aZsTky
	1FSJ9UOiWcd2PyvHtc9QPgg4ek/xCWIKoTopbQNEYU0mpG376vMtpuJiJdTgMrt9
	1/DFBnU69BkI94WWjI7b5T3Tk1VBK38xArxPEkWpAX0DrEWYeOz3Lx8DKR4G2G4Z
	D2v7bjYWKbGmTJwuIbEAWA+hbXziZcQI/PCxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7ZzdzcBrRZaeMSd7ln2xw5PSXtAmBob
	nxtiSTlgcH713speC856Wq93lJ4yZZGq0Akc8bHOC3S4fbj1HUL3rpBcKoueNIu+
	XuUDvQ3jIrzF7k8N20cRw5d28pjRorc2Mkf46GG9I4QQBoywUPZ9cN2yrK5upMyw
	wYwIBwJUHbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8138359E1;
	Wed, 11 Jan 2012 03:09:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEFBF59E0; Wed, 11 Jan 2012
 03:09:46 -0500 (EST)
In-Reply-To: <1326252098-2891-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11 Jan
 2012 10:21:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A04E63AE-3C2B-11E1-B51B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188342>

Thanks.
