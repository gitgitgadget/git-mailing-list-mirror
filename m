From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: more graceful handling of invalid commands
Date: Wed, 28 Oct 2009 00:18:11 -0700
Message-ID: <7vmy3ct2a4.fsf@alter.siamese.dyndns.org>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
 <20091027133932.60b996c3@perceptron>
 <200910271521.09164.trast@student.ethz.ch>
 <20091027155814.0de65db5@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32ng-0007yl-OT
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbZJ1HSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbZJ1HSV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbZJ1HSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1291F881E4;
	Wed, 28 Oct 2009 03:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=AaQSoQTzqBfpMJwkWPT0EPc
	yf3tr2xNQAb0JflQZ8+2KOcBTCOJLYWCvYRETGPWy/4K9UzRBLkzyuzyHr7rx5+v
	SFYwRRvPY5wv7+jHe+XJ/euBcEpMyuD8600RNwmR64CmtrEikPJ/M51adPTj0Rnx
	eePlHjUyQwbZqz6XsUF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OTmMMamXCFrHhYQSVCoMvV9bAQ7SK2s5MZ1sQ2tkOt7vYrwHP
	heCmFd9c/gJ15SjLjX1XVzi4PVbILSoC3QOWbtAbIgDrQw35Ilyonnf55JvwQekZ
	3k2PW8g1NUOKDoi6fPBl1BnH360M3dGv1vo8005kzszZPekqIe6+GRF1yw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0699881E2;
	Wed, 28 Oct 2009 03:18:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B282C881DD; Wed, 28 Oct 2009
 03:18:12 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 124E33F4-C392-11DE-897B-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131418>

Thanks.
