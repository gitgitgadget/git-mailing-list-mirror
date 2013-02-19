From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 08:29:55 -0800
Message-ID: <7vtxp86zcs.fsf@alter.siamese.dyndns.org>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <7vip5p9rtm.fsf@alter.siamese.dyndns.org>
 <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
 <20130219072512.GI19757@elie.Belkin>
 <CALkWK0nnkfrHi-0=c-bXdBHaOeBsCdccZDJZX5LDs0dT=SsReg@mail.gmail.com>
 <874nh8vgoo.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	"Pat Thoyts" <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7q5H-00073r-12
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 17:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758571Ab3BSQ37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 11:29:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758451Ab3BSQ36 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 11:29:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC4BCB707;
	Tue, 19 Feb 2013 11:29:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1YKLx5sjBSDaXJ9ivblEOK/V7M4=; b=KhY8k9
	VJKzP+7nnXvGMmq0+Ac9ByL+f/XeOxMeUzN/QRe0TM2YBqAeQdPY7Hkiiaf/Ocd6
	tYMyUb+BImILCOHt9XM+SNFe6w52C7Mw5DI6JPRwslnp3duypwGUh3DQVfzeLqTW
	U4DAUAk6eOuou8DcQI9AS04XSOTSO0ZtJEqMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wRquOpdk5ogIsxVkTSqekRlmXcxpipOz
	b+XU3getkBDQe8RPT5SuMFRwGddMMbPXOLJDlqZSD6BhcRSaN63UaZhRhvXoXNrF
	GF0T6Q9p8a4Yi85KuWy4aLPPxRpk1FigVNzOCyzLKUalRfVqSulhMH8Q7SizZ9Sy
	0sF+WG4g/pQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADC5FB706;
	Tue, 19 Feb 2013 11:29:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CC25B703; Tue, 19 Feb 2013
 11:29:57 -0500 (EST)
In-Reply-To: <874nh8vgoo.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Feb 2013 09:41:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 992B5774-7AB1-11E2-BBD8-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216630>

Thomas Rast <trast@inf.ethz.ch> writes:

> In defense of Thomas, whose project was mentioned earlier as a prime
> example of something that is "too big":
>
> He's in fact still working on the index-API angle, as part of a thesis
> at university.

That is probably a good indicator that it was too big for a summer
student.  It also is good to hear that the topic is being looked at
;-).
