From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 2/2] git-blame.el: pick a set of random colors when blaming
Date: Wed, 28 Mar 2007 10:49:40 +0200
Message-ID: <878xdh4usb.fsf@morpheus.local>
References: <200703262101.l2QL1sGL012549@localhost.localdomain>
	<87bqifrs7r.fsf@morpheus.local>
	<200703271531.l2RFVwOM008315@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:11:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUC2-0007Gx-67
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564AbXC1JLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 05:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933330AbXC1JLm
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:11:42 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:35364 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbXC1JLl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 05:11:41 -0400
X-Greylist: delayed 1456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Mar 2007 05:11:41 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6017F200A20C;
	Wed, 28 Mar 2007 10:49:41 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26532-01-92; Wed, 28 Mar 2007 10:49:40 +0200 (CEST)
Received: from morpheus (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id BCB6C200A1FC;
	Wed, 28 Mar 2007 10:49:40 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 577AFBFF27; Wed, 28 Mar 2007 10:49:40 +0200 (CEST)
In-Reply-To: <200703271531.l2RFVwOM008315@localhost.localdomain> (Xavier Maillard's message of "Tue, 27 Mar 2007 17:31:58 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43360>

Xavier Maillard <zedek@gnu.org> writes:

> Hi,
>
>    > I thought it would be cooler to have different set of colors eac=
h time
>    > I blame.
>
>    But the code for it looks weird:
>
> Why ? It looks good to me except the "small" quircks :)

I meant that it's doing strange things, like
 (or always-true-expression git-blame-ancient-color)

> I kept cl but I surrounded it into an eval-when-compile form as
> requested by elisp standards.

You are probably right.

--=20
David K=C3=A5gedal
