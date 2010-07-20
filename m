From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 0/2] Add -e/--exclude to git clean.
Date: Tue, 20 Jul 2010 11:02:55 -0700
Message-ID: <7vaapmm3ow.fsf@alter.siamese.dyndns.org>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com> <cover.1279643093.git.jaredhance@gmail.com> <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:03:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObH9t-0007UV-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab0GTSDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 14:03:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0GTSDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:03:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA84CC6E7E;
	Tue, 20 Jul 2010 14:03:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65snCa05/XVxXr0xAd4k4AkcX0o=; b=c5ckqp
	mqO9vyV381LDoQ0mZ5aayWY/MAM9I+8VbW+QWDfgkSIFOFJHrNH1aqL8+yVEBZEp
	8WbnFJHYgknDlXvCJefiH3B5C6L9KnaFRIM4Vm+Uv2RfMSZ8UsO9ZJi4tk1YUFMH
	cXIXuA7epx168WmCQnmPJHwGoR+0sYG8keYYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qxm1nm5jl8KOpJwfWpOg4KRwQAwSFozV
	EStfdPuwCFWvJyjrtrTV1FljycS3HDCYuumHlrg5VAz6pnU2C4NlB72chYXJlZVo
	8kzFUTjpWYRqLxZHC61wHmvnGVq8TYw4QEWWCJRfojZ8j/EcQ0iwo95cQzuPoM+G
	w4iC4LHuKcA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 946C2C6E7B;
	Tue, 20 Jul 2010 14:03:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1F95C6E77; Tue, 20 Jul
 2010 14:02:56 -0400 (EDT)
In-Reply-To: <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com>
 (Aaron Crane's message of "Tue\, 20 Jul 2010 18\:03\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08BBD0F4-9429-11DF-BD4C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151339>

Aaron Crane <git@aaroncrane.co.uk> writes:

> Jared Hance <jaredhance@gmail.com> wrote:
>> This is the fourth round of patches for git clean -e.
>> Since this patch seems to be somewhat controversial, I've marked it as
>> PATCH/RFC. I would like some ideas on what to use for separators
>
> Rather than stuffing multiple exclusions into a single option, how
> about requiring one -e option per exclusion?
>
> git clean -e foo -e bar

I find it a lot saner.

Sorry, Jared, I should have thought of it and suggested it during the
first review round.
