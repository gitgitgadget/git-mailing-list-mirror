From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Time zone option name (Re: [RFC 5/5] Date Mode: Tests)
Date: Fri, 22 Apr 2011 22:27:51 -0700
Message-ID: <7vfwp9mt9k.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
 <7vd3kfusva.fsf@alter.siamese.dyndns.org>
 <453b72ab-40cc-431b-9865-3080c250a7dd-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 07:28:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDVO4-0008Qc-Mm
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 07:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab1DWF2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 01:28:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab1DWF2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 01:28:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDF5D3790;
	Sat, 23 Apr 2011 01:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vtCfpu3XUCujW4hiYJzqJMacP0Y=; b=r40uaZ
	9Z0JTQNdPql0tuopo2hW4sYIsr7M4gGOwg3/C2ltfxajtrCnalCMnw10g/agWy6h
	vmMC+8MFsudoVCICnuySBUjIi/IZzK1myg0dsVWFCygJlfYqRWtaRP+EwTpsAN0a
	m/ajEDrh4DfbKhLNoCPd3agEkQaSkhIPYBtsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RkRfT/PZtYEqc43TGwCgr8JElxw2I+fp
	SCadwkyFxiU+dUr5iibCq6ZxvlgmZsDESaoXGyc2PHWBlY3zkCqHzOpe81rVJDng
	Sh2pRJF7GfC/WCvOhzgNGOQSyT9hZ4faxMWrGuXYUij0cnKpN4XvNiSxL5rgKFVS
	TZdMpHLaQb8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC287378F;
	Sat, 23 Apr 2011 01:29:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0262378C; Sat, 23 Apr 2011
 01:29:53 -0400 (EDT)
In-Reply-To: <453b72ab-40cc-431b-9865-3080c250a7dd-mfwitten@gmail.com>
 (Michael Witten's message of "Sat, 23 Apr 2011 03:45:51 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9709EA0-6D6A-11E0-A766-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171953>

Michael Witten <mfwitten@gmail.com> writes:

> I'd like to clarify what you intend the new time zone option to be named; my
> patch series currently uses `--time-zone' (which is admittedly long), but it
> would appear here that you find `--zone' attractive.

Sorry, that was just me being sloppy, writing barely enough for you and
readers to be able to tell which one of the two options you used in your
patch is what I was referring to.

The word "zone" may mean something other than timezone in future versions
of git, and I do not want to see us regret this feature squatting on a
short and sweet "--zone" option if/when it happens.  Your "--time-zone"
(or a single-word "--timezone") would be far better.

The "--date={local,default,short,...}" option might want to have a longer
synonym "--date-format={...ditto...}", as some commands take the value of
the timestamp as a parameter to their "--date=" option, but that is minor
and definitely should not be part of this series.

Thanks.
