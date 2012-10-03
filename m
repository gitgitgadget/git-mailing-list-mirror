From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 22:30:53 +0200
Message-ID: <m2a9w3nvr6.fsf@igel.home>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<m2fw5vooem.fsf@linux-m68k.org>
	<CAB9Jk9Dqoom-hBQPG5iqe2JyiJtVoFWZ9-5W9ktUsa9F9mbXRQ@mail.gmail.com>
	<m2r4pf1xh6.fsf@igel.home>
	<CAB9Jk9Bqq=fs4v-oAj_TiaSw5WOiQQFsm_WEZP_ECyPW1L_DHg@mail.gmail.com>
	<m2fw5va4jc.fsf@igel.home>
	<CAB9Jk9Aa4d4H5q1euCJ4hdc_K9iBrfiJFnyAYQ+BRNX3D023gg@mail.gmail.com>
	<m2iparnztj.fsf@igel.home>
	<CAB9Jk9De4h=X3A8ypW6FG6L3B8katmTxhaPY9zhQ+UP1WJd6gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtJI-0001DP-DY
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab2JCUbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 16:31:03 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58904 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab2JCUbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 16:31:01 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XX84t4hQcz3hhb0;
	Wed,  3 Oct 2012 22:30:54 +0200 (CEST)
X-Auth-Info: aQN5lbRJk4YvwqS3ILgjrmXseTV04j9Vfh85HL3Pq0k=
Received: from igel.home (ppp-93-104-158-56.dynamic.mnet-online.de [93.104.158.56])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XX84t48MkzbbhB;
	Wed,  3 Oct 2012 22:30:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 18E22CA2B8; Wed,  3 Oct 2012 22:30:54 +0200 (CEST)
X-Yow: Just to have MORE FUN, I'll pretend I am JAMES CAGNEY and I am having
 a tense, UP-TIGHT EXPERIENCE!!
In-Reply-To: <CAB9Jk9De4h=X3A8ypW6FG6L3B8katmTxhaPY9zhQ+UP1WJd6gg@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 21:11:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206936>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> as a user, and owner of a repository I do care about the objects that are in it.

There is no need to care.

> I do not understand this: I have produced several examples that show that
> it is not created, i.e. that the very same objects are present in the repository
> after the command execution as they were before it.

That is just an implementation detail.  All you need to know is that a
ref has been created or modified.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
