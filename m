From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads
Date: Sun, 01 Mar 2009 17:56:09 +0100
Message-ID: <87prh1tc5y.fsf@wine.dyndns.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
	<871vtnvo55.fsf@krank.kagedal.org> <87fxi3x2es.fsf@wine.dyndns.org>
	<87y6vvu8sa.fsf@krank.kagedal.org> <87bpsrx1j1.fsf@wine.dyndns.org>
	<87vdqztvrl.fsf_-_@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Mar 01 17:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldoz7-0002te-VE
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 17:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbZCAQ4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 11:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbZCAQ4V
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 11:56:21 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:37865 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbZCAQ4U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 11:56:20 -0500
Received: from [84.226.227.236] (helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LdoxY-0008PB-6C; Sun, 01 Mar 2009 10:56:18 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id A7EF21E7203; Sun,  1 Mar 2009 17:56:09 +0100 (CET)
In-Reply-To: <87vdqztvrl.fsf_-_@krank.kagedal.org> ("David =?utf-8?Q?K?=
 =?utf-8?Q?=C3=A5gedal=22's?= message
	of "Tue, 24 Feb 2009 21:39:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111854>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> ---
>
> Here is a version that can to both commit name lookup and branch name
> lookup, and with a configuration parameter that determines how to fin=
d
> branch names to complete on.

Why do you introduce a separate function for checkouts?  I don't see
much need to have a different set of completions for checkout
vs. cherry-pick, they both can be used with an arbitrary commit anyway.

--=20
Alexandre Julliard
julliard@winehq.org
