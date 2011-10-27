From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git alias and --help
Date: Thu, 27 Oct 2011 15:28:01 -0700
Message-ID: <7vfwiexe6m.fsf@alter.siamese.dyndns.org>
References: <j8clg9$ldh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 00:28:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJYQk-00011i-GB
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab1J0W2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 18:28:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab1J0W2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 18:28:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2197167EE;
	Thu, 27 Oct 2011 18:28:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lt0xjsciNRuUpHzfSHr9YGPbMQw=; b=CjY6K6
	fG/YHNSDTutIw/VHU36+ceaQjyhIdjQxsJtRyWfJk2UjWzplQaIt+5zsGbbLF9Pe
	mf3BQJ0RKH01EhVrpEISaOdaa5kP+9aIk6fR9THOUVnHx+O/GjPbu+YvR69mfudR
	A+izSlExbc2f7TesdSDoX98uqSHKmindhcQsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BgjS7dxrlKpsXH6O8QpKgcTcn+kb5O5Y
	F5qQAffkS3+5sC5rvA9mZX0get6FAAOu+xe+Zh6+0Qk6pXazvjft2hwcC3epL5HF
	pBkvyandzhrx56d2Qr5xoCt8NsleVoIrf9MLPCyo8obxc5ufZ2RIIJJXiDO85Tq0
	g7KzEBOu16w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1895B67ED;
	Thu, 27 Oct 2011 18:28:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7818367EC; Thu, 27 Oct 2011
 18:28:02 -0400 (EDT)
In-Reply-To: <j8clg9$ldh$1@dough.gmane.org> (Gelonida N.'s message of "Fri,
 28 Oct 2011 00:20:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEB52B12-00EA-11E1-8C9E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184326>

Gelonida N <gelonida@gmail.com> writes:

> Is there any trick to get the help text of git branch without
> having to type
>
> git branch --help

How about "git help branch"?
