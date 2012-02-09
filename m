From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] submodules: always use a relative path to gitdir
Date: Thu, 09 Feb 2012 11:40:08 -0800
Message-ID: <7vd39nx0br.fsf@alter.siamese.dyndns.org>
References: <4F32F252.7050105@web.de> <4F32F2F6.6040006@web.de>
 <4F33814E.7050404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 09 20:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZqt-0004MF-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab2BITkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:40:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903Ab2BITkM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:40:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AB3262D6;
	Thu,  9 Feb 2012 14:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b8ZE8WhFECWN5AkGJw80RUHqAy0=; b=PT7+k5
	sgjIqpFg3uAT3M+aQM1LQmMdHjCgI4foWuJeph01ui1JrZ/BE7GeTXr3CRJn5VR2
	VWeaBVXl5BbkM6VurHePYd42w0z7kFmXFYlItqcS/ulqfMyN4/6yqkXjXyxmmKhz
	PK6XaPL69FpFkgb1T/df0WYHu4Z3DoImACJAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rj9DVWh1+DdTPmAVbNS/pebmTfbl//OR
	wYI0GK8mheoAW7q9NF+HcBIjRuT9lpoXFm9CmgXVIzqeurevMmreoq/UnIbnSwyq
	4xAwgtQvUyX0Wf/kaZWI1vdlj2R2Iw6C00Asx5/P5sN5tPw+b9FpoirhKdwGXs/y
	8CazaO6VxVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 117BA62D5;
	Thu,  9 Feb 2012 14:40:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FAE962D4; Thu,  9 Feb 2012
 14:40:09 -0500 (EST)
In-Reply-To: <4F33814E.7050404@web.de> (Jens Lehmann's message of "Thu, 09
 Feb 2012 09:18:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0341EC8-5355-11E1-A93B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190311>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Since recently a submodule with name <name> has its git directory in the

I understand that "recently" refers to efc5fb6a77 and this is potentially
a maint material for v1.7.8.X; am I correct?

> The first version was whitespace damaged, please use this one instead.

Thanks. 

When applied to v1.7.8.x maintenance track, this failed the first step in
t5526, but with the earlier jl/submodule-re-add topic everything seems to
pass just fine.
