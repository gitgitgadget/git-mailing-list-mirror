From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Signed tags in octopus merge..
Date: Sat, 14 Jan 2012 18:30:09 -0800
Message-ID: <7vobu5wvda.fsf@alter.siamese.dyndns.org>
References: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 15 03:30:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmFrR-0007j1-Qn
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 03:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab2AOCaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 21:30:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab2AOCaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 21:30:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420106ECA;
	Sat, 14 Jan 2012 21:30:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qKU+9DLoD6/jDFb77ACKe522Qvc=; b=qL8WYt
	DsSWIxzLLRTCd6K8U7FNKqGtvOTfKB7ARtw+BO45tiX/6HaV+i2iB7ZdZa3YKAFd
	AfeWqDcSB1CbhpoUXySChEPTLkeEpzwHZbPsGj8tOolCWgYf/rPIcBHdcmAHObbU
	gG0KzfbV4rkyaxkxCYktay6coGqPuzLbqReww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPj21PuXqi8D5A4vA88cC9yW1ynsLcFp
	K1dpn5vEW2+ABnZ+WRcUzHinXRo6QjIcRCrZYOCru6PJFnaifbu+p3yDt++YHhD5
	otWjQcqGrPMRaYzIlZ8txk+q5NIVpL6jQ6pMt32MMbGNaoqGTT1/xYPvsqqxiizp
	Q11SyDDeDc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38CE76EC9;
	Sat, 14 Jan 2012 21:30:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA1256EC7; Sat, 14 Jan 2012
 21:30:10 -0500 (EST)
In-Reply-To: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com> (Linus
 Torvalds's message of "Sat, 14 Jan 2012 13:30:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8E78B44-3F20-11E1-BFEA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188586>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Just a heads-up and congrats: octopus merges of signed tags work well,
> and did exactly the RightThing(tm), both at merge time and with
> "--show-signature".

Heh, thanks.
