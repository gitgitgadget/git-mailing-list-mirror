From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 13:26:22 -0700
Message-ID: <7vfw7m1t3l.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <20120816194552.GA3167@suse.cz>
 <7vobma1tb9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 16 22:26:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T26eH-0000o8-LF
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 22:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656Ab2HPU01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 16:26:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932649Ab2HPU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 16:26:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7DD0818A;
	Thu, 16 Aug 2012 16:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IE8vjpRX8iQ2iM1jRHZysr/j+mA=; b=NrWX5U
	Gu/8dvlNov5/UL6BUB4mJkUdyeHNdv2tKlOrIcz+fCh1nSZQsDD/o7U0POcVSFWG
	zUT0nxOuDAFIaPUsj4mmX+DvIL3peCV4YWWO7gca8Sqs+4b0ykBGHgcnNmiXMBYz
	fql3UFXkswYgoXMZ2h9JkTfEdX6T3Yq8ER688=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rntd6K/IX+9GO8ByZeiUKVm6XQBv4Im3
	9UPDCjvplR2wvrmP7hcC8okZ0vOqbYrsGlbLVKDI3DO8eRIV1cBE1VKNB9KcIJ1M
	AAb46PJlqJOD6n3i+SQkacDF+9w+HNhFTHhjU5p40u8SiyeaZGhep1Yv+owpvAXM
	zEfcPZqeqBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D6D8189;
	Thu, 16 Aug 2012 16:26:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54F708188; Thu, 16 Aug 2012
 16:26:24 -0400 (EDT)
In-Reply-To: <7vobma1tb9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 16 Aug 2012 13:21:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A61ED9D8-E7E0-11E1-9EED-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We would really think hard to avoid breaking when introducing new
> options whose long name could begin with "v" or "q" to avoid
> breaking "-v" and "-q" that are common across commands

[today's lesson for me; do not type while eating]

Sorry.

        We would really think hard to avoid breaking "-v" and "-q"
        that are common across commands, when introducing new
        options whose long names could begin with "v" or "q".

I tried to rephrase/reorganize the sentence a few times by moving
words around, but did a terrible job at it.
