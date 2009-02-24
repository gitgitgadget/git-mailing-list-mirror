From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads, refs/remotes and refs/tags
Date: Tue, 24 Feb 2009 17:06:26 +0100
Message-ID: <87bpsrx1j1.fsf@wine.dyndns.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
	<871vtnvo55.fsf@krank.kagedal.org> <87fxi3x2es.fsf@wine.dyndns.org>
	<87y6vvu8sa.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Feb 24 17:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzpH-00089C-7w
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbZBXQGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 11:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156AbZBXQGh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 11:06:37 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:37518 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbZBXQGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 11:06:37 -0500
Received: from adsl-84-227-31-184.adslplus.ch ([84.227.31.184] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Lbznh-0001Bl-BO; Tue, 24 Feb 2009 10:06:35 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id E686C1E7203; Tue, 24 Feb 2009 17:06:26 +0100 (CET)
In-Reply-To: <87y6vvu8sa.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of
	"Tue, 24 Feb 2009 16:57:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111308>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Cherry-pick, yes. And checkout, sometimes. My problem is that I have =
a
> truckload of remote (svn) branches and that means I can't see the
> obvious checkout candidates for all the noise.
>
> But add "refs/remotes" and "refs/tags" to the last patch, and maybe w=
e
> have a good compromise.

We could of course make it customizable...

--=20
Alexandre Julliard
julliard@winehq.org
