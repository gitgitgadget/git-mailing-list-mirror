From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Better ref summary alignment in "git fetch"
Date: Fri, 03 Jun 2016 10:37:26 -0700
Message-ID: <xmqqd1nyp415.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160603110843.15434-1-pclouds@gmail.com>
	<20160603170058.GB1733@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:37:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8t2Q-00027G-Od
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbcFCRhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 13:37:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932207AbcFCRha (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:37:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FBCC21606;
	Fri,  3 Jun 2016 13:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d4EJ2aH3KeiHyy/LAd9N1MZOvP4=; b=nt1xst
	9RwkTlw6aVKgaM2C3UoX+vzuuG0nef4gcsc0hlxlbYy31wnTKXm2RvpTVZuf8ScF
	Sq2RTrdJ1DYCFBHRdXYaaupSQZE6inAWpOEkLsgwVKy+18aa+tI8+xAHBsC/SU3f
	2WUv1EWp6YX/syplhKk6jsEblLt7P+2+4gPMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j4G5hgx4ZfKqxnvMTfO6G0ETByBIkYTp
	I4kx3iJQWhRf+Rnfigi+hKGOJ60R8MP/WOxXUT559PCCDVCu9BLFqKi2O2j25Uv+
	knWQCHm2z7+/sSOBVErY+5fPI7MwGfuGPknulKTlq2C+uCLWDqBEuhaZcGFH3r2/
	Ikyelq/yzmA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97B6E21602;
	Fri,  3 Jun 2016 13:37:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15EDF21601;
	Fri,  3 Jun 2016 13:37:28 -0400 (EDT)
In-Reply-To: <20160603170058.GB1733@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 3 Jun 2016 13:00:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7643B48-29B1-11E6-AF15-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296357>

Jeff King <peff@peff.net> writes:

>> It's a shame that the flag '-' in these ref update lines is not the
>> same in fetch and push (see 1/3). Because git-fetch does not support
>> --porcelain option, maybe it's not too late to change its meaning...  
>
> I'd agree with that final "maybe". :)

Yeah, this is purely for human consumption (which is why we see
other changes in this series in the first place), no?  So I'd agree
with that final "maybe" too ;-).
