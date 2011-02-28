From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2 v2] Adding Beyond Compare as a merge tool
Date: Sun, 27 Feb 2011 22:52:10 -0800
Message-ID: <7voc5wk5wl.fsf@alter.siamese.dyndns.org>
References: <4D6A355C.3000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	charles@hashpling.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 07:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptwy6-0001bV-94
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab1B1Gw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 01:52:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab1B1GwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 01:52:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 032762A2B;
	Mon, 28 Feb 2011 01:53:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7SfTkpTPjFe3BlDoLnBT8S/rmtE=; b=bd7WPibR9Nc4QUlTsSGVU6u
	yj9VB3dvMBqXKuMVAgwzGjabLOATZCvVWx9kj8LSRRpc7cDQqISwEPW/wj9fUwwh
	ivKMqcg7KErcRuQsMRaIA7InX8w4tpiVbt14l5mS5kq/qzXY6KgulE3UlVUyzM3z
	HkWAQWi98x4czUkmu/B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YTz24mcRw9kLZHKhAQ3aMqFm8a2gPP2aa6wiwxFPq5IlyFezn
	SEkeJb2klzrAZPoslFQLmnJfdpsN0LoSA9YmMwv3iFkX5IQ2OWozUz5J7dnVvUjX
	/o2yfsq6MzQmR6M0fU+F6iqilOmoHSY2QwTF5R8+mjWqqS10ijM5hSyG6A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3C9D2A2A;
	Mon, 28 Feb 2011 01:53:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A2F02A29; Mon, 28 Feb 2011
 01:53:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 774A3690-4307-11E0-BC50-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168071>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Sebastian Schuberth (2):
>   mergetool--lib: Sort tools alphabetically for easier lookup
>   mergetool--lib: Add Beyond Compare 3 as a tool
>
>  Documentation/git-difftool.txt         |    4 +-
>  Documentation/git-mergetool.txt        |    4 +-
>  Documentation/merge-config.txt         |    8 +-
>  contrib/completion/git-completion.bash |    2 +-
>  git-gui/lib/mergetool.tcl              |  101 +++++++------
>  git-mergetool--lib.sh                  |  247 +++++++++++++++++---------------
>  6 files changed, 195 insertions(+), 171 deletions(-)

Hmm, I really would have liked if you took the hint and separated git-gui
bits into separate patches.

I saw Tested-by from Chris, so I'll add that to what is queued on 'pu',
ask Pat to keep an eye on the ss/git-gui-mergetool branch, and then merge
my ss/mergetool--lib branch to 'master' during my next integration run.

IOW, no need for further actions from you on this topic for now unless you
have incremental improvements on top.

Thanks.
