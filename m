From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH svn-fe] fast-import: make code "-Wpointer-arith" clean
Date: Mon, 28 Feb 2011 16:41:32 -0800
Message-ID: <7vipw3fz9f.fsf@alter.siamese.dyndns.org>
References: <20101224080505.GA29681@burratino> <20110226114435.GB12231@elie>
 <7vhbbolm5q.fsf@alter.siamese.dyndns.org> <20110228213210.GD1942@elie>
 <20110228231511.GF1942@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 01:41:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuDez-0003Jt-Mc
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 01:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab1CAAlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 19:41:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980Ab1CAAls (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 19:41:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7F784F20;
	Mon, 28 Feb 2011 19:43:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BBo9gqyfRrQc7DgX5+cqbL0FUVw=; b=hskyMFDXTaW7wtLcCOiMwSJ
	CU/Vmze70aWdifNmIxVErIQvq7HTUCv11nipMS8E1kHx6KSM53pomPbXVQ4TdK9F
	dFeZeMlts6xIiHO5OxNWwEC48VgPKR11H3GBwkByNOOII2NoJLWDgJXRwiyBI9bp
	gy6EUJxUjqjGTNzu0WK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uaoTPR/S6X6Ny+oE8fdfTDPOYpPPLdkohaq7iisAHZrq1M/uR
	2zTpq9ZjISNbKl3zli5qb0uoRUhtDhz+Ai5cTQC9wvI9PAunn52rfllZwD3klp09
	2XB244mIfWawwq7blc747C0RR797jdWN8shlLog9rHs+vTvB8fe8xnBzv4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59BE04F1F;
	Mon, 28 Feb 2011 19:42:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CFD774F1E; Mon, 28 Feb 2011
 19:42:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB3D2078-439C-11E0-AE8B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168170>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> This should fix it, I suppose?
>
> Pushed out.  Thanks again.

Thanks, pulled.
