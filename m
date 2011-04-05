From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git commit fails under some circumstances
Date: Tue, 05 Apr 2011 01:18:12 -0700
Message-ID: <7v8vvp5cxn.fsf@alter.siamese.dyndns.org>
References: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
 <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
 <1301991295.2320.11.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 10:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q71TK-0002jX-J6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 10:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab1DEISh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 04:18:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab1DEISf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 04:18:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12CB737C2;
	Tue,  5 Apr 2011 04:20:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nh1H0PfLoGv4T9th+Lszt8ySPAA=; b=iz2Td2
	s4OFx0s+oikvlRgC0QZtnm+Dih/erlMJK189my+2lpg8yMhIJIcHewQv3uTfieOG
	y6YJgtysd9oThZ40VMOYRVjFDvceMcwNX38VOnBGj786wlC281aIpHAYnJQwrWzR
	USM5AcIuOP2f8B9bRzmBOHs9uFwiQ1su8Bhd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IdTa+4GIEQuGEgz0UoIhlr8umEAeMQ7D
	8vPMeQc4/ih787YvH0JMzOQkSbPIjpSu7l2xXjjuguiuj8VXkJuyQ+3+vlsZiAwt
	gjjt7FjkKgMsyjZsKtBjaR2rjcrgNqTRqCBcUTNru76HTvb7BWJTNpqE77tQOpMs
	w8pMncoeNVY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D30B637C1;
	Tue,  5 Apr 2011 04:20:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B83A37BA; Tue,  5 Apr 2011
 04:20:06 -0400 (EDT)
In-Reply-To: <1301991295.2320.11.camel@wpalmer.simply-domain> (Will Palmer's
 message of "Tue, 05 Apr 2011 09:14:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B7B1BF8-5F5D-11E0-BA86-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170876>

Will Palmer <wmpalmer@gmail.com> writes:

> The alternative, "git add everything else, then use git diff --cached" I
> believe is unsuitable

It sounds as if you are looking for "git diff HEAD" to me...
