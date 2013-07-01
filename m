From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lib-rebase: use write_script
Date: Mon, 01 Jul 2013 09:56:43 -0700
Message-ID: <7vsizygqwk.fsf@alter.siamese.dyndns.org>
References: <1372357825-21824-1-git-send-email-andrew@pimlott.net>
	<7va9mbs8lw.fsf@alter.siamese.dyndns.org>
	<1372359086-sup-9704@pimlott.net>
	<7vvc4zqnve.fsf@alter.siamese.dyndns.org>
	<1372695617-sup-5251@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UthPI-0005ul-FR
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab3GAQ4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:56:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664Ab3GAQ4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:56:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 187572DA02;
	Mon,  1 Jul 2013 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZGNyFEK23bUHjXVmapOa5MeT+BQ=; b=uo6fc+
	XDCtbTAlFPjcg0Hp6YLP0y2owKvkQps186awUqdh1CBdehQWPpVxMm1duUWKl88V
	91zlCJ1J8uURWFTm/Lzaa2fll3u9hRfLnb0egjTnV3vm4/RPHuWE07IoNqHjzlSA
	lhhI3UpVBbb8lLKoypXMsDXzWT7zyr3Qd1Iss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5o1K2cJbliO778y0jLMxUkRBUIqIH73
	IzzKcOTBHLfg4WiqibMai3xmBaE4/M6czDhcVwPM9aYoHF8rh90wO2VQI4JKjJ40
	/4C3EYFQIAvmWO9tE6iZ6xXd4bWl9Z5xIA9AU5dKGV/tRu5OGMyDams1a/frjBU4
	Yk/I4zmf5s0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CA5D2DA01;
	Mon,  1 Jul 2013 16:56:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0B952D9FA;
	Mon,  1 Jul 2013 16:56:44 +0000 (UTC)
In-Reply-To: <1372695617-sup-5251@pimlott.net> (Andrew Pimlott's message of
	"Mon, 01 Jul 2013 09:23:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35EEFFB4-E26F-11E2-B429-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229313>

Andrew Pimlott <andrew@pimlott.net> writes:

> Applies on top of rebase -i patch already accepted.  Mostly whitespace
> changes.

Thanks, will queue.
