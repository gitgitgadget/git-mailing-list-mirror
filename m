From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: update russian translation
Date: Mon, 24 Jan 2011 16:34:31 -0800
Message-ID: <7vmxmplt2g.fsf@alter.siamese.dyndns.org>
References: <20110119210131.GA8184@blimp.localdomain>
 <87sjwhn9c3.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jan 25 01:34:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhWs3-0007p6-Ij
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 01:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab1AYAeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 19:34:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab1AYAet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 19:34:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64BAB3605;
	Mon, 24 Jan 2011 19:35:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L8sd8UJztmy2MJF3UQNZR8jSAUA=; b=MqByPI
	W+i6sWQbxtNfsVW3RU84bZiyVs4D5ilsh2YkmbZznj2d+4nEBFwSoqQ1M14QFyec
	s7F47UqNK8hUBoMdK1TCXlhpsZYV2oEFdi9TaCKdOP8bEwzHApPvsHLpV/eFBt2V
	QKrPAi4wQROl6mPHSix7+4PeOsTTGi+y4npnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNlmnBwI5nR0xqd3UVYlEz3DXwCVFGx7
	pM5O71OfWnkBWpvgWDv29UxqtakXUO3868AX9bje5WAbKP2V8rwb/63uvNkTM7Qt
	E0pDTsLEbwu6QoGfpxOSxUJeffqy8F9aI5EJoBIDc7U6hc2Y7AT5r/p5P5O2POrB
	BraAqujNPFg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E561A3604;
	Mon, 24 Jan 2011 19:35:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D10763601; Mon, 24 Jan 2011
 19:35:21 -0500 (EST)
In-Reply-To: <87sjwhn9c3.fsf@fox.patthoyts.tk> (Pat Thoyts's message of
 "Mon\, 24 Jan 2011 23\:57\:48 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 037F2EC0-281B-11E0-BB66-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165466>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Thank you for the patches. I've applied the four patches and pushed them to
> http://repo.or.cz/w/git-gui.git master.

I see a few changes outside po/ru.po in this update:

 git-gui.sh      |   26 ++-
 lib/browser.tcl |    2 +-
 lib/diff.tcl    |   60 ++++--
 po/ru.po        |  623 ++++++++++++++++++++++++++++---------------------------
 4 files changed, 381 insertions(+), 330 deletions(-)

Are they all good to go for 1.7.4 final?  My cursory look indicates that
they are all minor bugfixes and look sane, but I rarely use git-gui
myself, so I am just double checking.


Alex Riesen (2):
      git-gui: update russian translation
      git-gui: update russian translation

Bert Wesarg (5):
      git-gui: fix ANSI-color parsing
      git-gui: respect conflict marker size
      git-gui: fix browsers [Up To Parent] in sub-sub-directories.
      git-gui: Fix use of renamed tag.
      git-gui: Fix use of hunk tag for non-hunk content.

Serge Ziryukin (1):
      git-gui: fix russian translation typos

Skip (1):
      git-gui: spelling fixes in russian translation

Stefan Naewe (1):
      git-gui: use --exclude-standard to check for untracked files
