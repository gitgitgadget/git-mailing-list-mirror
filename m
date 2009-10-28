From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help -a: do not unnecessarily look for a repository
Date: Wed, 28 Oct 2009 13:26:58 -0700
Message-ID: <7vskd3l0x9.fsf@alter.siamese.dyndns.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org>
 <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
 <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org>
 <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302>
 <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org>
 <20091027133040.28836.qmail@fe20635a713ff7.315fe32.mid.smarden.org>
 <7viqe0yrnu.fsf@alter.siamese.dyndns.org>
 <20091028093022.30253.qmail@d8110c1e8cdcdf.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 21:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3F70-0007Kc-61
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 21:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbZJ1U1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbZJ1U1G
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 16:27:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbZJ1U1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 16:27:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 500B78906F;
	Wed, 28 Oct 2009 16:27:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ctTPUWXF6BgR0iSw8l9pQc3
	eS7ylbis/bezOIx31llf47F+8EXWq4xvS7F7Pkw2haG1Iv2ZU0hR3svFYm57KT+K
	Lx5ZUOHVcqF6oUjMZkdDtnicPbnxJOEpiDNc7f6LdNtslrG+sPWVx0RUNIE8hNIV
	y4ygNIG1JA8YqVF17dP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ut+E6kp5jJQsyjzUKGycFVIUVylttfJEyl4BKA8yah4zoe7R3
	qejifvVAnGEixbEUsjFvi0HcufvZXZzI5cnX4wX5Fqm9kCXUv6nIybOLdWgqI5NW
	70yo3SB9IDy/Gj77HBP2Iuq1exwStHOACU8m9METFGEG1M1D/S1iPw2ppE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2060A8906B;
	Wed, 28 Oct 2009 16:27:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68F3D8906A; Wed, 28 Oct 2009
 16:27:00 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42687338-C400-11DE-9862-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131496>

Thanks.
