From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitweb: add a feature to show side-by-side diff
Date: Mon, 17 Oct 2011 12:37:23 -0700
Message-ID: <7vwrc3l898.fsf@alter.siamese.dyndns.org>
References: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFt07-0005FV-71
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab1JQTh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:37:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab1JQThZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:37:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF5E064D2;
	Mon, 17 Oct 2011 15:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=73e1W+k1iBgeaDVUAoEJk+zWGyM=; b=SW7RdR
	o67xbksK/42KzMSMsy2+YYoxYEN1/QNPUVqhPDoXDwe3Efjzi1WkYSN/ASXUQfbZ
	4GkMdG/sOhU8i70Dr8eYlt5scBa7wnNbamOFZjf/hfIFdaUCtd5hZ0MU1fOG29oE
	Z4XQQq2YWnkZ0M0mgf9ISRsjiRSe4OS7a/Sqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CyGqA6mLyArp03NQeFXq0aqMuBA/gldf
	uiCxivbFXyvRmaCNDqvMdzErStCbLHIqSFVcrlC265jrRzMqjyLSAESg8cf2ciwd
	LYDMjh2l539WvVYBDEdMO4YJIeoTamuE2bJfxcKHjilaMdlb0VchWvwaChFyas4M
	tAY/pIQkGug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5B9264D1;
	Mon, 17 Oct 2011 15:37:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C01764D0; Mon, 17 Oct 2011
 15:37:24 -0400 (EDT)
In-Reply-To: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com> (Kato
 Kazuyoshi's message of "Mon, 17 Oct 2011 16:00:18 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70393FF8-F8F7-11E0-8A08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183811>

Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

> @@ -2276,7 +2279,7 @@ sub format_diff_line {
>  		}
>  		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
>  		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) .
> "</span>";

Corrupt patch (wrapped long line); please fix.

I suspect you have similar issues in the [PATCH 1/2] message, too.
