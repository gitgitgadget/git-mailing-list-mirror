From: xpr1010 <volition1980@gmail.com>
Subject: Re: Combining/merging commits
Date: Tue, 15 Apr 2008 05:43:34 -0700 (PDT)
Message-ID: <6e6761f0-7457-4674-a935-92d00c294b21@b9g2000prh.googlegroups.com>
References: <8e0b7b96-aee8-45a4-a160-023e92845434@n1g2000prb.googlegroups.com> 
	<48044D15.6040801@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 14:44:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlkWa-00006Q-M1
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 14:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYDOMnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 08:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758574AbYDOMnu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 08:43:50 -0400
Received: from yw-out-2122.google.com ([74.125.46.27]:45480 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbYDOMnu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 08:43:50 -0400
Received: by yw-out-2122.google.com with SMTP id 1so1485528ywp.61
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 05:43:34 -0700 (PDT)
Received: by 10.100.214.15 with SMTP id m15mr502883ang.9.1208263414454; Tue, 
	15 Apr 2008 05:43:34 -0700 (PDT)
In-Reply-To: <48044D15.6040801@viscovery.net>
X-IP: 84.48.169.156
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; 
	rv:1.9b5) Gecko/2008032619 Firefox/3.0b5,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79595>

Worked. Thanks! :)

On 15 Apr, 08:37, Johannes Sixt <j.s...@viscovery.net> wrote:
> xpr1010 schrieb:
>
> > I have made several commits that should really have only been one, =
but
> > there was a lot of back and forth because of my inherent clumsiness=
=2E
> > Is there any way to combine or merge these commits to one?
>
> Say, you have this commit series:
>
> =A0...--A--B--C--D
>
> and you want to combine all of them, i.e. the last 4 commits, into a =
new
> one, then you can do:
>
> =A0 =A0 # undo commits, but leave working directory unchanged
> =A0 =A0 $ git reset HEAD~4
> =A0 =A0 # make a new commit
> =A0 =A0 $ git commit
>
> But if you want to combine only A,B,C because D should remain a separ=
ate
> commit (i.e. what you want to combine are *not* the last commits), th=
en
> use git rebase --interactive, in particular, the 'squash' instruction=
=2E You
> would use this todo list:
>
> =A0 =A0 pick A
> =A0 =A0 squash B
> =A0 =A0 squash C
> =A0 =A0 pick D
>
> -- Hannes
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majord...@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
