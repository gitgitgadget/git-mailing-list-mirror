From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 13:10:18 -0700
Message-ID: <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241331.17986.barra_cuda@katamail.com>
 <alpine.LSU.1.00.0803241409400.4353@racer.site>
 <200803241502.21465.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:11:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdt0i-0001KD-8C
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 21:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbYCXUKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbYCXUKa
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 16:10:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbYCXUKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 16:10:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 54118105A;
	Mon, 24 Mar 2008 16:10:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B38141056; Mon, 24 Mar 2008 16:10:22 -0400 (EDT)
In-Reply-To: <200803241502.21465.barra_cuda@katamail.com> (Michele Ballabio's
 message of "Mon, 24 Mar 2008 15:02:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78091>

Michele Ballabio <barra_cuda@katamail.com> writes:

> +int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
> +		int unset)
> +{
> +	*(unsigned int *)(opt->value) = approxidate(arg);

Doesn't approxidate return ulong, not uint?
