From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 08:31:33 -0700
Message-ID: <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
References: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:32:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhTI-00066n-1P
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639Ab3CUPbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:31:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932210Ab3CUPbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B19F8ACDD;
	Thu, 21 Mar 2013 11:31:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N6FWW8DltGTXxAM4cRR9HF4otuk=; b=Oz8ANs
	G16b77RZ9OZXq34ME5TY/cP6Z3e2P7UgstTZsxsTBRZ806dOs2sHxlxNVA1C6fKp
	6ND42HKCZWigJcSahu+W7X8Sh5ZRKWupo2G1O9yonP4F02Hud7/5J3TlOXvjwqr4
	xjorbPebzgpWBtfP2G2+NhhW7/vsWCqX1FDO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQGMSxyPRV0XBoG4Ss/4XIy0NQyrSUrZ
	NRx5Yk0X+CajHRkIKGFwcVxm3Rtcy8R6j+qZ9bMesJocfGfeb19rDQ9m3xuRTJ9y
	gT7V1xuOB444oYX16JbBMyE9iTt/MfcXlo2ecvBzx8ugiJ9JNB7nk28bANoO/bn+
	CpApquoBf1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A76C0ACDC;
	Thu, 21 Mar 2013 11:31:35 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BD07ACDA; Thu, 21 Mar 2013
 11:31:35 -0400 (EDT)
In-Reply-To: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com> (Yann
 Droneaud's message of "Thu, 21 Mar 2013 14:45:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A31A50C-923C-11E2-889E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218736>

Yann Droneaud <ydroneaud@opteya.com> writes:

> The documentation is in AsciiDoc format: it should be written somewhere
> with links to AsciiDoc documentation so that it became easy to find
> how to write documentation for Git.

Certainly this does not deserve a *new* file to hold it.
Isn't this inferrable from the top-level INSTALL already?
