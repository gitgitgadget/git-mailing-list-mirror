From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Add translation ("yes","no","ask")
Date: Mon, 22 Jul 2013 15:31:31 -0700
Message-ID: <7vzjte9qgs.fsf@alter.siamese.dyndns.org>
References: <CAPM==H+bXd8HNEd6u4C0nhGyM76q9aH258vokPUJQJm1jVGSiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yamada Saburo <devil.tamachan@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Odm-0005rw-0m
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab3GVWbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:31:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab3GVWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:31:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BAE1270E6;
	Mon, 22 Jul 2013 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=1sDI7sADWIK3va5g20qoOnnvU6I=; b=LLOyl5avK6Es2p8cy4cN
	X11/X0RSRBckJRx5plSaC9yPO+4s9svF2IApkUeEShsVyHWGBpeQWHqj7UKFOeju
	jDhZnjthNhrTVOLEZAbbl3DvNQ5nB9XUua/mEf4R8wIHCb4Sp5+mzcu1LFBdaLp6
	4wpeUd5tdcPedmhAXGH0coE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IlH6Urn4mGqgrtTxATD7TsgNZZ8YYv3fBoyjEzwkqgxPXb
	KFl7RpsRTi/EyVVvg5VrEsqlN7SA3MIA4HnkmK/I7byhDyoDyM0dRPt+KoDQxfdT
	zBQSaJqTBa64dLMuBwV1sE71ttSdB+K6cMeR+k5384j6HSvfrkTipbv4XJGcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32662270E5;
	Mon, 22 Jul 2013 22:31:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 912DE270E4;
	Mon, 22 Jul 2013 22:31:32 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75D54F06-F31E-11E2-8DF7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231005>

Yamada Saburo <devil.tamachan@gmail.com> writes:

> Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>

This looks good to me.

> ---
>  lib/option.tcl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/option.tcl b/lib/option.tcl
> index 0cf1da1..7af858c 100644
> --- a/lib/option.tcl
> +++ b/lib/option.tcl
> @@ -158,7 +158,7 @@ proc do_options {} {
>  		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
>  		{c gui.encoding {mc "Default File Contents Encoding"}}
>  		{b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
> -		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes"
> "no" "ask"}}
> +		{s gui.stageuntracked {mc "Staging of untracked files"} {list [mc
> "yes"] [mc "no"] [mc "ask"]}}
>  		} {
>  		set type [lindex $option 0]
>  		set name [lindex $option 1]
