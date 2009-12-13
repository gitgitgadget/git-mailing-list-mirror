From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Sun, 13 Dec 2009 23:47:04 +0100
Message-ID: <87ws0q5w5z.fsf@lysator.liu.se>
References: <20091208144740.GA30830@redhat.com>
	<7vfx7lcj18.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 23:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJxDt-0004y4-Pg
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 23:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbZLMWrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Dec 2009 17:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbZLMWrZ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 17:47:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:50690 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbZLMWrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 17:47:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NJxDm-0004ve-Jg
	for git@vger.kernel.org; Sun, 13 Dec 2009 23:47:22 +0100
Received: from 62.20.90.206 ([62.20.90.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 23:47:22 +0100
Received: from davidk by 62.20.90.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 23:47:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.20.90.206
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:rBQMO9+qCnnSLYzbGZsZ3ze1LWI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135154>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> Add --revisions flag to rebase, so that it can be used
>> to apply an arbitrary range of commits on top
>> of a current branch.
>
> I would suggest calling the option to invoke that hidden mode not
> "--revisions", but "--reverse" or "--opposite" or something of that
> nature, though.  It makes "rebase" work in different direction.

And there are no "revisions" in git. So using that term for anything
would only be confusing. Git has "commits" and various kinds of
references to them.

--=20
David K=C3=A5gedal
