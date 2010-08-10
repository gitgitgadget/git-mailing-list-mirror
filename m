From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Git and Documentation
Date: Tue, 10 Aug 2010 22:31:51 +0200
Message-ID: <4C61B737.50108@dbservice.com>
References: <AANLkTik_rO_+az5kE=yhfXK1uUO3v0RKdcO2hzFBcZym@mail.gmail.com>	<AANLkTi=P=RsToSor=giC+dgV24bPj7KJ3eRV1M5a+iuD@mail.gmail.com>	<AANLkTi=pk4oXz84kWbHEzTUiWkTV5P4P9mTwzQbJG865@mail.gmail.com> <AANLkTikwVfymGB8oEQUN=1LMWoif22p316mm=PzSxQwa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sultan Shakir <sshakirflhosp@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 22:32:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OivUW-00019F-3V
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 22:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838Ab0HJUb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 16:31:58 -0400
Received: from office.neopsis.com ([78.46.209.98]:57375 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab0HJUb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 16:31:57 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.040,BAYES_00: -1.665,TOTAL_SCORE: -1.625,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Tue, 10 Aug 2010 22:31:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTikwVfymGB8oEQUN=1LMWoif22p316mm=PzSxQwa@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153155>

On 8/10/10 9:55 PM, Sultan Shakir wrote:
> Yes I guess I could.  I am a little new at this.   I got the same ide=
a
> after watching Stephen Wood's video here:
> http://developer.yahoo.com/yui/theater/video.php?v=3Dwoods-yuiconf200=
9-yuidoc
> .  He had 3 rules/guidelines that might work if we use YUI Doc to
> generate the documentation:
>=20
> 1) Generate documentation as part of the build
> 2) Don=92t manually check documentation in to VCS (do it automaticall=
y)
> 3) Treat documentation comments like code
>=20
> I am not sure how to make it run as part of my build process though.

Please don't top post.

If the documentation is generated as part of the build, then there is n=
o
reason to have it part of the history - you can always rebuild it from
the source. For the same reason you don't put compiled source into git.

And how to generate the doc as part of the build? That's up to you and
very much depends on what build system you use.

tom
