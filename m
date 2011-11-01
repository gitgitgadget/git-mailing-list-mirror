From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Mon, 31 Oct 2011 20:30:23 -0700
Message-ID: <7vd3dco6y8.fsf@alter.siamese.dyndns.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
 <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1110311908240.1930@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	kusmabite@gmail.com, ramsay@ramsay1.demon.co.uk,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 01 04:30:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL53a-0007nE-8g
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 04:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782Ab1KADa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 23:30:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511Ab1KADa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 23:30:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEDB36566;
	Mon, 31 Oct 2011 23:30:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dojqScV7IDZrwRYr839kS2FcBD8=; b=q0ism/
	yQ03nNTfZXs3FJlFlc3EHwxSWn/u92br16MOKNQ4TiSDjh1LYHZ7rTo8Hr3Izooo
	rhoto6nsBE8WLrkasyecy9JQJRXLleIgM64fL1H0HJF1m/G+UJPmzDCPi9RXZIIV
	Ofw+QOye3xXgY1to40Hc0qvx/T220Dnt+ITrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RtnPStptkt+RH1LSIu7J5pA2IFpHyrS9
	0Yt4juRh2GyrCXlEcW3p5DWGxxo0eH64VLPTesc9l3TfnVNxyoNWYBMaead41V9y
	AQXlfjOyvODJohN7VYphag36tp69JPT5NEC5zXR3BZQBe5dsA3o7fwmSIbY+Gzc3
	ymDI+AeDD/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C8D6565;
	Mon, 31 Oct 2011 23:30:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64A5D6563; Mon, 31 Oct 2011
 23:30:25 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1110311908240.1930@bonsai2> (Johannes
 Schindelin's message of "Mon, 31 Oct 2011 19:09:27 -0500 (CDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6625D8A-0439-11E1-8E36-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184552>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As my virtual machine still ran the test suite after my latest rebasing 
> merge when I left work, I could not test the MSVC stuff just yet. I wanted 
> to do that tomorrow and either merge or come back with suggestions.

Thanks.
