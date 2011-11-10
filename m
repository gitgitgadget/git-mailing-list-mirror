From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git
 1.7.7.1
Date: Wed, 09 Nov 2011 19:21:37 -0800
Message-ID: <7vehxgu0fy.fsf@alter.siamese.dyndns.org>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
 <CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: nathan.f77@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 10 06:25:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RON97-0002yj-63
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 06:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933578Ab1KJFZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 00:25:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933943Ab1KJDVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 22:21:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D7137E08;
	Wed,  9 Nov 2011 22:21:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vfOKKim2DYB0HVCQdSRZZ6DaM+E=; b=tZ8Czt
	KBoD0J+k0PnU9xlnsHl79bOhLUB8leoK+vhfbXlROYHvv4ybiJ3CaatvY+NG2nuw
	b1+phtYuKK6nvlM3yk/vJSmhehcBOrChb9zJjSbr4u90MoaJHup9o18JEgZlwT/c
	511KaDxgQovm89aLOGR0FpKrMSXRNeMeW6iSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B//QAdBM81B/yTpWVbO/6NmplCoRWEFn
	IClmUH1+ZDTM6zZQUcAFD5sX7u8lIhWGAqm+I5RuNp9FUpJ/f3bvYxh1PxddhIbL
	y6+Pryh9JZjBiammp3rxJ54J51bbUGTdHvxkLJ+gVV5EznMTK0KRH/NajzzO/gED
	vq7IxyVi3X0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 248A27E07;
	Wed,  9 Nov 2011 22:21:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C09F7E04; Wed,  9 Nov 2011
 22:21:41 -0500 (EST)
In-Reply-To: <CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com> (Nathan
 Broadbent's message of "Thu, 10 Nov 2011 10:46:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BDE6918-0B4B-11E1-976F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185185>

Nathan Broadbent <nathan.f77@gmail.com> writes:

> Dear git mailing list,
>
> I'm assigning the `_git_fetch` bash tab completion to the alias `gf`,
> with the following command:
>
>     complete -o default -o nospace -F _git_fetch gf
>
> The tab completion then works fine in git 1.7.0.4, but breaks on git
> 1.7.7.1, with the following error:

We have been cooking for 1.7.8 and have the first release candidate
1.7.8-rc1; could you try it and report what you find out?
