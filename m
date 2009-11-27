From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Fri, 27 Nov 2009 00:38:38 -0800
Message-ID: <7v3a40tl9t.fsf@alter.siamese.dyndns.org>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDwLu-00009N-Hp
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 09:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbZK0Iin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 03:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZK0Iin
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:38:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbZK0Iim (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 03:38:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79C3CA2188;
	Fri, 27 Nov 2009 03:38:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=F973r21KyE4SEOxAH3y7vMrqfL0=; b=khgN4IEHgqf39DSVwKUutcZ
	VY1wTi92JyKpiT+okTt/Re1rZF3Uk0uz76HbPKWNBSzvF5EjHY37hC5BckalLzV1
	LfTK1FnhSy9uIFFEoNJwi6cR02+su1V4Wi8v23n5iibgiyXgiLVqGefH4nsP8OVx
	VQ009dEebegiHYKLNlig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eEAYFblgzScqRNygvZ19iA9JM2gmYU8xP2mA5xU2CXZ3oMYlx
	P4NkX8aBqh1k2OjIDmis6ae2dNtX1QhVmrXsAcjhEeyyFReqGTIDkaoX7mnZbIHl
	1fyl+cEF56YSoJYME15/QfireKS1ZA8sjpLxTJ/ztebtFEOQ5o1TBeU05w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4AAE8A2182;
	Fri, 27 Nov 2009 03:38:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 24565A2180; Fri, 27 Nov 2009
 03:38:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45BD0282-DB30-11DE-A58B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133876>

I was slightly surprised that this seems to have differences other than
the flipping of the default color since the last one, especially after you
sounded like you would be sending with only that change.
