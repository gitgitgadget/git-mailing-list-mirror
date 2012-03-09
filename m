From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 01:50:32 -0800
Message-ID: <7vboo685nb.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
 <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
 <vpqfwdjas0m.fsf@bauges.imag.fr>
 <20120309033826.GA6164@sigill.intra.peff.net>
 <7vsjhi9wku.fsf@alter.siamese.dyndns.org>
 <7vobs69vwj.fsf@alter.siamese.dyndns.org>
 <CANgJU+WMxnNgdsP4JV6aAVW07NeWXUa5LsEa4dk5_1CZXC1nXA@mail.gmail.com>
 <87aa3qi2i7.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:50:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wTA-00052S-BP
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab2CIJuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 04:50:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab2CIJue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 04:50:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C89B51C5;
	Fri,  9 Mar 2012 04:50:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=279hrANYQhekEG6yQpwfVzNeQ9I=; b=aQK52XV4YR3BmGy56qGh
	X2M9LAB7rbIG5tcjtHOYram2nEQD3p8Ddl1IODNl3XYvTcBzN/jUhCUxVB+Ot+f+
	xE99+lOwmZuw4cd2WgRxSTeOFp2HHt9hxvG96LbtyRhx8yD6GkRUogFHZb7Qb1M3
	WPFbqM/w3ulXtODC2DpmsfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QoyXd4PZ/zYtUm5i8o2RFnts9gf+GRMWcVzQxaDLTR4QwL
	8cLauvC17kcLCu6/WkuzZeEFPjgFwlb8AwyT3JpneU7QWdS5hspcFhHqMVbizdEt
	l7YC3KB4m5IgIHIiiKy/P97IQfg5XuSHyoZE1mePoP141mpa8iifbHmdpyylI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 032E951C4;
	Fri,  9 Mar 2012 04:50:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8771151C3; Fri,  9 Mar 2012
 04:50:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50663EB4-69CD-11E1-907A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192703>

Thomas Rast <trast@inf.ethz.ch> writes:

> This would be a brilliant way to confuse the hell out of existing users:
> suddenly the apparent "defaults"[1] now change *between repositories*
> depending on when they were created.
>
> In short, oh please god no.

Amen ;-)
