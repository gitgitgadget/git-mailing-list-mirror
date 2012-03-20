From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9 v2] difftool: teach command to perform directory
 diffs
Date: Tue, 20 Mar 2012 09:36:15 -0700
Message-ID: <7vmx7b6xhc.fsf@alter.siamese.dyndns.org>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
 <7vhaxk9ui6.fsf@alter.siamese.dyndns.org>
 <CAFouetj2gME+X47EUAQTUKX_GJ8PW=cSWRj7VUdBsi91Aa9Wyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 17:36:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA22q-0005Nb-DY
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 17:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350Ab2CTQgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 12:36:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2CTQgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 12:36:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1F2F6E2C;
	Tue, 20 Mar 2012 12:36:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ABV7wc4SWKP43cI5UV7TpduNik=; b=EwIyx0
	Ln4GOFM2i5G1CbOKuMrw3HQP/Hc/Kf7P6kfj4PTTYszvYH+lpWX35uGaW7AGAq7C
	mzSUU6L/XOk3FiJQC4P31cjW1BYfpLj3EvrZonCwWBXqT6NJVJ3WbrxiIIiXk8JY
	tQzSuNQwOy9lFxqTGJMIiTYOj1Wgux82K67Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eyGUd9oIjkaUGdWW4Sh5zG8u6AUl6fgJ
	ZGUYmlI1uR4gGHpYTwW4BUdVP6G0Icoca4lHN5cGxad18+OsajsjoLUrfYZ2fmkM
	e0YJ4fWzZUExavvtQQwVfG3tpwfDT4OtrOxAX/mSwFhDmy1RbIQVEHDeacSrSxGy
	hm5CV2AVOdw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A941D6E2A;
	Tue, 20 Mar 2012 12:36:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 366AC6E29; Tue, 20 Mar 2012
 12:36:17 -0400 (EDT)
In-Reply-To: <CAFouetj2gME+X47EUAQTUKX_GJ8PW=cSWRj7VUdBsi91Aa9Wyw@mail.gmail.com> (Tim
 Henigan's message of "Tue, 20 Mar 2012 09:07:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0E2C702-72AA-11E1-BED6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193517>

Tim Henigan <tim.henigan@gmail.com> writes:

> So the only outstanding changes that I am planning are:
>   1) Remove SUBDIRECTORY_OK
>   2) Add tests for the new '--dir-diff' option
>
> Would it be better to resend the complete patches series with these
> changes or just add new patches to the end?

For the former, a replacement patch ("[PATCH v3 7/9]" with "this replaces
patch 5/9 from the v2" after "---" line) for the ones that need replacing
is preferred, as the topic is still in 'pu'.  For the latter, we can go
either with a separate patch "[PATCH v3 10/9]" or an update to the one
that finishes introduction of the new option.

> Please let me know if I missed anything else.

I think I saw t7800 failed with this series somewhwere around "last flag
wins" test.
