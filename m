From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Oct 2011, #07; Wed, 19)
Date: Fri, 21 Oct 2011 15:47:12 +0200
Message-ID: <20111021134712.GA4895@goldbirke>
References: <7vk480bq5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 15:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHFRU-0003h8-10
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 15:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122Ab1JUNrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 09:47:16 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:39608 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab1JUNrP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 09:47:15 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 21 Oct
 2011 15:47:09 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 21 Oct
 2011 15:47:12 +0200
Content-Disposition: inline
In-Reply-To: <7vk480bq5q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184061>

Hi,


On Wed, Oct 19, 2011 at 02:57:37PM -0700, Junio C Hamano wrote:
> * sg/complete-refs (2011-10-15) 10 commits
>  - completion: remove broken dead code from __git_heads() and __git_t=
ags()
>  - completion: fast initial completion for config 'remote.*.fetch' va=
lue
>  - completion: improve ls-remote output filtering in __git_refs_remot=
es()
>  - completion: query only refs/heads/ in __git_refs_remotes()
>  - completion: support full refs from remote repositories
>  - completion: improve ls-remote output filtering in __git_refs()
>  - completion: make refs completion consistent for local and remote r=
epos
>  - completion: optimize refs completion
>  - completion: document __gitcomp()
>  - Merge branches 'tm/completion-push-set-upstream', 'tm/completion-c=
ommit-fixup-squash' and 'sg/completion' into HEAD

I think an octopus merge is unnecessary there, because
tm/completion-push-set-upstream is an independent change, and
sg/completion builds on top of tm/completion-commit-fixup-squash.  So
you could just merge sg/completion into HEAD.


Best,
G=E1bor
