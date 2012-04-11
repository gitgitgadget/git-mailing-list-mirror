From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 11:51:43 -0700
Message-ID: <7vty0qje4g.fsf@alter.siamese.dyndns.org>
References: <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com>
 <20120411060357.GA15805@burratino> <4F85B4E7.7090603@gmail.com>
 <20120411172034.GE4248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2e4-0005GB-EX
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942Ab2DKSvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:51:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932939Ab2DKSvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:51:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 169746469;
	Wed, 11 Apr 2012 14:51:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fS+AXDoYs54L2HDKcjsGoj9y6Jk=; b=noSwcA
	G73knBZZXPDHlisgyUchyRi/ky1Vis/z+1pbwYXKqYHKXLxmf4zBqufIvrmKrxxX
	hcc+He/z9kwIOJh/90h4F6mwF7rktgUMyNRVXUJ6riGXuFVvog3abEMUDx9QSJui
	0m/vqgh2w4RnFTfsEkZrpj7JdVJH2/ADSV+/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TlS/zHbw8SKME4QlSw8MpiqMGs2CT2QB
	etDgGZbHSfRe8iSTB/2D/ZrDk6OM9isLv/fyGQlIEFYHwFcBwGi8mNZtGk0mO2+s
	pX5lnVs3ppSktjL6XCcnff2OVm9zdhgGbSFTSvKF3lDTjTHwNyXLr7LeZ9VtFZ6x
	uyz2yaUV3Dg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B52D6468;
	Wed, 11 Apr 2012 14:51:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97EC66467; Wed, 11 Apr 2012
 14:51:44 -0400 (EDT)
In-Reply-To: <20120411172034.GE4248@burratino> (Jonathan Nieder's message of
 "Wed, 11 Apr 2012 12:20:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6247EF3E-8407-11E1-A7A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195237>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Neal Kreitzinger wrote:
>
>>                              Graphics files for your app are
>> "source".  The binary is all you have.
>
> Often there is source in SVG or some other simple editable format that
> gets lossily compiled to PNG or JPEG compressed raster graphics.

You could have just underlined "if possible" part in your message and
ended this thread, that seems to be needlessly continuing.
