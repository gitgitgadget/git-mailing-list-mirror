From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/3] diffstat: Use new diff.stat config values
Date: Mon, 29 Nov 2010 12:24:03 -0800
Message-ID: <7vzksr280s.fsf@alter.siamese.dyndns.org>
References: <4CF2EB05.5090300@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ruffalo <mmr15@case.edu>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAH1-0001ij-EJ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab0K2UYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:24:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0K2UYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:24:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 874CB378D;
	Mon, 29 Nov 2010 15:24:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ejJFsmBsoWfiZDS5CR6B+5CBtIY=; b=mC5Cm3ocAuQ36YbppI9kARs
	RGNo/fQMO4v/fvySaN2LxWhTLwtWqzOtYPByukMnmv6/+deJE1VLPd9MITMgXRt5
	E2f0ysZKRJUrBWKmX294D68qKMhjYtV1cmSkP4RDyFR+jp+aEl4Skqo15zqeYHGo
	3wZh8MYhZ9MAqf4W5isg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ioXWZ0ZQ/lWDZCEkSP+Evs1nmtiBFCZ/IYX3waSuBR7PdEVNv
	boX1xKF9XYMLMtN3+T6xrW0b+J1/tzBNI6H8+PUstVtUS4K1uy6aLjJNR5RDMajx
	pLy9yBd7NrrwZ2A5Dwjr6pHCu932EjHLySf5Ltoe+/YdJGEsABRl+jdcwA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 650B4378C;
	Mon, 29 Nov 2010 15:24:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 625F0378B; Mon, 29 Nov 2010
 15:24:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A89B499E-FBF6-11DF-8191-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162425>

Matthew Ruffalo <mmr15@case.edu> writes:

> From f3ca8d4222776fb38a2def4fb9c4691c09c1e0fd Mon Sep 17 00:00:00 2001
> From: Matthew Ruffalo <matthew.ruffalo@case.edu>
> Date: Sun, 28 Nov 2010 14:44:00 -0500
> Subject: [PATCH 2/3] diffstat: Use new diff.stat config values

Please drop these lines --- I can see them in the header of your e-mail.

> Previously, the diffstat width could only be specified with the
> command-line options '--width' and '--name-width'. This patch adds
> support for config file options 'diff.stat.width' and
> 'diff.stat.namewidth'.

In general, the second level in a three-level configuration variable name
is to choose which one of unbound set of things to set the value for, and
the last level of a configuration variable name is to name the specific
property to affect (e.g. "difftool.<tool>.path" "remote.<name>.url").

So this sounds more like "diffstat.width" and "diffstat.namewidth".  There
is no set of "<something>" that share "namewidth" property to warrant the
name "diff.<something>.namewidth".

The idea of the patch is good.  But the message is heavily whitespace
damaged and cannot be applied.  Please check the settings of your MUA.

Thanks.
