From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a test to check that git ls-tree sets non-zero
 exit code on error.
Date: Sun, 24 Jul 2011 00:45:00 -0700
Message-ID: <7vipqsw29v.fsf@alter.siamese.dyndns.org>
References: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
 <1311469670-15392-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 09:45:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QktNF-0002nv-W7
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 09:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab1GXHpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 03:45:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab1GXHpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 03:45:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7BAC2C0D;
	Sun, 24 Jul 2011 03:45:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVhJOIGIHNncs8C88g25I/52MDY=; b=hGci1n
	zer3yd1kA32kdh43+aA6XhNoAmxliyy+f9v57FTZ0TeGjxRYdP5Hu8BDseKrTkb+
	Hyoq40B4Ep32KnjIMDdafxn0RGAPdg7eaayO8NYtK/YXTOCdb/y1/rX6m+n7nu/A
	YOPyP2WbOn0SF5bqbQWXtae+2wCK+8gKVzwkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SqvBfIb2xfHUB3xc2BEVxAYwI+P+ksIh
	KhcoeprPH0KLvObPJ0gGYda5zpyYIZK2enLVMLocgSNUd3aboiF+9mV6rfMuIYP7
	8L3fgI04G3gYhniyLxLDJdvBZdZ6eTAzk/idkgYb1lziljSoIe6/RsNP5p+5j9HK
	q9UWx12kZ1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6282C05;
	Sun, 24 Jul 2011 03:45:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64BDD2C01; Sun, 24 Jul 2011
 03:45:02 -0400 (EDT)
In-Reply-To: <1311469670-15392-2-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Sun, 24 Jul 2011 11:07:49 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6E071DA-B5C8-11E0-9857-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177729>

Jon Seymour <jon.seymour@gmail.com> writes:

>  t/t3103-ls-tree-missing-tree.sh |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100755 t/t3103-ls-tree-missing-tree.sh

I'd rather not waste a new test number for something trivial like this.
Don't we already have a script that tests ls-tree?
