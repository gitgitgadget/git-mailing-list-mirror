From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 17:25:46 -0700
Message-ID: <7vwr6e3ilx.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org>
 <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org>
 <7v62e09sig.fsf@alter.siamese.dyndns.org> <4F67B78B.6080208@pileofstuff.org>
 <7vsjh48af1.fsf@alter.siamese.dyndns.org> <4F68F4A3.60506@pileofstuff.org>
 <7vhaxi50q8.fsf@alter.siamese.dyndns.org> <4F6915A8.9040009@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 01:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA9Nh-0002o2-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 01:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab2CUAZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 20:25:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab2CUAZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 20:25:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D475366F1;
	Tue, 20 Mar 2012 20:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4AgTuTUOOvkNoZyG04N53U/nW7c=; b=iCJXpy
	VEYVhWXTlyryxxbQakwcZK4nBnIKs+NzQgne2dYgN7qstz+cX6SXWSLBsAWlDNgT
	LY1h2CGeqyJhUxrM0+Qg19DzH8sfpJdSG7cRJ9XwK1VNLjsjgyU0tbZx0QL92slt
	VRoSWhM30aMpjyDJclHW7XSj/EXBSOqDmP5gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OL02kePzX3tgzTe0ymPq6+A2K/jVA4VA
	A13KDOil+cCuv92wUVjl400IgfvaXDMhAQ8emXzrT2C+UHOsuR6gZgU147Fup/vA
	XdSOgP3UFpH1kwW2fxtergmIm426faU6VuabWP9a3xlhinWeSoCfVWvbROHTYzwP
	WFi0mPcXKkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC74166F0;
	Tue, 20 Mar 2012 20:25:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E88E66EE; Tue, 20 Mar 2012
 20:25:48 -0400 (EDT)
In-Reply-To: <4F6915A8.9040009@pileofstuff.org> (Andrew Sayers's message of
 "Tue, 20 Mar 2012 23:41:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 682107AA-72EC-11E1-8BD8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193555>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> It sounds like we're disagreeing, but I can't tell what about.

You are trying to read me too deeply, when there is nothing that deep to
read, by for example assuming the s/n ratio is why we want to keep the
warning only for a while and then eventually removing.
