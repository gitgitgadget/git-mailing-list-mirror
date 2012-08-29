From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (minor concern) git using the pager should not be a default
Date: Wed, 29 Aug 2012 10:19:00 -0700
Message-ID: <7vligxwr97.fsf@alter.siamese.dyndns.org>
References: <503E3CFE.1080603@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Emmanuel Michon <emmanuel_michon@sigmadesigns.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 19:19:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6lv8-0002D2-4P
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 19:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab2H2RTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 13:19:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606Ab2H2RTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 13:19:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F9518760;
	Wed, 29 Aug 2012 13:19:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cUVPcZDFEK9fp9fPt7i26BPHwjA=; b=pf5Klo
	84qWru/mgpJxtu8HOb8qnrF4XjaLffUHA5TqSSOk6sjV81arwOdJJ9Yj+4bQiGWJ
	rzlgJszyE9ZkhcnrFNWWXFstrbD1Jh3sgLXneXWyLCX51T08yNgh2P7eMpSt7tER
	WhKGyY/C1H9P8vkAcS+XMcjRC5jjNcEk3BPEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TwJz6DLHek55lsGX/KPudQJoKvlepy2o
	dzzas3WSSk2osoSVvYjKmEz636IucJFD/g8zopeArYK/mCXuhc94dl06Fdim9edW
	5MEKz0Ef6RCzNOfHJ0pOR+9c4r2d8cvQNRRkfHGFAAS3JnDT2AUveqabEX9E+Ssn
	dak6Dm7tc7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D05C875D;
	Wed, 29 Aug 2012 13:19:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E29BF875C; Wed, 29 Aug 2012
 13:19:02 -0400 (EDT)
In-Reply-To: <503E3CFE.1080603@sigmadesigns.com> (Emmanuel Michon's message
 of "Wed, 29 Aug 2012 18:02:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A115068E-F1FD-11E1-9C38-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204487>

Emmanuel Michon <emmanuel_michon@sigmadesigns.com> writes:

> Isn't the design principle superior to the wishes of the masses?

Only when you are living an ideal fantasy land.
