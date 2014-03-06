From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] commit.c: Replace starts_with() with skip_prefix()
Date: Thu, 06 Mar 2014 11:36:56 -0800
Message-ID: <xmqqlhwnxgo7.fsf@gitster.dls.corp.google.com>
References: <1394125521-9341-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:37:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLe6P-0006RF-K9
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbaCFThC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:37:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbaCFThB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:37:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A077470046;
	Thu,  6 Mar 2014 14:37:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LAuW9kZpSAPbwHrO8E5KzbZuRwE=; b=nPY5Vl
	NpwCXIH2+p30fPxv3hm46kCQHdFp3usf38K1xLeTutXF56nv8kKImjmFTgiwOrY2
	5z0ewICrFK6pEPZubOt4zlib8xJ/Cpm3WIJ0jUzNwmhYAHWDyg0Ohlf5ccDi1By5
	+Y5DXlz9PmNAoK/OS/YOHTeLN2nQ3yJpA/xW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yxxv3PTAOcMGGQUMXnZWZXcsAuV0RsFO
	R8hmTZglZpkCnmtb7sD8jORvwmQjXX6ihifGQo9yqiwfjBdiISkUHV9b4yiCfTM5
	Mpd76kKxsXQpzTLzKHBkzAmzm3BFpf6JGQXLnnUjw7lWnWkLc1GZATnf0r2FbsSS
	fjFpmRxchcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83CC170045;
	Thu,  6 Mar 2014 14:37:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 361AF70044;
	Thu,  6 Mar 2014 14:36:59 -0500 (EST)
In-Reply-To: <1394125521-9341-1-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 6 Mar 2014 22:35:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AEFCF856-A566-11E3-AC51-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243540>

We already have 147972b1 (commit.c: use skip_prefix() instead of
starts_with(), 2014-03-04) that covers the record_author_date() and
parse_gpg_output(), don't we?
