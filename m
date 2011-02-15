From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] command-list.txt: mark git-archive plumbing
Date: Tue, 15 Feb 2011 11:11:44 -0800
Message-ID: <7vwrl1nmdr.fsf@alter.siamese.dyndns.org>
References: <4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann> <20110209210312.GB2083@sigill.intra.peff.net>
 <7vipwsomq8.fsf@alter.siamese.dyndns.org>
 <20110209234621.GA12575@sigill.intra.peff.net>
 <20110215070426.GA6118@duynguyen-vnpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 20:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpQJq-0007BC-Lh
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 20:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab1BOTME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 14:12:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab1BOTMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 14:12:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BCCC3192;
	Tue, 15 Feb 2011 14:13:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qb3xcNAbRXZsefQuIplp1/gLnfk=; b=oe0Nq8
	ZJAU0X2JUbvtfmH5eLz1LT9c4FEqbfQpdYPWTAXDE/94DQgZEesR37M3KI5oIov+
	O2XEQQN5wcVw6TwhzSubyam43Xg021ToFcEi0fRiTZfHhBU1nBdxMccOLENq/ieB
	pqzaekVK6uMAtqzooVikDYeWwBxWT9G6gNRHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEKQZq77ZQmKvCIK4E8889A6xFLu7uO9
	EI8h23uYvsl25rjlcdtQTEdTrs6+RJCL1updztQnRDXCXjXUY1LsiubYf1pHn5Bp
	/CC5nnE699rFqNShTxU0ChOrsrot4Q3fmANxVQwWcwA0CcUYvqxyHAJa+zmp2syV
	qER7F0vJ/10=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F3FF4318E;
	Tue, 15 Feb 2011 14:13:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 453DE3182; Tue, 15 Feb 2011
 14:12:52 -0500 (EST)
In-Reply-To: <20110215070426.GA6118@duynguyen-vnpc> (Nguyen Thai Ngoc Duy's
 message of "Tue\, 15 Feb 2011 14\:04\:26 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9BB66316-3937-11E0-B8CC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166867>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>   Perhaps a patch like this for the record?

Hmm, I don't think you can have it two ways.

What does Documentation/cmd-list.perl do to this line?

>  command-list.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/command-list.txt b/command-list.txt
> index 95bf18c..7888121 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -5,7 +5,7 @@ git-am                                  mainporcelain
>  git-annotate                            ancillaryinterrogators
>  git-apply                               plumbingmanipulators
>  git-archimport                          foreignscminterface
> -git-archive                             mainporcelain
> +git-archive                             mainporcelain plumbinginterrogators
>  git-bisect                              mainporcelain common
>  git-blame                               ancillaryinterrogators
>  git-branch                              mainporcelain common
> -- 
> 1.7.3.1.256.g2539c.dirty
