From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7508: add a test for "git status" in a read-only
 repository
Date: Mon, 05 Apr 2010 23:20:07 -0700
Message-ID: <7vochxje5k.fsf@alter.siamese.dyndns.org>
References: <7v1vex9mur.fsf@alter.siamese.dyndns.org>
 <1270289517-32680-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 06 08:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz29D-0005uU-7C
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 08:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab0DFGUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 02:20:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab0DFGUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 02:20:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2809A805C;
	Tue,  6 Apr 2010 02:20:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Vnoq6AX+UK3brAt5K4yXZidwzmk=; b=CBK4dFUSkcWV0ibmDl65ML8
	q+Idr3cpBaQ1cGi17wlZYWLSOiAFWDHtvvgLpxiez/MJq0mIJQnAkXOBHatMMHay
	qxS5ACCgV9JsJRyQoBGGV721Yn55OY2emADSf55YNefVSqs0pO/4LBlERC22n4mo
	H6QPyiMabMJD+Ihl+XTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dGfkAzeBmPlSl2RyFAd6mJR+LaGSSQmTO8opH5VlrrViFMZfn
	JunxAnuq7COEs+RADoJVWfVoYlhhtDiEYuW2Dw6jwbxl5nG0mQ64GL9DuwO8GY6I
	XmytbUZNuNqT3uMwdJffLcDxGp2UkT2AhtS4Op17oEAA2DtvYekYzIjl8U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C08E2A8058;
	Tue,  6 Apr 2010 02:20:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DDE0A8057; Tue,  6 Apr
 2010 02:20:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74CD3BDA-4144-11DF-816A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144105>

Thanks, will queue with a minor tweak.
