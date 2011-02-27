From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Adding Beyond Compare as a merge tool, was: Re:
 What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Sun, 27 Feb 2011 01:12:40 -0800
Message-ID: <7v39n96dtj.fsf@alter.siamese.dyndns.org>
References: <4D68DAC4.9060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, charles@hashpling.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 10:13:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtcgV-0005S8-L3
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 10:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab1B0JM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 04:12:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1B0JMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 04:12:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8DB42671;
	Sun, 27 Feb 2011 04:14:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=tyJoHyBUlQV/u15mKlShZKf1MyM=; b=noT3Jk0oP67GBnEw293xq1/
	DOJXlzu6GzOH/jb7EJHPqVkbA9cmeaL926HT9MBtwYZHFOUNk6aG/pEFEm0/lSBG
	f/XdFpc7PA09ezQ60821ZNSdNrc20fH3r5hYDDZUF9orMI2QT3Aznlj4eAjkZY1V
	cCF7JILvaSBm2F3iUCRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=usGCjJjRRSSRzjcBs3XkOAywi+5rV6MXm410obVJTv3iOAcWl
	qf2ZEyam3DnMZSSs8pC2OQrmbhw7ArFYKLcFzBGW0P1NN6GM3Yp7jqSNOw0Tb6+W
	/SLiXgqELqMAzpehtyjF3Gq0zqt4YixUajwKt+mjHPFUwKWHcYmwnkm+t4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 632022670;
	Sun, 27 Feb 2011 04:14:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 055CD266F; Sun, 27 Feb 2011
 04:13:58 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC3316EA-4251-11E0-A773-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168015>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Sebastian Schuberth (3):
>   mergetool--lib: Sort tools alphabetically for easier lookup
>   mergetool--lib: Add Beyond Compare 3 as a tool
>   mergetool--lib: Add the proper executable name for ECMerge
>
>  Documentation/git-difftool.txt         |    4 +-
>  Documentation/git-mergetool.txt        |    4 +-
>  Documentation/merge-config.txt         |    8 +-
>  contrib/completion/git-completion.bash |    2 +-
>  git-gui/lib/mergetool.tcl              |  101 +++++++------
>  git-mergetool--lib.sh                  |  250
> +++++++++++++++++---------------
>  6 files changed, 198 insertions(+), 171 deletions(-)

Ohh, somebody line-wrapped your message.

I've dropped git-gui/ bits from the series, and queued the remainder as
ss/mergetool-lib branch.  I also forked git-gui and queued the git-gui/
bits there to create ss/git-gui-mergetool branch.

When the ss/mergetool-lib branch gets ready to be merged to 'next', I'll
ask Pat to keep an eye on the ss/git-gui-mergetool branch and we will
coordinate the merge of these two topics to our respective 'master'
branches to make sure that the git-core side graduates first and followed
by git-gui side.

Thanks.
