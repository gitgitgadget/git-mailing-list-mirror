From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 14:05:11 -0700
Message-ID: <7v4no21raw.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <502D5D97.3020906@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@suse.cz>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 23:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T27Fs-00043b-BD
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 23:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659Ab2HPVFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 17:05:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757663Ab2HPVFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 17:05:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95BC58D6E;
	Thu, 16 Aug 2012 17:05:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B7UyghL7Jdf49gzJzQ7brhDyWy0=; b=xKMa/7
	fOGkW74yJH/rgQhrm/brIzTLnZ/8NU9Z2V1GLRA7bUwW9jk24B7AXUnYn7/QW/Sc
	DSmPI1yCu5MVUUkaauteSZOLURJKgzpYNvI232zDDBnOUHmLJTE2DUh3wyz+yB9J
	gl6NEXKxhKlE0G5Feq6RdqEBPV4yUgeD1E4Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ld81osWK217XbcfawX3EgjNjnwUHTUFv
	tXr0XBDcpTCJHgAW/P97HxSV6qy6CjLs0RiVf31pTLNh9cy4D41EFhE8UGqrjfJr
	6vHuI7cxYcrKdB8mt/i/SX1qoSwx4mDFsfl70XewN2ylNkhzOyeW9uG+W9ryvYbX
	wkE9fhyqxX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 840618D6D;
	Thu, 16 Aug 2012 17:05:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E710B8D6A; Thu, 16 Aug 2012
 17:05:12 -0400 (EDT)
In-Reply-To: <502D5D97.3020906@kdbg.org> (Johannes Sixt's message of "Thu, 16
 Aug 2012 22:52:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1212D4BE-E7E6-11E1-946D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Are you sure? This adds '-r', not '--r', i.e., the single-letter option
> 'r', to the documentation, which is not something we want to hide, usually.

I actually think "--rebase" squatting on short-and-sweet "-r" was an
accident, and we are saved by not endorsing "pull -r" by documenting
it.  We can still use "-r" for "--recurse-submodules" if that proves
to give more value than "--rebase" to our users.

So I dunno.  I personally do not think either deserves a short-and-sweet
single letter option.
