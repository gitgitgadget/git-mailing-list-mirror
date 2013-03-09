From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault in git 1.8.1.5
Date: Sat, 09 Mar 2013 13:16:35 -0800
Message-ID: <7vboase0jw.fsf@alter.siamese.dyndns.org>
References: <2078462.OF4zRmv4ar@pablohp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Strasser Pablo <strasserpablo@bluewin.ch>
X-From: git-owner@vger.kernel.org Sat Mar 09 22:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UER8d-0008Jy-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 22:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab3CIVQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 16:16:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab3CIVQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 16:16:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A142BDD5;
	Sat,  9 Mar 2013 16:16:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EaKkpjlbk7TMmnNSNLR6ntOnoE8=; b=fd7ZHt
	6qs2yW5TGvleTtluEP8OQ/rsrurFEo6QjzuGRn4HhHwW+0b8c/HrrKCn1NDT3FQX
	+AdiCAmLKEJp5HxMh4gB5aQgGHe/+cqPbuIHgD6rZNKsav33Jsua22ztYTUJ2FgV
	hpYaHyaTK5/Y0lJ8bR0X2wmQDM9pZgSA4TZXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZohif3DaQZHNUVbF8eS/ZCR59IlgMVh
	jaN/u7JS1vYlST+728nWraMn4EdgCy1oMYFh6sLuJYAnrBmyKtdT6PvGSiLHj/lh
	DUutvrOLIGxYjYfAHpqoy78j57QRxseAZ7rpbm8QrCnIuycR+hFMkWsf8KRT1AU/
	YyqU95ar5l4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F692BDD4;
	Sat,  9 Mar 2013 16:16:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4813BDD3; Sat,  9 Mar 2013
 16:16:36 -0500 (EST)
In-Reply-To: <2078462.OF4zRmv4ar@pablohp> (Strasser Pablo's message of "Sat,
 09 Mar 2013 21:16:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0720E28-88FE-11E2-BBBA-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217764>

Strasser Pablo <strasserpablo@bluewin.ch> writes:

> I segfault with the following command:
>
> git checkout HEAD~1
> git branch -u origin/master

A patch to address this in cooking in 'next', and is expected to be
in 1.8.2.1 or later.
