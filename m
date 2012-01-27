From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] svn-fe updates for master or next
Date: Fri, 27 Jan 2012 10:50:25 -0800
Message-ID: <7vy5styo7i.fsf@alter.siamese.dyndns.org>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
 <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
 <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
 <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
 <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
 <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
 <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
 <20120127001041.GB6158@burratino> <20120127003258.GA6946@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Scott Chacon <schacon@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 19:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqqsa-0005Qj-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 19:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab2A0Su2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 13:50:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab2A0Su1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 13:50:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2C5E7248;
	Fri, 27 Jan 2012 13:50:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sRHSHCwz4YSTId/odniDM/R/OO4=; b=DdbnAD
	rIPLwf0GdBULJVSriiJ3JV3Wvku8L0Na1smgMLs4evBMrql3fRLzOXOPQluPUJbX
	x3DdGZNMEEGesQ6cSe8lnue/INZ1hvv5p1jXvEV6MFhNDuUyaI/7krpqsQrll/an
	esxaETPKptS0y9AwfrwWn1mFbQTTiPRVK3J8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OUwTPTew/W4+AF65jnexYXr4K9AU7n9l
	qOazeQpRtHjCNucx8jStp2u831gJUjQmXkM0QoeW2s9uFPk1MAALF8kAlAhqu450
	JMYg2ngusELOBLJ2VeMeu4mMxlhyz965uAJJX1sLWH8i6woUlPu38OpUnHgMngVD
	F5dOgPrkAvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9E1F7247;
	Fri, 27 Jan 2012 13:50:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E35F7244; Fri, 27 Jan 2012
 13:50:26 -0500 (EST)
In-Reply-To: <20120127003258.GA6946@burratino> (Jonathan Nieder's message of
 "Thu, 26 Jan 2012 18:33:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6C1C4A6-4917-11E1-A0FF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189230>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  t/t0081-line-buffer.sh    |  106 +-------------

Curious; this series seem to be based on a codebase that is older than
6908e99 (Revert "t0081 (line-buffer): add buffering tests", 2011-03-30).

Not complaining, not asking any question. Just making an observation.
