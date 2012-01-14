From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gui: fix applying line/ranges when the selection
 ends at the begin of a line
Date: Fri, 13 Jan 2012 23:00:12 -0800
Message-ID: <7vaa5qydj7.fsf@alter.siamese.dyndns.org>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com> <37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com> <CAKPyHN0tqQKuPONj_F9MXbgoHxeoZ7pFVSLPNWHddnA8340MGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 08:00:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlxbC-0006JO-Fs
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 08:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab2ANHAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 02:00:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab2ANHAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 02:00:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4D94745A;
	Sat, 14 Jan 2012 02:00:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEZGusnxNAS73u2LV2Z4ijzXcTA=; b=YLqDtd
	68sSDT3Rd/jkw7YbpdAcDZxuRgH8Ol/LXVZ1Y6vD+VXiOo6mg0tEB1Qnve3OAzLi
	/ivELUdUd/OZvKQlsVH+/4TSvelCWO+qGpkwSfyolpLEQ96/zeYZMN0qL5gSYj90
	VecMe/g2ZeT49vpJcGNQ5KYvgpP+7KDpKT+dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+khzwIy0bEB+eSUKngoYnrK1o6WNdkF
	MMquTk0UgZCUIarD7GiY7aZOQm/z/b+mMXG/yjqDPfAQWQleROs+U2YTlIu1mlZs
	g4c12ZK02LoBbS5CrouNTL3QKT1ZGpWDLvPoSG8Qv5DzsIElY3BS8qnltAuAzktE
	lvaXbI7i1eo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BA037458;
	Sat, 14 Jan 2012 02:00:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22F887457; Sat, 14 Jan 2012
 02:00:14 -0500 (EST)
In-Reply-To: <CAKPyHN0tqQKuPONj_F9MXbgoHxeoZ7pFVSLPNWHddnA8340MGA@mail.gmail.com> (Bert
 Wesarg's message of "Sat, 14 Jan 2012 06:26:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 686B9908-3E7D-11E1-9B41-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188551>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Mon, Jan 9, 2012 at 14:43, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> Selecting also the trailing newline of a line for staging/unstaging would
>> have resulted in also staging/unstaging of the next line.
>
> same here, could you please consider pushing this into the 1.7.9
> release. I see no point in waiting for the next release.

I do not use git-gui myself, so I wasn't paying much attention to these
two patches.

If these two fixes are for a new feature that was not present in v1.7.8
but has already been merged before v1.7.8-rc1, then do please make sure to
push them forward.

On the other hand, if they are fixes for an old feature that was already
in v1.7.8, then it is a bit too late for the next release.

Thanks.
