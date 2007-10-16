From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 09/25] Port builtin-add.c to use the new option parser.
Date: Tue, 16 Oct 2007 04:55:41 -0400
Message-ID: <2209D123-A245-43C4-8DD9-A83386852556@mit.edu>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org> <1192523998-19474-8-git-send-email-madcoder@debian.org> <1192523998-19474-9-git-send-email-madcoder@debian.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 11:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhidG-0005MW-B5
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbXJPJWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbXJPJWX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:22:23 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:60464 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755843AbXJPJWX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 05:22:23 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9G9Ldlj006157;
	Tue, 16 Oct 2007 05:21:40 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9G8tgrm009188
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Oct 2007 04:55:42 -0400 (EDT)
In-Reply-To: <1192523998-19474-9-git-send-email-madcoder@debian.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61126>


On 16 Oct 2007, at 4:39:42 AM, Pierre Habouzit wrote:

> +	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update only files  
> that git already knows about"),

"update only files in the current directory that git already knows  
about"
