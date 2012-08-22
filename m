From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Get ciabot configuration from git variables.
Date: Wed, 22 Aug 2012 09:47:54 -0700
Message-ID: <7vpq6ian5x.fsf@alter.siamese.dyndns.org>
References: <20120822105230.GA30382@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Aug 22 18:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4E67-0002If-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122Ab2HVQr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:47:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab2HVQr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:47:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30B968884;
	Wed, 22 Aug 2012 12:47:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7EO+9KwisYIYyeVLo6cOmdTVenE=; b=H75V6J
	T/EawOZYZS6AHR4gPfqqglANNgs17B/n+oyn1K0sPOv9jwo4i1SUte30EucTVnSF
	HMdWV4xtphyPkeLpAkBZDOcWrR8/yxANhwNgW/O0mdVMol/5OQzgFsHPSkRGwnNR
	J+bSkt9mETjBivX+kun8wxBkfBIQ5/4NMzifQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WuEdsmCaXsXxWLlsL1n88YQPannr0JW5
	6wpuGrJt9UBmm6vYk2IPx58reJFreQxcOL0XSfypQVo/37iUPv7asW+ODzJmsGm4
	hRMTmeHsJB6dqwqRwLIquncLiGqItr4FqJPvrDR+ZCrIcZ6qLO0Zvul1ZggxEHS6
	kXgwaPb9ABk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DBE78883;
	Wed, 22 Aug 2012 12:47:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 914AA8882; Wed, 22 Aug 2012
 12:47:55 -0400 (EDT)
In-Reply-To: <20120822105230.GA30382@thyrsus.com> (Eric S. Raymond's message
 of "Wed, 22 Aug 2012 06:52:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F2C5FD4-EC79-11E1-9EC1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204029>

Thanks, will update 'maint' with it.
