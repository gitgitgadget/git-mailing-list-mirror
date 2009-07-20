From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Pulled files with "new file" status
Date: Mon, 20 Jul 2009 09:40:03 +0200
Message-ID: <4A641F53.9010901@viscovery.net>
References: <1e5bcefd0907192245j19aac1aar804a0e3bd637b46b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcelo de Moraes Serpa <celoserpa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 09:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSnU3-0000xa-IU
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 09:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZGTHkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 03:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbZGTHkO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 03:40:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16347 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbZGTHkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 03:40:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MSnTn-0004cS-Dc; Mon, 20 Jul 2009 09:40:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 22B424E4; Mon, 20 Jul 2009 09:40:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1e5bcefd0907192245j19aac1aar804a0e3bd637b46b@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123577>

Marcelo de Moraes Serpa schrieb:
> I git pulled again and get the updates
> from a friend, but the intriguing thing is that, the files that he
> added appeared as "new file" for me too. Why's that? I haven't been
> the one who added the file, he added it, why git would pull objects
> and tell me they are new ?

Perhaps because they *are* new for you?

  ------Y--M    <-- you
          /
   ------F      <-- your friend

If F added files, then you pull F, which creates the merge commit M, then
the files are also new for *you*.

I assume you were looking at the diff summary that 'git pull' reported.
This diff is the difference from Y to M, and in that diff, the files *are*
new because they are now in M, but not in Y.

-- Hannes
