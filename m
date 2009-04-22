From: Sam Vilain <sam@vilain.net>
Subject: topgit infinite loop
Date: Wed, 22 Apr 2009 23:57:49 +1200
Message-ID: <1240401469.3889.2.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Apr 22 13:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwb73-00068j-IR
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 13:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZDVL6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 07:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbZDVL6D
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 07:58:03 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60116 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbZDVL6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 07:58:01 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E3AEA21C406; Wed, 22 Apr 2009 23:57:43 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 3841821C2F1;
	Wed, 22 Apr 2009 23:57:39 +1200 (NZST)
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117194>

Using the current topgit master, I did a 'tg depends add' and somehow
seem to have found an infinite loop; see http://gist.github.com/99752

I've pushed all my t/* branches to github.com/samv/git - the t/*
branches.  Any obvious idea what went wrong?

Thanks for writing tg!
Sam.
