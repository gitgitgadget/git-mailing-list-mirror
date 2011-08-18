From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Missing item in 1.7.7 release notes
Date: Thu, 18 Aug 2011 16:13:50 -0700
Message-ID: <7vty9e5n4h.fsf@alter.siamese.dyndns.org>
References: <CALgdb5K5iWbqudT_4Euw8yxCmxOz6JVVhFUG=kywjDSTGbx4XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Fri Aug 19 01:14:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBmi-0004gv-OV
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab1HRXNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 19:13:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab1HRXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 19:13:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9C3A4B85;
	Thu, 18 Aug 2011 19:13:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e8GYCXMwFlTk8woH2adxnM456Fo=; b=HDO6PE
	GyEJSMndZSWpcqCVgPelESQ+shzL9f5n+W+Dgw3aYm5cnxwen+Fyj1pQI7XSucJt
	nymjXSd3LqnmRYxEVz0LaqEeP9OJvEgM8m7lbEzpE4U9lPJGqUuqCDQiF7uvb6qZ
	WovnBhKia25qbCpl4bGYuUj1sbaUrjkiz3M5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bAvUSZ7i8/Av79qIyWDDxzvpt3hr7Hf/
	kunBcFb/iZjV+7gsIcWhhQOu3DwRN0aVp3cuX4LeaGNdG8dwSb56zKAARCDnn30k
	nXG2pBzCS9ottUXgVsvyx2bxj/SIG/tUePwcSaNvmZTdR7XviNO3HGY5+38gx+OQ
	VHsjpH4Xn6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A10EE4B84;
	Thu, 18 Aug 2011 19:13:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E4D14B82; Thu, 18 Aug 2011
 19:13:52 -0400 (EDT)
In-Reply-To: <CALgdb5K5iWbqudT_4Euw8yxCmxOz6JVVhFUG=kywjDSTGbx4XA@mail.gmail.com> (Ori
 Avtalion's message of "Fri, 19 Aug 2011 01:32:26 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCB33EEC-C9EF-11E0-A97A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179656>

The release notes are meant to list only noteworthy updates in a concise
manner. With 100-200 topics graduating to 'master' in each release cycle,
I cannot describe everything that happened in the release and expect the
result to be readable by the target audience, so we need to draw a line
somewhere. Usually miniscule details that affect no user in practice in a
real way are not described (e.g. "fix grammar in an error message").

Interested parties can always look at "git shortlog v1.7.6..v1.7.7".
