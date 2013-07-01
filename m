From: Junio C Hamano <gitster@pobox.com>
Subject: repo.or.cz being not well???
Date: Mon, 01 Jul 2013 15:16:05 -0700
Message-ID: <7vli5q9ba2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: admin@repo.or.cz
X-From: git-owner@vger.kernel.org Tue Jul 02 00:16:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmOM-0008RQ-3S
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727Ab3GAWQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:16:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553Ab3GAWQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:16:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D22102D562;
	Mon,  1 Jul 2013 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	8X0r7khyDV2egXnNMChgzGPapk=; b=kIzK1lYm3xXxlLDj3OzLNFwIAXbsWeZXL
	0GSLNhlLGdFPxmHhph2+EtTUHwmE8IdULMuDDRwuuA80WMaIAC6goNuNhE/mjapb
	WELK9jFJFeTYyp24kHPHY+NvcWIPYpnUVfktwZge2+k4sjPk8V/GEsnc/+ceK6rE
	ZjHVQ16UwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=CjDSJ1C2VNvuLPam75rfKX6XsRPoza4XqvRFnM12FnSnHYxD3E7LfvuM
	aYFe1DtP9cmuKXsF6TGqN6k0o2251w9HRSS3i0sYcm2MBzdRK6nWaE7wvfEdkJ6W
	b9eKuZh1YRymriTqhYE154y6BxPJmxIqO4YWHyWW2VZVw62cWwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C91562D561;
	Mon,  1 Jul 2013 22:16:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CA452D55A;
	Mon,  1 Jul 2013 22:16:07 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3A62A26-E29B-11E2-990B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229340>

Has something changed recently at repo.or.cz, accepting pushes over
ssh, in the past few days?  I am getting this:

    $ git push -n -v repo.or.cz:srv/git/alt-git.git/
    403 forbidden
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
