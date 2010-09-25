From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: what should git rev-parse --flags HEAD do?
Date: Sun, 26 Sep 2010 05:38:02 +1000
Message-ID: <AANLkTikW=4NiZ_jCq6geqta_XHiWJPUhWvvEtJ1Q3G9S@mail.gmail.com>
References: <AANLkTimEToibgpUS1KTSruFRdggi3kbAJU5tfk9r6d2U@mail.gmail.com>
	<7vfwwxogiv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 21:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozaa2-0001Ou-HJ
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab0IYTiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:38:05 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52538 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab0IYTiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:38:04 -0400
Received: by qwh6 with SMTP id 6so2511744qwh.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=hxX2En48S9uTtd0Coc6fZH2/BoK7VAGRCDWFwu5uxh0=;
        b=ZBaEhhVHNw5+Kbd1qlaZNyZsNZgQnQ0QwOY8AuhqrIA1XBIy7AV9PFTr6Vq1zSHyIV
         9JbFzpnSxQ2nNm6pliNeVdTVMw3gudDGcaouBR0KIJjqAL2FZgUDYpwKFGF7P+/WqzNp
         nrXEOa6ifXhF5XstVVKGEfS6v09qNeYF4ckCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vVYKMXcbW5uHowzs44W7qr0Cf+JttSBRD6kkwWzjKVxeneetIaUNKti1627LxsUCqH
         U6S1Z8pbDUnLq0WU4ku1xk+nMxexWg99foo6CKK7GqSR7fC7C2vNv6EzeeLoH04WFbIX
         OwHDsBjPJgiLEQse2PtaykaBfuUN31VxdFnlg=
Received: by 10.224.71.143 with SMTP id h15mr3675137qaj.217.1285443482549;
 Sat, 25 Sep 2010 12:38:02 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 12:38:02 -0700 (PDT)
In-Reply-To: <7vfwwxogiv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157191>

On Sun, Sep 26, 2010 at 3:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Perhaps you are missing --no-revs.
> ...

> "--flags" is an afterthought that filters out non-flags in other parts; I
> do not think it applied to the "rev" part (i.e. giving --no-revs at the
> same time would be a valid workaround if you know you do not want HEAD or
> any revision traversal argument) in any released version of git.
>

i am aware that --no-revs exists and can be used with --flags to
ensure that only flag arguments are displayed.

The issue is that the documentation currently implies that --flags
alone is sufficient to suppress anything that is not a flag when this
is not, in fact, the case.

If there is some reason --flags should not imply --no-revs, then the
documentation should be updated to state:

--flags::
