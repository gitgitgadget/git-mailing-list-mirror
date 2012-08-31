From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (minor concern) git using the pager should not be a default
Date: Fri, 31 Aug 2012 11:48:23 -0700
Message-ID: <7vy5kunbig.fsf@alter.siamese.dyndns.org>
References: <503E3CFE.1080603@sigmadesigns.com>
 <7vd329wpt0.fsf@alter.siamese.dyndns.org>
 <nngligvdk0q.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emmanuel Michon <emmanuel_michon@sigmadesigns.com>,
	<git@vger.kernel.org>
To: <dag@cray.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 20:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7WGe-0002L3-Af
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 20:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab2HaSs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 14:48:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275Ab2HaSsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 14:48:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3434286E5;
	Fri, 31 Aug 2012 14:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j469P7TFH74BiymPKMvB5cq3Qmc=; b=S78BS7
	8qWcXOIz82NkTUHvaoHLkyy5/eF0OOPZRNK0Q3KJjrdg/FJHO52CfoGsTmqPG5wi
	x/clWHrgg7SiNfHIHVw02ZnXSLIPC0T8Q7z0UspeN2C7e5aW/JsqKzr/hFIWbeLz
	eM6b8WeVZc5A8H3NLfIW5atMpVpHf4gde1HvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BOWS3BNqH0R0pNiQfmnMFoLAB/2Z/EGv
	yg/l1aIKWktBbbhBZBMiUQh9PXy7NuiVQFUoHq6z/PI/zeSf06Mfv5ySK6dNDcko
	MlAUgHxa6+/T54MAKAhFCGFbOSxFA/g1FkbJEctMEtVC34UGCosl0aWNIYrcRrUZ
	6RcgBNPV+l0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2246486E4;
	Fri, 31 Aug 2012 14:48:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95B8886E3; Fri, 31 Aug 2012
 14:48:24 -0400 (EDT)
In-Reply-To: <nngligvdk0q.fsf@transit.us.cray.com> (dag@cray.com's message of
 "Fri, 31 Aug 2012 12:54:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71B90106-F39C-11E1-A423-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204604>

<dag@cray.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> In other words, Porcelain (roughly speaking, those that page by
>> default when their standard output is terminal), are not "command
>> line applications"; they have a layer on top with a built-in UI.
>
> Is "status" considered a plumbing layer command?

Have you asked "git help git" lately?
