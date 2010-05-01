From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to revert 'git reset' command
Date: Sat, 01 May 2010 10:19:10 -0700
Message-ID: <7v63375ylt.fsf@alter.siamese.dyndns.org>
References: <1272692918690-4989146.post@n2.nabble.com>
 <20100501064114.GA5643@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paragkalra <paragkalra@gmail.com>, git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Sat May 01 19:19:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GLd-0002Mi-Qm
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab0EARTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:19:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776Ab0EARTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:19:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF37AFC19;
	Sat,  1 May 2010 13:19:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=56A9z7HENAn+b4hkzauAPbhm3s4=; b=MCtaqZZreAUuz6Xpdcp5+ty
	tYFijVpZ/oKxIhkp/9rVOgTXy80RNlG931Df863zhdtKJEIAn5/ka+gSttlfiIhT
	5imT5gs1quluMdkAkZTio6wXEuKZSTLi03WLHa4X6IQQJjXjIDRxfu49C6dwL88G
	df9a6pggqUvo/f5JI7Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=pEr7aFpKTtkJZWRJlBeEz9fYiMBYHWQUXWszCOYlbrm/XW2KW
	dQc4wRDSAMjzXugrTQgZEzN1uXlP1EGRHXmxPQHj2N52xgDC8pnk3b9AeWkB7c01
	h+rVi2AhXYZFv5FDUCk1NMFhT5MnA0W7dn7GJIDDNmeaSTb+2S/gQN/Bik=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA81DAFC18;
	Sat,  1 May 2010 13:19:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20A3AAFC13; Sat,  1 May
 2010 13:19:12 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB2CD996-5545-11DF-BF3C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146100>

Peter Vereshagin <peter@vereshagin.org> writes:

> 2010/04/30 22:48:38 -0700 paragkalra <paragkalra@gmail.com> => To git@vger.kernel.org :
> p> I have just started learning - Git. Today while exploring Git, I executed
> p> following:
> p> 
> p> git reset
> p> 
> p> Now 'git status' is showing some files under - 'Unstaged changes after
> p> reset:'
> p> 
> p> How can I revert back the effect of - 'git reset'
> p> 
> You may want to try to make a new commit:
>
> git commit -a
>
> Another way is to rerpair your Git history from your remote repository, if one exists

If "git reset" was run without any other options nor arguments (which
paragkalra seems to have done), there is no damage in the git history that
needs to be repaired.  "git reset" by default only resets the index to
match the commit that is checked out.  All that is lost is "git add" done
since that commit.
