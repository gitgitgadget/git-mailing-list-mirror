From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 07/10] git-fmt-merge-msg: make it useable from other builtins
Date: Mon, 09 Jun 2008 10:58:28 +0200
Message-ID: <484CF0B4.6000102@op5.se>
References: <cover.1212698317.git.vmiklos@frugalware.org> <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 10:59:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5dDw-0004ow-IJ
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 10:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095AbYFII6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 04:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757059AbYFII6b
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 04:58:31 -0400
Received: from mail.op5.se ([193.201.96.20]:59558 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756803AbYFII6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 04:58:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 84DE41B80BFE;
	Mon,  9 Jun 2008 10:54:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCibqIhSqJKs; Mon,  9 Jun 2008 10:54:39 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 7C13A1B800AE;
	Mon,  9 Jun 2008 10:54:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84373>

Miklos Vajna wrote:
> Move all functionality (except config and option parsing) from
> cmd_fmt_merge_msg() to fmt_merge_msg(), so that other builtins can use
> it without a child process.
> 
> All functions have been changed to use strbufs, and now only
> cmd_fmt_merge_msg() reads directly from a file / writes anything to
> stdout.
> 

I have a very nearly identical patch in an ancient offshoot branch
since my attempt to make git-pull a builtin (which was stupid as
it doesn't do anything CPU-intensive apart from merging).

I likes it. For bonus points you could replace some strbuf_addf()
calls with strbuf_addstr() ones, but I don't think anyone really
cares.

So, fwiw,
Liked-by: Andreas Ericsson <ae@op5.se>

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
