From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Mon, 09 Dec 2013 13:00:25 -0800
Message-ID: <xmqq4n6hyc2e.fsf@gitster.dls.corp.google.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<52a2f27bfe07_29836d5e98f5@nysa.notmuch>
	<CAMP44s0sankG67rknVo=g5aOJXS_GZBh+hkr9cyVSiYrEvt83Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:00:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7wR-0003Q0-9d
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab3LIVAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:00:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753993Ab3LIVA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:00:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25BE059233;
	Mon,  9 Dec 2013 16:00:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LKDpbAkECBlshg5jQjIa83I7sto=; b=MrOFs89UhXtzCzzhQob0
	I0BodPDrHXQ7Xc6AqjWLxc0sHFxwj7VOUFvRUxjCRLf7LL/Cy2o83/Q3tk1ntB5D
	87EZUmPnEq5jQtTL1juGakWciIdFJJuT4/TtK6l6/HOMNzJ2RnOnH5MbbgtKYyK0
	d60KyPtb8a51YFarV6hCsyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TlDNPOz6XL9l5MPSgfyYTVmKJGggbcreBc/dfEwv6InK5/
	JjkqoOxOYHnAwAruArroI0EvfYYp8LFUwqmLy6nd+IDV72QkmznWQIeIUZyAMO9h
	2lMyiKKR1/wHUGajV0jo/2vGNZ2mt5hU8f0K8QXS1QWFUI/dG6+Ty9z/PmWu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1324059232;
	Mon,  9 Dec 2013 16:00:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C1FC59231;
	Mon,  9 Dec 2013 16:00:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE9F013E-6114-11E3-9D07-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239099>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> To take hostage the whole patch series because of the name
> --refspec (which is perfectly fine) is just an excuse to not fix
> the issues already present.

I actually was wondering why you are taking the fixes to the hostage
to force a wrong option name.
