From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-string-list.c: Fix some sparse warnings
Date: Sat, 15 Sep 2012 13:52:09 -0700
Message-ID: <7vr4q3ypom.fsf@alter.siamese.dyndns.org>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Sep 15 22:52:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzM2-0003Mo-D5
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 22:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab2IOUwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 16:52:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab2IOUwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 16:52:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93B0B8015;
	Sat, 15 Sep 2012 16:52:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIqfWtnn995LNPJeZ1OvILmcrhc=; b=EHP9jJ
	l7U3yz+LBuxiuwqlnzRVhnSMPbIKy/K/suMlRbWdCaTAOMKZoqBNLuai9kUAs+kZ
	vjr4o0LWZu9AF6un6gwCBHKQWd+cE/JNrGX5fGzzZSmMQySM+7h/3Vclt/3lWPWn
	ebhrB5Pk04i66i+daHsZ4bJ27vzT7lmYNEI4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYsOeffzZ9dG5b0uaespTkgPqLBRoSu8
	GQMQnvbjYmNKDKMzPb+hAlvIuRjbKsx7SMvWLItzIBmIyN42j+s0mXtOOx/rfERX
	tZkTZnSRBwVDJ/o7MpVwY5qjezZQs3DmXnhK6kKsijVtT9Q916e3V9lTp77VjDXo
	6rCUGm8WeVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F318014;
	Sat, 15 Sep 2012 16:52:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 030078011; Sat, 15 Sep 2012
 16:52:10 -0400 (EDT)
In-Reply-To: <5054AA62.2040603@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 15 Sep 2012 17:18:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3865A63E-FF77-11E1-BF78-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205569>

Queued.  Thanks.
