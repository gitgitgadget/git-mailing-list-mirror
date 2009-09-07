From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-completion.bash: prevent 'git help' from
 searching for git repository
Date: Mon, 07 Sep 2009 12:15:54 -0700
Message-ID: <7vhbver2fp.fsf@alter.siamese.dyndns.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org>
 <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
 <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org>
 <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302>
 <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org>
 <alpine.DEB.1.00.0909041434310.4605@intel-tinevez-2-302>
 <20090904124904.22288.qmail@103db479e31ab7.315fe32.mid.smarden.org>
 <alpine.DEB.1.00.0909041452080.4605@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 07 21:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkjho-00089p-2t
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 21:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbZIGTQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbZIGTQF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 15:16:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbZIGTQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 15:16:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 892B723715;
	Mon,  7 Sep 2009 15:16:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2EDI2OYdcg/ppo9QFs53sCkLf5Y=; b=QsFs2L
	ypwg7Uu4ZexPGsQn3VrLxMRvGpz/5F4n0I0ro4+o60PSLFhIxyWXr2lMTS8THpAE
	iTSu/6VEoQ1STUwzm120WMVnDviCpTwgsiasjHaKqSnVNZkPT5OQfsY3AUnrtLqf
	E4YVJp305OyWXFusKrhKR9ZXlzXdaJRdjgPFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EZ9q/Sud7Hw9nO/hoLIEyERwo/TbB0Pm
	KKmo+4j2YEp67HuK9zKZpD4E+SOoQqod4VTNliQxcc0p8II4oWliRb2NCAJPNFFt
	DN5bpGAS8LT5MFV4yfvikf/mdDgL3dbbgQP8sQQrA3qCBRdpv1DD3fwmpx9PTQxQ
	yIX3LbR1wWo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CDDA23713;
	Mon,  7 Sep 2009 15:16:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8069223712; Mon,  7 Sep
 2009 15:15:56 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0909041452080.4605@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri\, 4 Sep 2009 14\:52\:45 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1E7FA64-9BE2-11DE-956F-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127942>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thanks.
>
> Junio, I am serious about this patch (i.e. it is meant for inclusion now).  
> Want me to resend?

Thanks.
