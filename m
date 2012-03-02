From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2012, #01; Thu, 1)
Date: Thu, 01 Mar 2012 22:10:12 -0800
Message-ID: <7vpqcvh6t7.fsf@alter.siamese.dyndns.org>
References: <7vy5rjkgxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 07:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3LhD-0007eG-9X
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 07:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab2CBGKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 01:10:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754Ab2CBGKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 01:10:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29AC66D41;
	Fri,  2 Mar 2012 01:10:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Wr/GgFtFvAIibn1Ug/foigW1j6o=; b=cbMVKLlmTbrzeevKCk0O
	Ekk/680T3G7XN6ZDiuayGa081MNW6c/2YA8hqmbixBN1PukrKUQ12vVYsa6pF2eB
	eXfSUA8UCirhnSBiV2aopjcFnt853lVNLdG3XeP8g8nCP8TLuxcodBD6xeErTb3M
	d0w29VakvfC9Y9BUyC1PLgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FZ74Cex6I4tmOfoIbqdP/cLMx5Yu1FZiYKAcS0nbA35ODc
	mrPlCwwe3Fv7nipjK6et8iCw2FB6x0NND9W3tJ3LTlgjR0vFTED8b0n8VnzeF6oY
	3CY6HLkX914l88xPo/GclYoXo+0ycGrhuyWk7FJdiyugVe461PLxE5mGueVqo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21C376D40;
	Fri,  2 Mar 2012 01:10:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B61E06D3F; Fri,  2 Mar 2012
 01:10:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FDF2EFE-642E-11E1-BA32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192005>

Junio C Hamano <gitster@pobox.com> writes:

> What's cooking in git.git (Mar 2012, #01; Thu, 1)
> --------------------------------------------------
>
> * nd/threaded-index-pack (2012-02-28) 2 commits
>  . index-pack: support multithreaded delta resolving
>  . index-pack: split second pass obj handling into own function
>
> Produces a corrupt pack.  Will discard.

This was a copy-and-paste error.  The correct commentary should read:

  Fails to create correct pack .idx file (breakage can be seen in t5510 from
  tr/maint-bundle-bondary topic).  Kept out of 'pu' to avoid damages.
