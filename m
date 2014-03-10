From: Tamer TAS <tamertas@outlook.com>
Subject: Re: [PATCH][GSOC2014] changed logical chain in branch.c to lookup
 tables
Date: Mon, 10 Mar 2014 14:47:43 -0700 (PDT)
Message-ID: <1394488063227-7605372.post@n2.nabble.com>
References: <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl> <CAPig+cS3H_8gZOuyro_Vt0ay3xphvsB92zFgwFfCdgKsXjU0Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 22:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN832-0000Dd-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbaCJVro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:47:44 -0400
Received: from sam.nabble.com ([216.139.236.26]:47102 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbaCJVrn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 17:47:43 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <tamertas@outlook.com>)
	id 1WN82x-0005Ds-7q
	for git@vger.kernel.org; Mon, 10 Mar 2014 14:47:43 -0700
In-Reply-To: <CAPig+cS3H_8gZOuyro_Vt0ay3xphvsB92zFgwFfCdgKsXjU0Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243822>

Eric Sunshine wrote
> Even allowing internationalization of them (via N_() in the location[]
> and type[] tables) might not be sufficient since grammatical rules
> differ from language to language.

I didn't fully understand what you meant by that. Since they were being
internationalized before using _() in the if-else bodies, wouldn't it
produce
the same output if I were to use the same method for location[] and type[]
tables?




--
View this message in context: http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605372.html
Sent from the git mailing list archive at Nabble.com.
