From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: always respect core.worktree if set
Date: Tue, 29 Dec 2009 08:58:17 -0800
Message-ID: <7v7hs5hg46.fsf@alter.siamese.dyndns.org>
References: <7viqbrv4pa.fsf@alter.siamese.dyndns.org>
 <1262072921-11280-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 17:58:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPfP1-0004af-Hq
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 17:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbZL2Q6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 11:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZL2Q6b
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 11:58:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbZL2Q6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 11:58:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC0AB8C52D;
	Tue, 29 Dec 2009 11:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0gd9hmrFP8obamLysQIzwqBkboU=; b=F7fYtgZ/bXuQr9FitBUbmHz
	tORcljqqxYwUnUX2I6t9UWEnipIZnGjwbmEpta6tbr5whF5UjK88zEOaDfmgCqWL
	4LwSaUso2PO6AS0TNtWLMcU0FqFMDOQz36HYEe7OTpvVRIkb5OiVbVfP38OKODf/
	P1iNL40b2qs7lb2ArWKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JHIwbmBlRWaGX8JvU2j936900J5S3YhV7uzVbcz7yuN6H+9Fc
	FeNKmuXnxFS85RWIMLw49YqXedVdnjNtK5z74L5Hx6G1oB2rm2IwGtTuDEtHMfr0
	2Mw9vaDFF1vKY1m1U00++Aa1KAEixJ3Q2d2Iux+A9tyKNtfrMrYyhZrdp0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD01B8C52C;
	Tue, 29 Dec 2009 11:58:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4A2E8C52B; Tue, 29 Dec
 2009 11:58:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60149EB8-F49B-11DE-95B9-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135810>

Thanks; I'll take this "match documentation to reality with caveats" patch
for now, but I personally think we should revisit the issue someday.
