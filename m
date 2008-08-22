From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH] Support "core.excludesfile = =?utf-8?b?fi8uZ2l0aWdub3JlIg==?=
Date: Fri, 22 Aug 2008 16:58:11 +0000 (UTC)
Message-ID: <loom.20080822T165656-932@post.gmane.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 18:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZz0-0003Nq-5X
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbYHVQ60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 12:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbYHVQ60
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 12:58:26 -0400
Received: from main.gmane.org ([80.91.229.2]:60002 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbYHVQ6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 12:58:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWZxs-0006ct-BO
	for git@vger.kernel.org; Fri, 22 Aug 2008 16:58:20 +0000
Received: from adsl-75-24-105-96.dsl.pltn13.sbcglobal.net ([75.24.105.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:58:20 +0000
Received: from raible by adsl-75-24-105-96.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:58:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.105.96 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93328>

Karl Chen <quarl <at> cs.berkeley.edu> writes:

> +static char const *git_config_subst_userdir(char const *value) {
> +	if (value[0] == '~' && value[1] == '/') {

Might you want to check that strlen(value) is at least 2?

- Eric
