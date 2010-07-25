From: Sam Vilain <sam@vilain.net>
Subject: Re: [WIP/RFC 00/13] git notes merge
Date: Sun, 25 Jul 2010 18:45:25 +0800
Message-ID: <1280054725.2196.40.camel@arcturus>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jul 25 18:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od3n9-0005tc-VH
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 18:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab0GYQLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 12:11:00 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57322 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab0GYQK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 12:10:59 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 0C2D821C995; Mon, 26 Jul 2010 04:10:59 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DATE_IN_PAST_03_06 autolearn=no version=3.2.5
Received: from [192.168.43.144] (unknown [121.90.142.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 115D621C357;
	Mon, 26 Jul 2010 04:10:53 +1200 (NZST)
In-Reply-To: <1279880104-29796-1-git-send-email-johan@herland.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151757>

On Fri, 2010-07-23 at 12:14 +0200, Johan Herland wrote:
> Hi,
> 
> Here are some rough patches implementing most of the 'git notes merge'
> functionality. There are still missing pieces in the area of manual
> conflict resolution, but what's here should be enough to start
> experimenting with automatic notes merge resolution.

Having implemented this before as a client-level solution I can applaud
the goal of tackling this.

There is also the issue of making the notes track automatically on 'git
clone' or something like that, don't know if anyone's looked at it yet
but that's another annoyance I've had..

Sam
