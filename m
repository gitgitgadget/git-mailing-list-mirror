From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff-index ignores color config
Date: Tue, 26 Apr 2011 10:42:03 -0700
Message-ID: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
References: <1303830261.3387.21.camel@dhcp-141.kontor.deklomp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elias Persson <delreich@takeit.se>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEmHA-0008E5-Va
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829Ab1DZRmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:42:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540Ab1DZRmM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:42:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0AB3634BD;
	Tue, 26 Apr 2011 13:44:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FvPwbIm/B58ltd89tG/JEakn9eI=; b=CENV6c
	aF+Jg4CtBfjYqfNwWo9KeZAcjEvrCJwb41VThjNn6ybaNpEnpG8ZiXgKzDWGlbZV
	5ugy1zhTe2UYXtie4GKQqdQnURsJhk8ugP5+Dcr8vtEQGz0jpHjGdT0z3FUadJpp
	wegiNpnzBjJxQYoOGjLSspN41aFK7Z2BY40lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcJFibZfqO/0ZxkXgnS5h5SJ/99YX+Au
	7pgtZefUQG0TYzm/blkewg7magIRrxctNv5OaI2WuLlljy4s6rkAtd3nYmr6p7WC
	kr53+GEnADwzUAdoMCdlfwZrC2/0ZnTTn4fpwkZcXmzC6BUoiAhfgeWEw4qbFJT0
	RqsLhhnLJ+M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD72434BB;
	Tue, 26 Apr 2011 13:44:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09DAD34B8; Tue, 26 Apr 2011
 13:44:06 -0400 (EDT)
In-Reply-To: <1303830261.3387.21.camel@dhcp-141.kontor.deklomp.se> (Elias
 Persson's message of "Tue, 26 Apr 2011 17:04:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA6F1E92-702C-11E0-9A2C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172119>

Elias Persson <delreich@takeit.se> writes:

> Having color.ui (and/or color.diff) set to auto, doing
>
>    git diff-index --check <some refspec>
>
> on a set with e.g. trailing whitespace does not produce colored
> output.

Isn't that very much on purpose?  diff-{index,tree,files} plumbings should
not be affected by UI related configuration variables.
