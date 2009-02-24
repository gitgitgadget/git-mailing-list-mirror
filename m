From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads, refs/remotes and refs/tags
Date: Tue, 24 Feb 2009 16:47:23 +0100
Message-ID: <87fxi3x2es.fsf@wine.dyndns.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
	<871vtnvo55.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzWo-0000fI-2z
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbZBXPre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 10:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbZBXPre
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:47:34 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:33043 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbZBXPrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 10:47:33 -0500
Received: from adsl-84-227-31-184.adslplus.ch ([84.227.31.184] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LbzVF-0000vR-QM; Tue, 24 Feb 2009 09:47:31 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7E9AC1E7203; Tue, 24 Feb 2009 16:47:23 +0100 (CET)
In-Reply-To: <871vtnvo55.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of
	"Tue, 24 Feb 2009 16:40:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111302>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Alexandre Julliard <julliard@winehq.org> writes:
>
>> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>>
>>> Sorry, I didn't check this properly. I thought I was fixing inside =
the
>>> git-checkout function, but this is git-read-commit-name which is us=
ed
>>> in more than one place.
>>>
>>> But for git-checkout, I would like to see a much shorter list of na=
med
>>> commits, namely those that can be called "branches". I'll come up w=
ith
>>> a better patch.
>>
>> I think it's reasonable to do this for the other uses of
>> git-read-commit-name too, so your original patch looks OK.
>
> Actually, I'd like to go one step further. I'm only interested in
> branches, and only in branches I can commit to. So only asking for
> refs/heads seems the best solution.

I think that's going too far. It's useful to be able to checkout a tag,
or to cherry-pick from a remote branch.

--=20
Alexandre Julliard
julliard@winehq.org
