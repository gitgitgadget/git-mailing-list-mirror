From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Fri, 02 Mar 2012 08:45:35 -0800
Message-ID: <7vk433eyts.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino>
 <4F505F8C.70802@gmail.com> <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
 <4F50D6C6.3080909@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Vc1-0002tV-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 17:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296Ab2CBQpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 11:45:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964842Ab2CBQpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 11:45:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF2869D3;
	Fri,  2 Mar 2012 11:45:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uj9W2gMqkndqwkPlJYZ1ipazqks=; b=grs139
	OwAqL+HyeuGNJ5TtzDIdGTsricrojp7yrH9cqHYyAFGv6ReXHxoRTcbf/zq/KZSE
	Cjd6Zec6NG82gJEwdp3L1gmxp/duaPiFl2oGb2Jq9lXwYUengnorXVB0WB7tKyUL
	Pgq6kD+fM7eXgs/qYyT+vaE+Nos6MTzcMGMrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZGq/txacnHWaVY9yF8QoAHL/fMdmoUBR
	BzI4UUMolcJxAEz6Qw1tKT33Ddb8FyU38aQD2mdlAaKjkUpWiQaUhHDm9CdkAsaQ
	edM51+oXl2sOTZY90xygQJtPWIScyopBXuslS2AAIJMOpfX4lG0TmjajOjfm8WRZ
	8Rc6j7l3V0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1596F69D2;
	Fri,  2 Mar 2012 11:45:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9395669D1; Fri,  2 Mar 2012
 11:45:37 -0500 (EST)
In-Reply-To: <4F50D6C6.3080909@op5.se> (Andreas Ericsson's message of "Fri,
 02 Mar 2012 15:18:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 237BF402-6487-11E1-8C0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192049>

Andreas Ericsson <ae@op5.se> writes:

> On 03/02/2012 08:03 AM, Junio C Hamano wrote:
>
> ... a very concise and exact response.
>
>> In any case, any solution that demands more things to be done by people
>> near the core developers than they currently are already doing will make
>> things worse by exacerbating the problem that comes from a bottleneck in
>> the process.  I do not think your "The maintainer triages and assigns
>> issues to other developers" or "The assigned developer marks the issue as
>> 'done' after fixing it" will fly very well, regardless of the use of any
>> bug tracker.
>
> It works very well when there's the incentive of roof over one's head
> and food on one's table to take care of the assigned issues.

Your "this is a volunteer effort and assignment does not work like corp
environment" is valid, but I think it is missing the point.  A solution
that demands more from people who are already bottlenecks will not work
very well, even in a corporate environment where you have stronger
incentive to fill your assigned role.
