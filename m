From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ignoring pattern in un-ignored directory not working anymore
Date: Thu, 06 Jun 2013 11:19:38 -0700
Message-ID: <7vfvwvyudh.fsf@alter.siamese.dyndns.org>
References: <CANPayMS19-bjgWRMYrRcGYzKgEo_0Az_8emeDrKwxx9RguDbwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>
To: Moritz Bunkus <moritz@bunkus.org>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukemo-0004JD-1J
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab3FFSTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:19:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab3FFSTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:19:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEA652203C;
	Thu,  6 Jun 2013 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VcNmAEyLrjv5zTlRrxh19rMUYag=; b=c0oUi0
	uH3l7y8aksWZ60i+67d2uE/ESYwNdk8tEUBMpvPrumGVgIPnmL7Eb+CocbL5+c+W
	4eRqHLoTysbyTvDhp+JLW50/CEAVIv2I99W1LycDltBAN7JxRkuG/DF9i7yEkjZ5
	iMPFApU+fG1aga67Hg5ndnm1TBn087g9QgkSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HxyvQpEtMwZPJSmS323Pzcb9race3joy
	UCHjujceRZJQh+gUX5yE5Scz7reOAy+NkB3wt44PP4RMqHsy3VabaNO8Kpe4/t1A
	golPIJEHEwbTnKWbT2gekM3glBLwFCQQ+K+5e75lJpQxjUSMWajcMpSCXDZ8MpG4
	/ssmAqD+8FU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2E292203B;
	Thu,  6 Jun 2013 18:19:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53C0F22039;
	Thu,  6 Jun 2013 18:19:40 +0000 (UTC)
In-Reply-To: <CANPayMS19-bjgWRMYrRcGYzKgEo_0Az_8emeDrKwxx9RguDbwg@mail.gmail.com>
	(Moritz Bunkus's message of "Thu, 6 Jun 2013 10:29:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A73A9A6E-CED5-11E2-9CBB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226522>

Moritz Bunkus <moritz@bunkus.org> writes:

> This used to work until recently, though I'm not sure up to which
> version excatly. I'm on Arch Linux and therefore usually pretty much
> up to date. My current git version is 1.8.3.

Could you test if 'master' at 3684101a654d (Merge branch
'kb/status-ignored-optim-2', 2013-06-03) or later fixes it?

Thanks.
