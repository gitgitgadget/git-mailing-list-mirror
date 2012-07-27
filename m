From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 14:49:05 -0700
Message-ID: <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org> <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 27 23:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SusPL-0005vB-Hl
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 23:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab2G0VtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 17:49:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab2G0VtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 17:49:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCB7F9C4A;
	Fri, 27 Jul 2012 17:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXEh2JWHu6mD2OUhrl6r079uMCY=; b=nKVnUY
	LwviZtT1IF5mo/ieIxPJ0LCR2FlzahxoAwzz4f7aeNSwvYoGZbwLK1Xb+XzGgXSz
	86RANL8pv/0BYdbxb7/usJlmQisFEEoc2pM6ahRadHBPL2ZXLdW0o4FFSxwz4nDF
	vze9AwL6QRua0cTdXeDPVF7FkRsxhNwcxMAjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YOvlKDpLjP3miLyoW2K+H9W69xF9/C0O
	TY6IFkzB5H2JK3xpkGhCOkA02S9lJkTyqYMsWKk8WfO5db9P1ZQim+hKZDT+E8m+
	3CuMhIQQVNs9tc8y6S4kT6bbdMahzvw1lJrueYuMac33IBA4v3dYfshcfk6XcdOq
	VmA9z0jE4v8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9CE29C49;
	Fri, 27 Jul 2012 17:49:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3720C9C48; Fri, 27 Jul 2012
 17:49:07 -0400 (EDT)
In-Reply-To: <20120727200703.GA2034@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 27 Jul 2012 20:07:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3FC890A-D834-11E1-9945-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202380>

Eric Wong <normalperson@yhbt.net> writes:

> I'll put the following after ms/makefile-pl but before ms/git-svn-pm:

OK, it seems that you haven't pushed out the result yet (which is
fine); how do we want to proceed?

I generally prefer pulling from maintainer trees directly to my
'master' without staging them in 'next', so when the above is done
and you feel the tip of your tree is good for 1.7.12-rc1 without
regression, please throw me a "pull, now!".

Thanks.
