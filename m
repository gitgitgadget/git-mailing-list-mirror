From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 03 Mar 2014 15:39:16 -0800
Message-ID: <xmqqfvmyn97f.fsf@gitster.dls.corp.google.com>
References: <CAPig+cRnfDta9FofgH2jSdivzKvJiHwnzPZ5PoO4UTpWQLSH4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Bobyr <ilya.bobir@gmail.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:39:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcSQ-0006Cu-5O
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbaCCXjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:39:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833AbaCCXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:39:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E843C5528A;
	Mon,  3 Mar 2014 18:39:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h/VuH5LvPTmkZg2pT9bqUe4X4qI=; b=WTKhZw
	1t54NhS2S2YFI/Z8wwW2FX76zJIqtOvk7ypECEuDQzbO4liY9YW6TT9DZvvKJv8W
	IW+gsW+nlXh0SXRwZcZs4vA+oBbXJtIdS5izW2adKHcTFF2VVtsVEZCyE5z7imer
	/ErkLWGgspadmO87AJCKcxozySmiLmUF03MJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuxzdVe0BatmaMwC4gKMzGOoKx37YnTp
	+cKVEDyfgNH4PTF+nmK8k86LuyaW5dvhxa4qCSOgS1cDOnkGS0oxo/35eBlDb71p
	rX1qy1Vu7KfPXf6V6/fUMGu2A2c/X07QYVkSTn4W+RfVS6At5hoaRU+ZDZyb/y4l
	aLnK+LpaW/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4DBF55287;
	Mon,  3 Mar 2014 18:39:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33C2B5527F;
	Mon,  3 Mar 2014 18:39:18 -0500 (EST)
In-Reply-To: <CAPig+cRnfDta9FofgH2jSdivzKvJiHwnzPZ5PoO4UTpWQLSH4w@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Mar 2014 18:18:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 09A9D4FE-A32D-11E3-AF3B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243312>

Eric Sunshine <sunshine@sunshineco.com> writes:

> That new message in patch #2 says "not in GIT_TEST_ONLY", but isn't
> "(excluded)" also applicable to that case? Is it important to be able
> to distinguish between the two "excluded" reasons?

An obvious solution is not to *have* two reasons in the first place
;-)
