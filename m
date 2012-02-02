From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 02 Feb 2012 12:09:00 -0800
Message-ID: <7vr4yduher.fsf@alter.siamese.dyndns.org>
References: <jgdgcv$h8n$1@dough.gmane.org>
 <7vd39xy7it.fsf@alter.siamese.dyndns.org> <jgdjd1$5mn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "norbert.nemec" <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:09:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2xy-0007GA-MI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab2BBUJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:09:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869Ab2BBUJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:09:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C5C071C7;
	Thu,  2 Feb 2012 15:09:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TKn6GMq91zwZHKaJ/moSHw7raew=; b=Rdznls
	PVInCsl4hfeDCIFdgYvlSEuCw4kclr2RIYJvPdVEBw+1mHqi1MhrQkyrNSaX92F6
	Cg8JuL51MdJ2t6sQKc+MV3bH+HILQj1XYBdTig5KP+Sr5PebRkHaU41dkiLfCxO6
	wKToAwOScoma8rKDD9IwaoSCJ2mYL/L/RQ6sM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FGdRMV8ijX2nQ1xkYFj+jGSdgli90Bpc
	q9Zn1FVP1JcUqO8p9HnPtTqtvpJcMhnXu0sNkn/yAkyps0zp8/BfGgUYOx6xt3ah
	6L1iIEDF2sHRGfb4H794HtfeNZ+WGy64KAK3lTz/mlqby4HzPu/Cenpi2qN7XP2U
	PMx7wZYYfgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55AC371C4;
	Thu,  2 Feb 2012 15:09:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8BFD71C0; Thu,  2 Feb 2012
 15:09:01 -0500 (EST)
In-Reply-To: <jgdjd1$5mn$1@dough.gmane.org> (norbert nemec's message of "Thu,
 02 Feb 2012 10:01:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFC392BC-4DD9-11E1-9DAF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189692>

"norbert.nemec" <norbert.nemec@native-instruments.de> writes:

>> Bisect?
>
> This is not the point: My colleague knew exactly which commit
> contained the bugfix. The trouble was finding out why this bugfix
> disappeared even though everything indicated that it was cleanly
> merged into the current branch.

Then again "Bisect?"

I wasn't and I am not suggesting to use Bisect to find the original fix. I
was suggesting to use Bisect to find the _merge_ you were looking for.
