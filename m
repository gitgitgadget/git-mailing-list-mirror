From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to
 stop git-svn
Date: Wed, 05 May 2010 10:02:35 +1200
Message-ID: <1273010555.20723.17.camel@denix>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com>
	 <1271880470.20208.47.camel@denix>
	 <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com>
	 <4BCF8E07.9080507@vilain.net>
	 <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com>
	 <20100503211942.GA1380@dcvr.yhbt.net>
	 <4BDFC171.5010103@drmicha.warpmail.net>
	 <20100504183452.GA30894@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Olson <mwolson@gnu.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, Tim Stoakes <tim@stoakes.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 05 00:03:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9QCi-0005gF-8a
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 00:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934260Ab0EDWCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 18:02:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:46840 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934206Ab0EDWCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 18:02:49 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 51F1B21CEC8; Wed,  5 May 2010 10:02:37 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id A616D21C541;
	Wed,  5 May 2010 10:02:31 +1200 (NZST)
In-Reply-To: <20100504183452.GA30894@dcvr.yhbt.net>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146351>

On Tue, 2010-05-04 at 18:34 +0000, Eric Wong wrote:
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
> > Uhm, which one: The one in your subject line or the one in the quoted
> > subject line?
> 
> Sam's patch:
>   Subject: [PATCH] git-svn: deal with svn cherry-picks with non-linear history
> 
> Where he said:
> > >>> Oh, right ... I remember that issue now. I'm currently testing the
> > >>> below change to see if it breaks the test suite; any issues and I'll
> > >>> post an update.
> 
> Sorry for the confusion

Sorry for not following up - it didn't cause any test suite breakages
when I tested it.  Especially if Michael has had joy with it I'd say
it's good to go...

Sam
