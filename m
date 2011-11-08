From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Pulling signed/annotated tags
Date: Tue, 08 Nov 2011 13:45:31 -0800
Message-ID: <7v39dyxp8k.fsf@alter.siamese.dyndns.org>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
 <CA+55aFxVsgNjGv2zAGR1VK34uG59+euJec_3i9JNyQ0VUdjyeA@mail.gmail.com>
 <7vsjlzyza7.fsf@alter.siamese.dyndns.org>
 <CA+55aFyEuuT25m00uakL66YKSpT-zjoiBreymFSbuHmtARq6yw@mail.gmail.com>
 <7vobwnyy2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 22:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNtUI-0004qP-Lc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 22:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab1KHVpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 16:45:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab1KHVpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 16:45:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4880D5DE0;
	Tue,  8 Nov 2011 16:45:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=agmSv6otj4D3wwwfT6GUPQV6Kh4=; b=GBIyoP
	Q8R3yBQ2H+rNYiQB0/xze+jcBIIPIL2WWkAEn/tqdHQowUvCLltt7k9L8OPraKdK
	dHvsPy8iW8WuPqR13ZPSpfcHstt6N3QUeqbzvppun2aW2XzdIBl9w8rlYVw9lh1m
	dCUb7AWE+1ioFmuzdtMgEna242L00YlI5AAx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tX0sQK+yVpWGoEjut3sybka86C2Tr1sr
	RKUe/rTewrR23glHwYvcCwlgsrvSQBCaYx66hvEugZS5XNaGluZWbBp9btWiu+T7
	JTdC34nQb89WUuqdOuX4RRB+wQKcUioz4df3RQR1Pv3h4g79Q4etqh4rHbaYDPUY
	Bt6icG3qz/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FE175DDF;
	Tue,  8 Nov 2011 16:45:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 995D35DDB; Tue,  8 Nov 2011
 16:45:32 -0500 (EST)
In-Reply-To: <7vobwnyy2m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Nov 2011 21:37:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBD3E812-0A52-11E1-B252-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185115>

Junio C Hamano <gitster@pobox.com> writes:

> Here is what I had in mind....

And then I changed my mind again. Using a single SP indent for multi-line
header fields make things easy to view.

| tree 20009beb1d5d0494347db5afbe80b364563dd511
| parent 8457d13895251ebf2f839ee6f74dd0087fb56334
| parent 6486ca6d77eaf4109b26b70da0b3a0158868e22f
| author Junio C Hamano <gitster@pobox.com> 1320781099 -0800
| committer Junio C Hamano <gitster@pobox.com> 1320781099 -0800
| mergetag object 6486ca6d77eaf4109b26b70da0b3a0158868e22f
|  type commit
|  tag test-tag
|  tagger Junio C Hamano <gitster@pobox.com> 1320471226 -0700
|  
|  test merge
|  -----BEGIN PGP SIGNATURE-----
|  Version: GnuPG v1.4.10 (GNU/Linux)
|  
|  iQIcBAABAgAGBQJOtMq7AAoJELC16IaWr+bLL30P/iEhPR+gkOpF09EshWZy7Vbu
|  ...
|  =eJX/
|  -----END PGP SIGNATURE-----
| 
| Merge tag 'test-tag' of ../git into HEAD
| 
| test merge

I am redoing the "signed-commit" series to also use this format.

The way I made the tag available to commit_tree() turned out to be a bit
too clever, by the way, and it would cause problems down the road when
these things need to be amended. Embedded "gpgsig" in a commit is about
the commit itself, and should not be carried over, but "mergetag" is about
the parent and should not be lost only because you wanted to fix a type
in your merge log message. I'll be redoing that part in the series and
hopefully the finished result would be ready for review after 1.7.8 final.
