From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [RFC] allow file list editing during cg-commit
Date: Mon, 9 May 2005 17:24:11 +0200
Message-ID: <20050509152411.GA24779@diku.dk>
References: <20050509041459.GA13475@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 09 17:44:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVA25-0003DT-6Z
	for gcvg-git@gmane.org; Mon, 09 May 2005 17:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVEIPZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 11:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVEIPZm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 11:25:42 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:3314 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261427AbVEIPYM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 11:24:12 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 51CEB6E0CA8; Mon,  9 May 2005 17:24:10 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 1CC356E008D
	for <git@vger.kernel.org>; Mon,  9 May 2005 17:24:10 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5C3AB61FDE; Mon,  9 May 2005 17:24:11 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050509041459.GA13475@gate.ebshome.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Eugene Surovegin <ebs@ebshome.net> wrote Sun, May 08, 2005:
> I just started playing with cogito and failed to find _easy_ way to
> select which files will be committed and which won't. cg-commit seems
> to support specifying file list in command line, but this isn't very
> convenient when the list is big.

The commit message is already very self documenting so it would be great
if this feature was also documented there. Something like the following,
but clearer:

CG: -----------------------------------------------------------------
CG: Lines beginning with the CG: prefix are removed automatically.
CG: By deleting lines beginning with `CG:F' the associated file will
CG: be removed from the commit list.
CG: ...

-- 
Jonas Fonseca
