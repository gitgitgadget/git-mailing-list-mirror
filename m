From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: a lone "-h" is asking for help
Date: Fri, 16 Sep 2011 12:35:47 -0700
Message-ID: <7vehzgfffw.fsf@alter.siamese.dyndns.org>
References: <7vobykfj7g.fsf@alter.siamese.dyndns.org>
 <CAGdFq_h474OrLzP+CHj_eSdSp53n8x7jz1ORT16dOhvRdQMP+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 21:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4eCZ-0001dp-Bp
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 21:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab1IPTfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 15:35:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab1IPTfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 15:35:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3587547D0;
	Fri, 16 Sep 2011 15:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FcbuvTMPEtFYyUI/LgI11ayZgT0=; b=WTHfV9
	AD+KqlpQbO6Um6PICnJTUc0LEqyfb9ahmVVUCSgbB1SMAzmb+tlc40LNlW/c4Dfg
	L1xt1OjdQQiYioYHQYgYLbOcl/RAj8kCC5NplV5TB42aGsH2W36uFP0HOpLuQil4
	pYeA1P6ycXPeS52uTHsTCFY02OpFbH7Pi4qNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2j9fJ35pOtxWGIjzT/IumOIWVf4E9nh
	BKpDK/rEMiEVoSUuSP8V+s2zm41jW1P6Edw3ER87XPMZtLayJTspfk4VXcDchpsK
	ESbXU8PPbYMVxDjHOZGEzXBj+Z891CwQ2AS+WFrDmHDuCh8xLlqxqq6v4/mtz8hc
	JO0CjqBOZ4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DA3747CF;
	Fri, 16 Sep 2011 15:35:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B420447CE; Fri, 16 Sep 2011
 15:35:48 -0400 (EDT)
In-Reply-To: <CAGdFq_h474OrLzP+CHj_eSdSp53n8x7jz1ORT16dOhvRdQMP+g@mail.gmail.com> (Sverre
 Rabbelier's message of "Fri, 16 Sep 2011 21:09:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 145FB38E-E09B-11E0-BC1B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181546>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Should we really have "-h" as a short for anything other than "--help"
> in the first place?

You have been here long enough to know the answer to that question, no?

The answer would be different if you are starting a new project from
scratch and if you are talking about a project with existing userbase.
