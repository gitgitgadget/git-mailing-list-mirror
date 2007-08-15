From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: git-commit goes awry after git-add -u
Date: Wed, 15 Aug 2007 23:21:48 +0900
Message-ID: <f9v266$uph$2@sea.gmane.org>
References: <f9v1t6$uph$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 16:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILJoD-0006A1-Ca
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 16:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbXHOOZM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756010AbXHOOZM
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 10:25:12 -0400
Received: from main.gmane.org ([80.91.229.2]:53940 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092AbXHOOZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 10:25:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ILJny-0000Sp-Vr
	for git@vger.kernel.org; Wed, 15 Aug 2007 16:25:03 +0200
Received: from cerberus.is.titech.ac.jp ([131.112.51.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 16:25:02 +0200
Received: from salikh by cerberus.is.titech.ac.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 16:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cerberus.is.titech.ac.jp
User-Agent: Thunderbird 2.0.0.4 (X11/20070708)
In-Reply-To: <f9v1t6$uph$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55907>

Salikh Zakirov wrote:
> Alternative sequence of commands, not involving 'git-add -u' produces
> correct results (without output for compactness)
> $ git add vm/em
> $ git rm -r vm/vmcore/src/util/ipf
> $ git rm -r vm/vmcore/src/util/em64t
> $ git rm -r vm/em/src/ia32

Sorry, forgot an important command in the sequence:
$ git commit -m moved

> $ git status
> # On branch master
> nothing to commit (working directory clean)
