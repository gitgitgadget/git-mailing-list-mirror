From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Avoid spurious errors when rewriteRoot is used.
Date: Fri, 09 Oct 2009 13:44:47 -0700
Message-ID: <7vy6nks3eo.fsf@alter.siamese.dyndns.org>
References: <200910091101.04116.angavrilov@gmail.com>
 <20091009083444.GA31594@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Oct 09 22:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwMR2-0006uo-84
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 22:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761356AbZJIUpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 16:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759064AbZJIUpk
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 16:45:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758852AbZJIUpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 16:45:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 827B55253F;
	Fri,  9 Oct 2009 16:44:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pgGWPHzPfTSGYMis16NloC982Bo=; b=Gt5FEG9lY1EKeDgnDKSZSd9
	cfTOeVzlJtOfe25Y1SKmv/beawsd0Jia33YfFPxf/JxjegZHgCD7q1vcgkJ/xJQ4
	vGZ2P69LGaO3AYPHRG5G4zfRvDPeqUOYC2GHTt34CLeyCsWv/ZcX2dTLgAgotw6V
	JiJd6V9ypDEq8RANMN8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Lo4ichMJZ4oIVzccdMFzRVhdVz5nahDSVoxHXBsVIZF78FuIu
	lzSItxPOceIEXqQFefmFipt42h0bKvapv1FkzWfflnQnMdPuqg2UZN1NW98z6EnF
	ookTMK+a7vJOD4Nlvx25LBwtn75wO1UIRPSKMv2iXPt9pDwWpQUHWKUj/o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3C625253D;
	Fri,  9 Oct 2009 16:44:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 454275253B; Fri,  9 Oct
 2009 16:44:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 986E9776-B514-11DE-8B08-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129839>

Eric Wong <normalperson@yhbt.net> writes:

> Thanks Alexander,
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
> Fixed some line wrapping and pushed out to
>   git://git.bogomips.org/git-svn

Thanks.
