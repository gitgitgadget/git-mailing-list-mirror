From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads
Date: Tue, 03 Mar 2009 15:48:51 +0100
Message-ID: <87tz6aslv0.fsf@wine.dyndns.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
	<871vtnvo55.fsf@krank.kagedal.org> <87fxi3x2es.fsf@wine.dyndns.org>
	<87y6vvu8sa.fsf@krank.kagedal.org> <87bpsrx1j1.fsf@wine.dyndns.org>
	<87vdqztvrl.fsf_-_@krank.kagedal.org> <87prh1tc5y.fsf@wine.dyndns.org>
	<87zlg4qsfk.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Mar 03 15:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeVx6-0008H1-QY
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 15:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZCCOtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 09:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbZCCOtG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 09:49:06 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:45172 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbZCCOtF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 09:49:05 -0500
Received: from adsl-84-227-12-10.adslplus.ch ([84.227.12.10] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LeVvR-0004Qf-UR; Tue, 03 Mar 2009 08:49:00 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 68E011E7203; Tue,  3 Mar 2009 15:48:51 +0100 (CET)
In-Reply-To: <87zlg4qsfk.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of
	"Mon, 02 Mar 2009 08:45:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112078>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Yes, but the typical uses differ a lot. The (overwhelmingly) typical
> use of checkout is to switch to another branch. The typical use of
> cherry-pick is to pick any commit and not treat branch heads
> specially.
>
> So when switching branches, I obviously want a simple way to select
> which branch to switch to. When cherry-picking, I would need some
> simple way of picking any single commit, but that's hard so making it
> easy to pick any named commit is probably the reasonable solution.

It sounds like what you want is to customize it independently for each
operation. That would be better than having two completion functions,
where it's not clear how they differ and why only one can be
customized.

--=20
Alexandre Julliard
julliard@winehq.org
