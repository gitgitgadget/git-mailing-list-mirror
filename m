From: Wincent Colaiuta <win@wincent.com>
Subject: Re: commit summary, --pretty=short and other tools
Date: Tue, 18 Sep 2007 13:43:09 +0200
Message-ID: <E934A152-BE07-484D-96DF-11B1BC64EB49@wincent.com>
References: <20070917112136.GA30201@glandium.org> <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr> <46EF7BF7.3070107@op5.se> <Pine.LNX.4.64.0709181109130.28586@racer.site> <CEE6032F-39FB-42D8-A57A-671E4E0875C7@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:44:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXbUm-0002bL-9G
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbXIRLn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 07:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbXIRLnz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:43:55 -0400
Received: from wincent.com ([72.3.236.74]:44277 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbXIRLnz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2007 07:43:55 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8IBhH8i021100;
	Tue, 18 Sep 2007 06:43:17 -0500
In-Reply-To: <CEE6032F-39FB-42D8-A57A-671E4E0875C7@lrde.epita.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58583>

El 18/9/2007, a las 12:27, Benoit SIGOURE escribi=F3:

> OK, look, I think this is the typical case where there is no single =20
> solution to fit all use cases.
> To handle this specific case, you could say "OK let's stop at =20
> punctuation symbols then".  But what if my commit message is "Add =20
> namespace::member whatever."

Uh, I don't think you'd stop a punctuation symbol unless it was the =20
last non-whitespace character before the newline.

Even then, as Johannes says, "oneline" is only meant as a hint =20
anyway, so it doesn't really matter that much.

Wincent
