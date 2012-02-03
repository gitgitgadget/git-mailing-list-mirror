From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Thu, 02 Feb 2012 21:11:22 -0800
Message-ID: <7v1uqctsat.fsf@alter.siamese.dyndns.org>
References: <21056.1328185509@redhat.com>
 <9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com>
 <15281.1328207789@redhat.com>
 <CAD-XujkVK=tOtmVS90U0KAutFZ55jxsHMKuuMppXOi-H6ZY=RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Howells <dhowells@redhat.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
To: Valerie Aurora <valerie.aurora@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 06:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtBQr-0005Oj-Du
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 06:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758Ab2BCFL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 00:11:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab2BCFL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 00:11:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02859719E;
	Fri,  3 Feb 2012 00:11:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aVKveAKSPXbRgUANxVFVZU7mKIk=; b=jUOX64
	DPdyzOIwtElQjsW+5tonnuozCa+BoBJ4xxUFsZja5hk2kT894XesqtJrz7QUP3Zk
	i+9YGeIzYcHRR8PQVG+K7QDWu+DYaV6/MpA8UlKpy7H7b/dss3lVb1neIXfYHIMd
	+eXsSCTqGBZEbmn2o7WktJzg4poSWURA/I85Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O5dHkA6riCh6PuZ0bEcJhv8bvqNvaNZ2
	C8rKXsAumAJj8mWaS/N7ZM8Bt4+xp9I4X5nVhNmY+VLD1AxJV+23syn8kIIP8KbK
	Uhs0VBTzRs31O2JwqdnUHV3GpGYxATfuQnQS4RHzfPow0q9s4IAJ4yDprBHhgbSM
	ERZzsrkU8iM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76FB719D;
	Fri,  3 Feb 2012 00:11:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 996287198; Fri,  3 Feb 2012
 00:11:23 -0500 (EST)
In-Reply-To: <CAD-XujkVK=tOtmVS90U0KAutFZ55jxsHMKuuMppXOi-H6ZY=RQ@mail.gmail.com> (Valerie
 Aurora's message of "Thu, 2 Feb 2012 18:18:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8431284E-4E25-11E1-9434-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189738>

Valerie Aurora <valerie.aurora@gmail.com> writes:

> And Rusty's practice as of a year or two ago is for "minor mods" to a
> patch, to leave the authorship the same, and add a Signed-off-by:
>
> Signed-off-by: Some Upstream Author
> Signed-off-by: Maintainer or Merger (rewrote error handling)
>
> And for a complete (meaningful) rewrite such as David has done, he
> changes the commit authorship and adds a Signed-off-by for the
> original author.
>
> That's existing guidelines and practice.

All sounds very sensible.  Thanks for a summary.
