From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix overridable written with an extra 'e'
Date: Thu, 27 Aug 2009 21:53:37 -0700
Message-ID: <7v63c8a69a.fsf@alter.siamese.dyndns.org>
References: <20090828121849.6117@nanako3.lavabit.com>
 <20090828034305.GQ4297@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 06:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtTJ-00057A-OV
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 06:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbZH1Exs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbZH1Exs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:53:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbZH1Exr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:53:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53C5A1BB6F;
	Fri, 28 Aug 2009 00:53:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zrUTD+MrqFCeaNbKTT7HZgUZons=; b=ZMAP5Q
	WcEugcueMSb8I8tdjxaXSu4jG97uQmaWR1m+y07pY+lZv4lbXNdRP7NlED3CiIqx
	tfcVJQV+b+AIDcLqPPZG8q/DJkmPqZWh+XKZzMR19DWvn60MTHRcoKaRWdeB22WW
	BnIaNZkhQGIUT0/ogZxfk759UBm+HgCwG/C8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ut9fya88kLBVKvz41G0lgZc23XXiy3as
	44B3rXXVfufDNX5f8mGijfXRPHSJIWxPq/zRSB7br3DaZmVafQB/oCHDK1YDxkXs
	+mBZpcEoYZFRrh8FLEjabXEDa5gZA8qdTEpC3ZfsjHF/aHGRQvpPV1sR+zmyWion
	AmFDetPg7Pc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 283E41BB6A;
	Fri, 28 Aug 2009 00:53:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15CB91BB68; Fri, 28 Aug
 2009 00:53:38 -0400 (EDT)
In-Reply-To: <20090828034305.GQ4297@inocybe.localdomain> (Todd Zullinger's
 message of "Thu\, 27 Aug 2009 23\:43\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C370B8AC-938E-11DE-84AE-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127252>

Hmph, I don't know.  Googling "overrideable" suggests "Did you mean
overridable?" which is enough clue for me.
