From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/3] rr/fmt-merge-msg replacement
Date: Wed, 25 Aug 2010 13:43:02 -0700
Message-ID: <7vhbiiqv8p.fsf@alter.siamese.dyndns.org>
References: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoMoZ-0005cB-0E
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab0HYUnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 16:43:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0HYUnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:43:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ADD0D0456;
	Wed, 25 Aug 2010 16:43:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzVe9YAoOEvpaVF9jikihF4w52I=; b=GrNxFP
	L1CnRxKy0IWGdcQSFMxkQaJ6pyfbmHHdOVmAGYAUxtXmKEL3hQz5CInIWiSEj262
	HX4KpSQ7ALyBkN4F7TfZicJFVtf8wPM/7uNgsasHXmyde/xNk7XKjRdA/CxrgIJu
	mDBi8zlFhu+qH3MkyIec1K+7kYsj5iWqByzro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xAg0/r2TfHGU2VitZgh+46ttO0sLSeno
	2vZK7OS6DCfL2ah3CfGGRZMUbrRk5HN7VmpsD78QofiFD61uI9ggqFmOLfOXdRSt
	E3Hepn+dyJGUYRkOKPtGncvi9jFMvDMo0rmiL4pgHey0TPl/qeurpvkUb9nsYgdE
	TSeYX3C03ew=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D95BD0451;
	Wed, 25 Aug 2010 16:43:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45A2CD0449; Wed, 25 Aug
 2010 16:43:04 -0400 (EDT)
In-Reply-To: <1282733330-32334-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed\, 25 Aug 2010 16\:18\:47 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E1BB7E0-B089-11DF-A2DF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154468>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This is a replacement for rr/fmt-merge-msg. It corrects the problems
> pointed out by Jonathan and adds one extra patch. Additionally, I've
> rebased it so there's no merge conflict when you merge it into `pu`
> (see: jn/merge-renormalize). 4/5 from v5 has been dropped.

Thanks, 

Just as a future reference, in a case like this that results in trivial
conflict, I'd prefer to see a patch that can be used independently from
other unrelated branches.

Maybe you'd want a new test or two in t6200?
