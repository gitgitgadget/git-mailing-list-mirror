From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2 v2] Adding Beyond Compare as a merge tool
Date: Tue, 01 Mar 2011 20:26:18 -0800
Message-ID: <7vhbbmf8r9.fsf@alter.siamese.dyndns.org>
References: <4D6A355C.3000805@gmail.com>
 <7voc5wk5wl.fsf@alter.siamese.dyndns.org> <87hbbmqsbt.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	Chris Packham <judge.packham@gmail.com>, charles@hashpling.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 05:26:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PudeC-0005ky-OO
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 05:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab1CBE0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 23:26:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757821Ab1CBE0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 23:26:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BAEB843EF;
	Tue,  1 Mar 2011 23:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LF13+JN9Pbn7Qnu5Xlq8/v8POyk=; b=Bsr7B2
	aIdlp6seeHwLS/L9icX81zFFPmAMYtCC4T/yVKdWiSZ98d0EKSRy9lumElNJqNQh
	f9y0mIsdmSgNoY27pcNXYsjkCtBvyGTFLeYv3n8GMJuCjRNYk/pObqwIIWsjURqR
	iwJhnUW04+DvXZXwwrTGmebee4/kKNc3AdnUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ho+z7PgoHD2hdKxv7XLO5EuDZwN/IUsA
	801EkmtboIVmhvnK07V/6aafT5dam8wxRyLd21gg0RGJLJUtE9VT1GDMg2npMOVP
	1vqBqoZYKeKP91xKD9rLkwRs2lzthtN6WKVqN291S1ruDuB4930McN6w4oQ9ANRA
	yPa/g6vyVRo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6940943EA;
	Tue,  1 Mar 2011 23:27:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D50F143E8; Tue,  1 Mar 2011
 23:27:39 -0500 (EST)
In-Reply-To: <87hbbmqsbt.fsf@fox.patthoyts.tk> (Pat Thoyts's message of
 "Wed\, 02 Mar 2011 00\:28\:06 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C9144E4-4485-11E0-9A05-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168291>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>Sebastian Schuberth <sschuberth@gmail.com> writes:
>>
>>> Sebastian Schuberth (2):
>>>   mergetool--lib: Sort tools alphabetically for easier lookup
>>>   mergetool--lib: Add Beyond Compare 3 as a tool
>>>
>>>  Documentation/git-difftool.txt         |    4 +-
>>>  Documentation/git-mergetool.txt        |    4 +-
>>>  Documentation/merge-config.txt         |    8 +-
>>>  contrib/completion/git-completion.bash |    2 +-
>>>  git-gui/lib/mergetool.tcl              |  101 +++++++------
>>>  git-mergetool--lib.sh                  |  247 +++++++++++++++++---------------
>>>  6 files changed, 195 insertions(+), 171 deletions(-)
>>
>>Hmm, I really would have liked if you took the hint and separated git-gui
>>bits into separate patches.
>>
>>I saw Tested-by from Chris, so I'll add that to what is queued on 'pu',
>>ask Pat to keep an eye on the ss/git-gui-mergetool branch, and then merge
>>my ss/mergetool--lib branch to 'master' during my next integration run.
>
> Where is this branch?

$ git log --oneline --first-parent master..pu

Look for the commit that merge ss/git-gui-mergetool and pick its second
parent, which is ffe6dc0 (mergetool--lib: Add Beyond Compare 3 as a tool,
2011-02-27).

Thanks.
