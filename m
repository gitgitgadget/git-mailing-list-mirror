From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Fri, 25 May 2012 22:03:21 +0200
Message-ID: <4FBFE589.1080805@kdbg.org>
References: <4FBAA33D.1080703@kdbg.org> <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com> <7vzk8yzq35.fsf@alter.siamese.dyndns.org> <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com> <7vehq9xz7a.fsf@alter.siamese.dyndns.org> <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com> <4FBE9AC7.3010506@kdbg.org> <7vaa0xw9dy.fsf@alter.siamese.dyndns.org> <4FBFAC19.8030108@kdbg.org> <7vy5ogtcxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 22:03:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0jT-0002Lx-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496Ab2EYUD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:03:27 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:7659 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768Ab2EYUD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:03:26 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8E5F3130049;
	Fri, 25 May 2012 22:03:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E706219F6EB;
	Fri, 25 May 2012 22:03:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <7vy5ogtcxm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198516>

Am 25.05.2012 18:58, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> First-parentship. When a topic or an integration branch is rebased (with
>> --preserve-merges), only the first-parent chain should be rewritten.
> 
> While I think the "start from commit T and down to where it branches off
> of 'master', rebuild first-parent chain on top of elsewhere" mode has
> uses, there is no way it can co-exist under the same option name with the
> current "transplant the DAG as a whole on top of elsewhere, preserving the
> topology inside the DAG" mode.

Fair enough.

>  The name "preserve merges" clicks with the
> latter mode better than the former mode, at least to me.  Perhaps the
> other mode can be called "rebase --first-parent" or something?

Sounds good. I'll take this route.

-- Hannes
