From: Junio C Hamano <gitster@pobox.com>
Subject: Tonight's pushout
Date: Tue, 07 Dec 2010 18:24:06 -0800
Message-ID: <7v8w01m27t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 03:24:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ9i8-0002g0-P7
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 03:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab0LHCYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 21:24:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab0LHCYq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 21:24:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59C582C28;
	Tue,  7 Dec 2010 21:25:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=hVWm
	qftNYPhoJgwDwVcx4hXRSXA=; b=uxECVcoF8jkFYZFlB4uI1iUYWwWb01H2KglP
	XV1sZ2u9gWJRmEw4zBesN8qwhW7sOWovj94qEABD1Hu+XH13brWUEjYzQ3T6mW71
	YeX4LYx8WjDQhYU/zzr0FUnnvfTtgFOOZNC2APwF4IMda0IRsf2wbevwaRzLm0kM
	D3Ss8BY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=OBf
	x4rCE7zd6Es3W4uxaY3Ov/daT57qJtKjV6T6QLm9QmXpmKcPUCbKCHvfku59ITZ3
	A2T9V5pNBJvDT2EKXz3gwNydNl+G1NnwYJWwKlwlZiSpE1sIuI1jMUdEoFX6DQRu
	f6/iJezPEnGRjBt7sVjD7ldCCfHLKM5RGpsM0D1U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 479F72C26;
	Tue,  7 Dec 2010 21:25:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B52B62C14; Tue,  7 Dec 2010
 21:24:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EE5EB6A-0272-11E0-93C8-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163161>

All four main integration branches in tonight's pushout will pass tests if
you drop three-tip commits from 'pu'.  That might be just showing that
there are some caps in the tests, but I am somewhat happier than usual.

Tomorrow, I hopefully will start moving stuff out of 'next' to 'master',
and 'pu' to 'next', in preparation for 1.7.4 prerelease freeze.
