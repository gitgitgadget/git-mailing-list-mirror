From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 01 Mar 2012 20:21:53 -0800
Message-ID: <7vty27k4ym.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:22:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3K0I-0002qf-0j
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 05:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab2CBEV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 23:21:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab2CBEV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 23:21:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 057777D24;
	Thu,  1 Mar 2012 23:21:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kwhWQgDLp+8jFRbHHe4cvJXzZ08=; b=mv/IZR
	9gEPq7Ljwd7A4IncaB6e6cXqeW2CxCxSuwTf2Qsqysp1pKTm/GLYNhuOnjlLVoiq
	Duji9OpSflrE8c4lQD8DTYty2IE6OoSsvfv8wSnyroIgEXrCQ2N/9bXPNsWkFxYx
	ieFpejE31M2xKUeMCIVnPJpBplg1r8Wr/rcT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljWAB518rXGp5a/qTBneM/5+MaYOhoLD
	Qgchk3z+Gp1gstP1tIZ01TyX8/oSZzWAz0mXnm/1020YmR/YjUsZ/wZl0GL4iZET
	v854KBavAKM3iTETQjZVL048HdWJ+F6KqxTY3KB6+XYaIvWtxCnD7S/d2pjfyaHQ
	AVQ6G7hWGGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F05D37D23;
	Thu,  1 Mar 2012 23:21:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BCCB7D22; Thu,  1 Mar 2012
 23:21:55 -0500 (EST)
In-Reply-To: <20120302041924.GG5248@burratino> (Jonathan Nieder's message of
 "Thu, 1 Mar 2012 22:19:24 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E9CAFBE-641F-11E1-B315-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191999>

Jonathan Nieder <jrnieder@gmail.com> writes:

> That said, a good distributed bugtracker (which implies solving hard
> social problems like "what to do if different contributors disagree on
> severity" and simple technical problems like "how to present a
> coherent conversation based on threads by people who might not have
> been aware of each other") would be a very nice thing to see,
> regardless of the choice of storage and network protocol used to back
> it.

Exactly. In the discussion of the "tracker" context, the choice of storage
medium is secondary.
