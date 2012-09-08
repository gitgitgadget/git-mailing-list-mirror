From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2012, #01; Tue, 4)
Date: Fri, 07 Sep 2012 17:38:43 -0700
Message-ID: <7vhar9uz58.fsf@alter.siamese.dyndns.org>
References: <7v1uih8jck.fsf@alter.siamese.dyndns.org>
 <20120907130813.GC25467@tommy-fedora.scientificnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch,
	ramsay@ramsay1.demon.co.uk, pclouds@gmail.com,
	robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 02:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA95H-0001mD-Rn
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 02:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab2IHAir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 20:38:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab2IHAiq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 20:38:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2423A978A;
	Fri,  7 Sep 2012 20:38:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DJIzcEJ3mZTIPzq127UBVG8I5Jk=; b=M0JIR5RZbYgOWFMKqdZj
	mRLxhFyF2Q8w6jRmMliNXZONAhoDUeKi5clwNkt/Chjx+Nh8Xae+/C7EvsCCM9vR
	ezHUhIeuuO+6svhls1wF10zhN1fJfC7Ve/tOtHE7dbZ+lO1WuI1lJgckUAG+FgSl
	jjgXvyyuxGvffYVbr6n/wqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=X+usm2IC3ldkJZCHW/JzWMTCM3In2a85Qte5CfLo9r/3ZX
	bsBEwZvKzApyRwaa9CK+V9iGSNRzmzl1C1QALHz0qCvXSZDBQV4siedEpoVmzOhW
	ldWxte+oomY5z/A4WzF2e5MwWJ/+7N6WEBFdP51X5useUHkdN3myKZicVdIFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 117669789;
	Fri,  7 Sep 2012 20:38:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FF079773; Fri,  7 Sep 2012
 20:38:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C073C88-F94D-11E1-A054-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205005>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 09/04, Junio C Hamano wrote:
>> * tg/index-v5 (2012-08-17) 13 commits
>> ...
>> A GSoC project.  Was waiting for comments from mentors and
>> stakeholders, but nothing seems to be happening, other than breakage
>> fixes on Cygwin.  May discard.
>
> I was planning on continuing to work on this topic as part of my Bachelor
> Thesis.  I had a brief discussion with Thomas Rast on IRC about this
> today.  Because I am planning to implement an api for partial loading
> we decided it's probably best to hold off until that's implemented,
> because parts of this series may change and it's going to take me a while
> to implement the api.

Sounds good.

> As for the actual look of the api, I think something along the lines of
> what was discussed at [1] would fit well.
>
> The commands would then learn to use this api. (First the commands that
> just read the index and later the commands that read and write the index,
> but for that the api will have to support writing the index)
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/198283/focus=198739 

Yeah, I think that one, even though it was a small set, would be a
good starting point. Looking forward to seeing this moving forward;
no need to rush.

Thanks.
