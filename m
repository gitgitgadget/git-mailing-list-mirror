From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads, refs/remotes and refs/tags
Date: Tue, 24 Feb 2009 15:50:08 +0100
Message-ID: <87ocwrx527.fsf@wine.dyndns.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Feb 24 15:52:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbydQ-0003Q8-VJ
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 15:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbZBXOuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 09:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756567AbZBXOuU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 09:50:20 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:55448 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbZBXOuT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 09:50:19 -0500
Received: from adsl-84-227-31-184.adslplus.ch ([84.227.31.184] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Lbybq-0008NX-QV; Tue, 24 Feb 2009 08:50:17 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 5CFC81E7203; Tue, 24 Feb 2009 15:50:08 +0100 (CET)
In-Reply-To: <87fxi4ut2p.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of
	"Tue, 24 Feb 2009 09:39:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111292>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Sorry, I didn't check this properly. I thought I was fixing inside th=
e
> git-checkout function, but this is git-read-commit-name which is used
> in more than one place.
>
> But for git-checkout, I would like to see a much shorter list of name=
d
> commits, namely those that can be called "branches". I'll come up wit=
h
> a better patch.

I think it's reasonable to do this for the other uses of
git-read-commit-name too, so your original patch looks OK.

--=20
Alexandre Julliard
julliard@winehq.org
