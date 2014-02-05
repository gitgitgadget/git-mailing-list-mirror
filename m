From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash completion patch
Date: Wed, 05 Feb 2014 10:47:36 -0800
Message-ID: <xmqq4n4d5rcn.fsf@gitster.dls.corp.google.com>
References: <CAHtLG6Qgxq84Eo__vaXw5RAmyRuPnK-pt6n36+cjT8nVnRQN=w@mail.gmail.com>
	<vpqk3d9o83t.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 05 19:47:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7Vl-0006Ao-RZ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 19:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbaBESrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 13:47:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaBESro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 13:47:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FEDC67F66;
	Wed,  5 Feb 2014 13:47:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ALOFzqVCEpWD
	b3RZDjpuPFlIA9g=; b=TnHwsXYBfNoCTS17cnw8qdEDOowwdnkDYqYr58QjA/wX
	/w24hrwBI9TfxeiNltAg7+Okv5VwMbFDFIrT0v/tIDuaL08PGcG5AxK6MNQ09nf+
	4fCoVjksyIvXxZh8/wJKN+680vUkX4ef3QaTRmfC158xUiR1hiJbpMvuEzfCkY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u1tNul
	Pze6pmzD0JsXf5z3lEcJypjWd3UUNFiumgfcsgO8MLXQM91178TNiY0dZOV64FJm
	0EdepWcno3Jmik9IMJnXBtOdixxO6U8fwIbt8znYDSE0ms8b3SVtfZLXryNFR88E
	feEA5htss3wkU51iNTZM8kPxR9MT2P4qQEtdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F038F67F65;
	Wed,  5 Feb 2014 13:47:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46CED67F5C;
	Wed,  5 Feb 2014 13:47:38 -0500 (EST)
In-Reply-To: <vpqk3d9o83t.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	05 Feb 2014 17:08:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FC27BC7A-8E95-11E3-86FC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241634>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>
>> add --recurse-submodules
>
> Thanks for the patch, but it cannot be included as-is.
>
> Please, read Documentation/SubmittingPatches in Git's source tree. In
> particular, the signed-off-by part. Also, don't use attachments to se=
nd
> you patches (git send-email can help) and don't forget to Cc Junio if
> you think your patch is ready for inclusion.

Heh, thanks.  Everybody seems to think anything they send out to the
list is ready for inclusion, so the last part may not be a piece of
advice that is practically very useful, though ;-)
