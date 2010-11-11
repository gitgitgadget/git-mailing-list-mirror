From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Thu, 11 Nov 2010 14:03:30 -0800
Message-ID: <7vlj4zfrgt.fsf@alter.siamese.dyndns.org>
References: <20101110170819.GA3031@gnu.kitenet.net>
 <7v1v6thrzc.fsf@alter.siamese.dyndns.org> <20101110200650.GA13439@burratino>
 <20101110204542.GA11201@gnu.kitenet.net>
 <AANLkTi=W_hwU=3PTTqE4R8Cg5T=GMdMfBsKQ1YE0HWRe@mail.gmail.com>
 <20101111192648.GE30870@efreet.light.src>
 <20101111204626.GA13937@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Nov 11 23:03:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGfF8-0003Ub-Mt
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 23:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994Ab0KKWDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 17:03:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab0KKWDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 17:03:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42156376E;
	Thu, 11 Nov 2010 17:03:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tX4spTMzEw4mxGqmEqo3KPuB2o0=; b=bfPyl7
	hEqSe8z6wtK6OWsThE3hy6xpd+T4Sol3Mpc8VI6Ts5jwtucd4rGKkDGrfvhYsa0s
	ZYZvhdmvr/hvV7S2TbZmiMz7aK2dG20AfVrbvSrLTiPGhODcW+6tWT9EvgsETukI
	3k9Bg4y0oMKO8nqe+XPJwlnra1Qybp9r3cUqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ifNf8hVv64PBWegXHVGRh325XHlcJoLM
	Pla0x4eV67KdQwWdXe/RWBZgB+6ezudYoL4Mcpijy1lRO4uvIGRasQOOVzZqpfVX
	NaGWhTsJTo+3jVShnBwrzM/1VMmtfDPLKZUnnXIKdz6H3VmBrPUzcR401JU091Sy
	oXlFWI2JZA0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02D8E3769;
	Thu, 11 Nov 2010 17:03:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 222653767; Thu, 11 Nov 2010
 17:03:36 -0500 (EST)
In-Reply-To: <20101111204626.GA13937@gnu.kitenet.net> (Joey Hess's message of
 "Thu\, 11 Nov 2010 16\:46\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A64586E-EDDF-11DF-9D6A-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161304>

Joey Hess <joey@kitenet.net> writes:

> ... The
> pre-commit script there stores some metadata about files that git
> usually doesn't track, by putting it in a dotfile, and stages that
> dotfile for commit. Which currently works fine, except for the minor
> problem that the user doesn't see the dotfile listed in the commit
> message.

I am hearing "list of files in the commit message", and am getting
confused.  As far as I know we don't store such a list in the commit
message.

Puzzled.
