From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add-interactive: handle deletion of empty files
Date: Wed, 28 Oct 2009 00:18:25 -0700
Message-ID: <7vbpjst29q.fsf@alter.siamese.dyndns.org>
References: <20091028005257.GA5002@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32np-00082Y-DB
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbZJ1HS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbZJ1HS2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbZJ1HS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6210B881ED;
	Wed, 28 Oct 2009 03:18:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=xAhwU718RvUVISKa1bRMtRJ
	6ShAlUYUBrKZ6Cg4VugjZ0KI2appwHYWRFF6XmQCtTxVmvypibcXgvAIs+xAi7xs
	mADSTQrLlpe4MKr7xKnTLehKFSkDbyXHHrU+7N9QIdGTXRi8MX7ju1EdkLuQ3jvp
	FakdC+xK0Sy5k/q+4tL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OL7GPp7aZ7moOQPaQ4XtIXe5mDxFXAhILXXDr56ma/Y8muKrl
	L41AiC8ly4tsoMyutJdExRT9w0OSp5wDo8qczTzIgHn87xA+HaAg+Y6Am+rY/DC9
	GD9nOMZZbuUY3hWsBJ3Oh1jgVgGFpLwseT5BgFDma3OB/za1l+GWa7FwF0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EAAE881E9;
	Wed, 28 Oct 2009 03:18:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D16E881E5; Wed, 28 Oct 2009
 03:18:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17F31888-C392-11DE-8794-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131420>

Thanks.
