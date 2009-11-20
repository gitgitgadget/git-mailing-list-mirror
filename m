From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ambiguous ref names
Date: Fri, 20 Nov 2009 02:59:38 -0800
Message-ID: <7vpr7dzckl.fsf@alter.siamese.dyndns.org>
References: <5195c8760911200218v5b75d690hbaaf00b44c8df6af@mail.gmail.com>
 <7vzl6h3319.fsf@alter.siamese.dyndns.org>
 <5195c8760911200248v1f3d6b56q78987edfceae5541@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:59:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBRDY-0006zR-8U
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbZKTK7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZKTK7n
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:59:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbZKTK7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:59:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7C559FB09;
	Fri, 20 Nov 2009 05:59:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=alCkHICee5rUh2LZUzuf7zZMJ8Y=; b=yR8Xj/
	90XOd+xjqWMXEnlGb12T3WcSTef81IT4/Z3feNeJ5hSfOIPbtxqWJnij9d7cv9/n
	hZgPz608qOptKyJ8XDk4RJQSLcniXdUODJ+x2e1VjXcYl691Pom9DBA9Rw4CkK+G
	4SrUZaH89SB6DuH/EqgjoebWa5Lc7Sw87+PLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wtkFHUQ6XkkzCwEfEuaH8K+1aa6xuFnv
	EirMWTne4LJn7bGxh6uh6IYVFHKLBWduYSrwBqIBZbORecJC4Vb9qvVm6NSNoT8M
	/BuCNsm4/S+feXgDwM2WQO51c6GnLJGrU1yzlztBQG+Nb6EXTAgk2vL2/fhYDbMD
	JS9FvN/72/g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 867159FB07;
	Fri, 20 Nov 2009 05:59:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 58B6D9FB03; Fri, 20 Nov 2009
 05:59:40 -0500 (EST)
In-Reply-To: <5195c8760911200248v1f3d6b56q78987edfceae5541@mail.gmail.com>
 (Jeenu V.'s message of "Fri\, 20 Nov 2009 16\:18\:55 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF8BF594-D5C3-11DE-A89D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133331>

Jeenu V <jeenuv@gmail.com> writes:

> On Fri, Nov 20, 2009 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> [...]
>> It could be that you have a tag and a branch that are both named a.b.c,
>> though.
>
> Hm, right. But I'm getting this from an existing local repo of mine. I
> can't see any tags; 'git tag -l' is empty. Is there any more info that
> I can provide?

man git-for-each-ref?
