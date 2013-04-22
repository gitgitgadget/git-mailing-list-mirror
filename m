From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Mon, 22 Apr 2013 13:43:53 -0700
Message-ID: <1366663435-13598-1-git-send-email-gitster@pobox.com>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 22:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUNan-0002KJ-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab3DVUoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:44:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852Ab3DVUn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 16:43:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78DFA18182;
	Mon, 22 Apr 2013 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ccKO
	abJPAMTQj84n0/Pzlsh6Iuc=; b=xy32qFxLDT7bp3i1oGvnm0o94i+uCMonSJtk
	jDMk3Et/tp+VGvkmPoGDcxJ51f8n/+TmiVrkfCM6vx+CYW4Hw0ZncAh9mfNBmIQj
	qnlVTmE5A24hz5DPG6DYYhoCyHhCHKblu4FkWrWv70kXi+qOX7LP51RxOAbp9/l5
	VK+1xiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	W9GiTslaqS1OJL5JiK1EPIZ5J5YhDFw1ny6OQXy92p15uxVO8MDI8JfN54DTGRgQ
	SmOdO3C1To0h5DdTIDKNUz6oD7J1rbGSM2HOp0wuUvJ0AokCMYT6i2WiZjB1C4wW
	qRi/jjEJjZ61CuksvHcXcUYD07neNylS4oP+7wThC1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F8A718181;
	Mon, 22 Apr 2013 20:43:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E697C1817D;
	Mon, 22 Apr 2013 20:43:56 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-683-g39c426e
In-Reply-To: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 5A604C2C-AB8D-11E2-8C8C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222087>

Applying Jonathan's idea on top of the early part that has graduated
to 'master', here is to add "--ignore-removal" (which is a more
natural way to say "--no-all") and use it in the warning message.

Junio C Hamano (2):
  git add: --ignore-removal is a better named --no-all
  git add: rephrase -A/--no-all warning

 Documentation/git-add.txt | 10 ++++++----
 builtin/add.c             | 23 +++++++++++++++++------
 2 files changed, 23 insertions(+), 10 deletions(-)

-- 
1.8.2.1-683-g39c426e
