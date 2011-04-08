From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: allow "-" as a short-hand for "previous branch"
Date: Fri, 08 Apr 2011 11:43:38 -0700
Message-ID: <7vipuo4m91.fsf@alter.siamese.dyndns.org>
References: <7vmxk164wd.fsf@alter.siamese.dyndns.org>
 <BANLkTikA3dFQpZWC=TC3+zp2FS=uBBxf0Q@mail.gmail.com>
 <7vbp0h63sw.fsf@alter.siamese.dyndns.org>
 <4D9ED5AC.3050106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Adam <thomas@xteddy.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:43:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Gex-0002z9-VH
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 20:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab1DHSnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 14:43:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab1DHSnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 14:43:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74F534500;
	Fri,  8 Apr 2011 14:45:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e/xToOfLr+EvHv4xytdds+pd4S8=; b=Efu4W0
	zvBva+61ksFySqbsgdbfMo35ryRY2Ub5XTeqK0yKshT5WSO29+nvSrpvxIOfYW+c
	9zRmr0zmcNr7uG5UP2HcyM2oszDwBSGTX76H1dFycRQI0ckySmJR4OmmLJ7Klyp+
	pma8+nHR4+Jv0ndbBU6IBvFSL2n2VAicDkkD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iRq/5xMzZel6AosGgmAbN/h8EUvLeWKB
	jevvsY1PCe1zqlbRp3HGwRjDN4b64BgSlzFF4XJ0N1k/m4OlFXNojfRrzcPSViXO
	wvjAfd3Xzcj4uNuvJlhud8DKAhj3YpjF+SHGm7ngJWPT4jnWxZDwoLWbvtmLNXtZ
	YI7n1QHSDfs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34D1E44FE;
	Fri,  8 Apr 2011 14:45:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1143544FA; Fri,  8 Apr 2011
 14:45:35 -0400 (EDT)
In-Reply-To: <4D9ED5AC.3050106@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 08 Apr 2011 11:30:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6696250C-6210-11E0-BB11-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171141>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ... In principle it makes
> sense everywhere where a branch name makes sense, e.g.:
>
> git branch -D foo
> #...can't delete the current branch
> git checkout whatever
> git branch -D -
>
> In this case, shell history is faster, of course.

Yeah, and "branch -[dD]" is truly destructive, so...
