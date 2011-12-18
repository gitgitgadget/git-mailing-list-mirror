From: Bruce Stephens brs <bruce.stephens@isode.com>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Sun, 18 Dec 2011 15:37:46 +0000
Message-ID: <848vm9dh6d.fsf@cenderis.demon.co.uk>
References: <jcki8u$oip$1@dough.gmane.org>
            <84ty4ycdcc.fsf@cenderis.demon.co.uk>
            <jckvpk$i8v$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: DeMarcus <demarcus@hotmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 16:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcIoW-0003Fx-5Q
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 16:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752Ab1LRPhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 10:37:50 -0500
Received: from rufus.isode.com ([62.3.217.251]:42043 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab1LRPht (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 10:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1324222667;
 d=isode.com; s=selector; i=@isode.com;
 bh=ed+EYP2gqFQ845v8N2QTCKSV/w+PtzHV/41jnRFYuvU=;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
  In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
  Content-ID:Content-Description;
 b=xLL8bMGVqokJsBljRw7d45NYMKU8SDnNWv03sTvSCj/N1UagPoEG4aTbNNS1IkAUPTxYZe
	rSpH+5roVH5rX5w2arJ/bZrI3xlkx9B2NkelYBrT/uftRwxlGfxDVmjTuuz6I3LtvionI9
	GiwfTRRk+wasa6Fzg4F2sumjlW0A8Uc=;
Received: from cenderis.isode.com (cenderis.demon.co.uk [62.49.17.254]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <Tu4IygBaK66l@rufus.isode.com>; Sun, 18 Dec 2011 15:37:47 +0000
X-SMTP-Protocol-Errors: PIPELINING
X-Hashcash: 1:20:111218:git@vger.kernel.org::1/bYayoWxsq1einR:0000000000000000000000000000000000000000000Tq1
X-Hashcash: 1:20:111218:demarcus@hotmail.com::fcbSkQXFV1JQy7zp:00000000000000000000000000000000000000000FYlg
In-Reply-To: <jckvpk$i8v$1@dough.gmane.org> (demarcus@hotmail.com's message of
	"Sun, 18 Dec 2011 16:10:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187424>

DeMarcus <demarcus@hotmail.com> writes:

[...]

> It feels strange doing a commit of partial work. Some of the files may
> not even be supposed to be checked in.

Well, maybe forget about files that you don't expect to keep, but
committing partial work is fine.  It's only in your local checkout,
after all; once you've got something worth sharing you can rearrange the
commits so they make sense.

[...]
