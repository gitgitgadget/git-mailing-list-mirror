From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit message parsing error in rebase
Date: Fri, 04 May 2012 12:39:01 -0700
Message-ID: <7vhavvag8a.fsf@alter.siamese.dyndns.org>
References: <CAA-jfp=F7ije9nFJio5gnmNGptDR1ZTBbCi-aOv7JokqrXBgYA@mail.gmail.com>
 <7vlil7ah5w.fsf@alter.siamese.dyndns.org>
 <CAA-jfp=yMVFrfFgh9A_zNC5nG8PTvNWBRpkbpbVK+7GUU7jO9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba@lowlife.hu>
X-From: git-owner@vger.kernel.org Fri May 04 21:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOLQ-0007Ux-PX
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759538Ab2EDTjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:39:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759340Ab2EDTjF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:39:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 881707D24;
	Fri,  4 May 2012 15:39:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WMhCGxHN+zXMDGqSPXPGTKWpORo=; b=Kx+SCS
	FwcB3ddgvln36t8bbzm2LlVkOiooB9DvQMkqHbNzUqNYnnk1KJPbPG1CSl9fU+vT
	j8c/+4OKjnu47M0qBxbHCvEoydadG5o4X3/ws491gQ0SJRcxt4ZS8gK4Y7YwRjhf
	cUPbWjX/TR4h5rL5WKnQnxfRq073HNwcCWx2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQosDsWKk8GvWJMxQoKHIkGjhwea30aJ
	wbBE5d0KlVziT9q8ZWzddKd+P7j4BM1Ne0KVLLWZJgbEN+Yg3lzuP/4+ahhI0yvf
	W/RvXymglMgkanzk0SyPyBlX4tiwO3jdxGKr19aOIXOJuLzvHJYY674KZd8okL9/
	iq9k2nnhuFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EDAF7D23;
	Fri,  4 May 2012 15:39:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B7BA7D20; Fri,  4 May 2012
 15:39:03 -0400 (EDT)
In-Reply-To: <CAA-jfp=yMVFrfFgh9A_zNC5nG8PTvNWBRpkbpbVK+7GUU7jO9Q@mail.gmail.com> (Csaba
 Henk's message of "Sat, 5 May 2012 00:54:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CDA73D22-9620-11E1-A09C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197059>

Csaba Henk <csaba@lowlife.hu> writes:

> In that case, would it not be wise to be explicit about that and warn
> or err if such a commit is attempted?

I could see warning (but not erroring out or requiring -f) may work well.
