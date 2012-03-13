From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Introduce diff.algorithm variable
Date: Tue, 13 Mar 2012 10:46:46 -0700
Message-ID: <7v399cxuk9.fsf@alter.siamese.dyndns.org>
References: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
 <CALUzUxpR_bPLvnHRJrQ2wVpqJD6Ccg6r3RMa_sCDKHTapnJsdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org,
	trast@student.ethz.ch, peff@peff.net, Lawrence.Holding@cubic.com
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 18:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7VoE-0000Fs-HA
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021Ab2CMRqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 13:46:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758945Ab2CMRqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 13:46:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC3E37FA2;
	Tue, 13 Mar 2012 13:46:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zQXX9Fr3+PnGX7YCDBm5LUT6b+A=; b=P7sKcO
	tfitpBWqjULKGFBrzohaoZjC37GE4Z1nn2AHzZmh8K+qH92uJEbTs2Z6jdCqqpdH
	yM31ryqHw9Tzejx7aNEo5OU8HMbY4PZFAPLjHvG81ks/+12a3ojGLzrQwtRMRX/+
	TztkRFofXk/bRdDCBtosTu14T7XHKAhhlW7Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KyfquH8K4EYAC2Z212L4I6kNGGTRFTG/
	2Mz1KE1hTU+Egi2bgubn3YlFnc04slrDGd/D8Wbv45xAdIqXLGmirP7H7THgR924
	w8xuj+j6uejx02xH7JMuGu1PxMRicXmeWQYa3NY8NVSFl22oquwK/BdIABO2g0uV
	isI1fhXEayI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2F757FA1;
	Tue, 13 Mar 2012 13:46:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31E6A7FA0; Tue, 13 Mar 2012
 13:46:48 -0400 (EDT)
In-Reply-To: <CALUzUxpR_bPLvnHRJrQ2wVpqJD6Ccg6r3RMa_sCDKHTapnJsdw@mail.gmail.com> (Tay Ray
 Chuan's message of "Tue, 13 Mar 2012 22:42:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81DF6690-6D34-11E1-9BEC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193043>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Considering that --minimal isn't really an algorithm,...

I think this discussion thread already settled that "minimal" *is* an
algorithm for the purpose of this topic, considering that the --minimal
option does not apply anything but myers.
