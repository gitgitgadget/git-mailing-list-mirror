From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] git-remote-mediawiki: don't split namespaces with
 spaces
Date: Mon, 16 Jul 2012 11:25:14 -0700
Message-ID: <7vvchn1s39.fsf@alter.siamese.dyndns.org>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342440053-3058-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqpz1-0007MJ-QC
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 20:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab2GPSZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 14:25:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab2GPSZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 14:25:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E89EC8C42;
	Mon, 16 Jul 2012 14:25:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wLT2Wl3dqR31V08yFeH3wlA8faM=; b=DFGLDXPhhnkWN2M1ldpU
	9d5muArzeejL4Eqm/evXYYs9GOZVNPA9zMleQOv72CM0osk2e9TimAyqTL6tVN0o
	Rdi8mrkqmsoyFeMjOFxsSlUooWG6ljFYSJUrg8WvMFhCQSNMCEKy+QcxZnmcGL33
	6QlapiPm/a+jOFFTd5/K1W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HfP8upHdhGBokiPXCuyXfUy71/sScQY+CKT+VS1Gg2JdaD
	9/ZaH/7HFvwGrRHE1TlaGXwkZSyJqg2SIRQ0DNhD+vcsPB8k/yaOMdp2JCm8aIKy
	hZbMGejue0k1/u9v6/khRriZzwoag3dVLeB/SAYFP9qnbwgtLv/hHef5YN898=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53E98C41;
	Mon, 16 Jul 2012 14:25:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57E288C40; Mon, 16 Jul 2012
 14:25:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9741CF86-CF73-11E1-B6F8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201542>

Looks sensible.
