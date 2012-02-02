From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 02 Feb 2012 11:27:26 -0800
Message-ID: <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2Jo-0004IW-AP
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab2BBT1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:27:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2BBT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:27:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF68F68F8;
	Thu,  2 Feb 2012 14:27:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lOH6zdZyhWDsviV5B8+zEawKR+k=; b=xAo3A/
	henJu3DlNKMrxDV1yXtjADFnvsJjPUJCVcMCNBF2wgaOPnj2dkWoJw74wWAP1Aox
	zGbEkTTNh8eNQoqnDxTutYkqUpxoS9kHW873Y3+9KQa8GLEMpbbT2xlKLCuAsPK3
	11GP+PhcFdVY5lEwUL1jnEKk7KzofT2t7UR+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wvOc/sjb/nzRedW5rL+t1pm3y5gvwEDD
	gEZxQvRKROsbTimBWuuKKcKeGNa6ndxc2Tisl3Z9dlCpJ8kq903T7ZODL29m740Q
	z72MOcqQAuKBnU7G1ps2QgZpK9H1cpFRQVbmjxKnYIM46kZthAxRy+Xel3YSRB1p
	4A+5cOe/FKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C7668F7;
	Thu,  2 Feb 2012 14:27:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F03B68F5; Thu,  2 Feb 2012
 14:27:28 -0500 (EST)
In-Reply-To: <20120202084859.GC3823@burratino> (Jonathan Nieder's message of
 "Thu, 2 Feb 2012 02:48:59 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1A3E756-4DD3-11E1-A9E3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189679>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Felipe Contreras wrote:
>
>> Felipe Contreras (4):
>>   completion: be nicer with zsh
>
> Since I can't find this patch in the mail archive, I'll reply here.
> Luckily the most important bit is above already.

Thanks for playing a mail-relay.  Except for the much more readable log
message you have here, the result matches what I have at 06357ef (modulo
test vs '[').  I'll replace what I queued.

> I think I mentioned before that this subject line is what will appear
> in the shortlog and the shortlog is all that some people will see of
> the changelog, so it should include a self-contained description of
> the impact of the patch.
>
> However, clearly I did not say it clearly enough. :)  I guess it's
> better to take a cue from storytellers and show rather than tell.

Very big thanks for this ;-)
