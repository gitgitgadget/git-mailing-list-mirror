From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fix "git diff --color-words -U0"
Date: Wed, 28 Oct 2009 11:14:09 -0700
Message-ID: <7v7hufo07i.fsf@alter.siamese.dyndns.org>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3D2P-0003Io-0u
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbZJ1SOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZJ1SOO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:14:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbZJ1SOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:14:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6EA9C8940A;
	Wed, 28 Oct 2009 14:14:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pfL6KkAANaKjiYgCUYZsru4GvCI=; b=tKGH1v
	SaF+dnDrUU6ZKaJ6R9qI1wRlvXjgtP77jxxZmLDEJzh+YDBxJmGsP+1pCVm06jCq
	tZZJ2iQizdOlHkDWTX+I7FizBbVG8OIE/ZAeKfzO11cbmCpzbW1IshI7A72k3bca
	chwOzoklhqHDTiYo2S1pdiVijmDgk7iyCPTu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Taa2/LtVQ9vmkNtR679SQlwvoaf6QQU8
	rd0fSjwT9AfXfSIgS25UJjmgcwOuf+nActUWSrPDw+P6cYyVsIqhfVsBAjd6MG7Y
	CxMK8Ho2mNKMaLP9+OKhCjfw+BhyGvjPboWpCb7vivoPn95M7ivDgVRjQIlYoq4N
	7IGbeHZzkxU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 425A789409;
	Wed, 28 Oct 2009 14:14:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DCEE389405; Wed, 28 Oct 2009
 14:14:10 -0400 (EDT)
In-Reply-To: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
 (Markus Heidelberg's message of "Wed\, 28 Oct 2009 13\:24\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B367D23A-C3ED-11DE-A530-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131492>

Is this a serious enough breakage that deserves to be fixed in the
maintenance track (1.6.5.X)?
