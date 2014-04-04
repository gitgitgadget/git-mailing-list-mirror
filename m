From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch Series v3 for "use the $( ... ) construct for command substitution"
Date: Fri, 04 Apr 2014 12:27:48 -0700
Message-ID: <xmqqa9c0q4i3.fsf@gitster.dls.corp.google.com>
References: <CA+EOSBkF+hLOab0oJH7HuUb_KKn+1sgV_Lshwupgj-_yAAfmFw@mail.gmail.com>
	<20140404172946.GI6851@google.com> <vpqk3b56lik.fsf@anie.imag.fr>
	<20140404181215.GJ6851@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Elia Pinto <gitter.spiros@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 21:27:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW9mP-0004mo-0R
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 21:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbaDDT1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 15:27:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbaDDT1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 15:27:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E911D7A979;
	Fri,  4 Apr 2014 15:27:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JtygFOXbpJk66NJ2uKblIQPciZg=; b=cWDiDB
	xcFssqPwgxRVGGyq004ja+/RbO0EWjbX3dXOfOWBh3NE3ogEjqKXmBFfA+YTWGDp
	v51qY80GqOrN3MegD0IQMjhR3B4gdLOIge4hgZH3UVC789WY+qw33fxnak9AhWW0
	hUgYDsnZk02U1xxkyh8NvLXRPFxvYHf4+jNow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ln4MiY/F0UKgPaOTT24NQvrORsyUJuxy
	h9U4foP+OJZj3H8G5a/OUUOoqhldvYjAsPX4UB8alpuaVodHVEmIyzymzYixNT1A
	6sujsXmSP/+Q+2IqfnQI0FUVsH64UMvqrFQhwlA3KtzL2rwZ1RaLd96aYR2FMEH6
	X23lWRW6Q8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D04397A978;
	Fri,  4 Apr 2014 15:27:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 048007A971;
	Fri,  4 Apr 2014 15:27:49 -0400 (EDT)
In-Reply-To: <20140404181215.GJ6851@google.com> (Jonathan Nieder's message of
	"Fri, 4 Apr 2014 11:12:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 359E6794-BC2F-11E3-9130-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245771>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 140 patches worth of churn once every couple of years is not terrible,
> but I really don't want to see this becoming a pattern. :/

Likewise.

> And I don't see how the upside in this example warrants it.

Paraphrasing http://article.gmane.org/gmane.linux.kernel/943020

It'd be good if we don't _add_ such things to the tree.

But IMO it's such a minor thing that once it _is_ in the tree, it's
not really worth the patch noise to go and fix it up.
