From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Simplify strbuf uses in fast-import.c using the proper
 functions.
Date: Wed, 05 Sep 2007 01:46:59 +0200
Message-ID: <46DDEE73.5020904@lsrfire.ath.cx>
References: <20070904115317.GA3381@artemis.corp> <11889144743483-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 01:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISi7D-000821-Oc
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 01:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbXIDXrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 19:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbXIDXrH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 19:47:07 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:51662
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754290AbXIDXrG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 19:47:06 -0400
Received: from [10.0.1.201] (p508EDAF7.dip.t-dialin.net [80.142.218.247])
	by neapel230.server4you.de (Postfix) with ESMTP id 8AA36873B5;
	Wed,  5 Sep 2007 01:47:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11889144743483-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57660>

Pierre Habouzit schrieb:
>   This is just cleaner way to deal with strbufs, using its API rather=
 than
> reinventing it in the module (e.g. strbuf_append_string is just the p=
lain
> strbuf_addstr function, and it was used to perform what strbuf_addch =
does
> anyways).
> ---
>  archive-tar.c |   65 ++++++++++++++---------------------------------=
----------
>  1 files changed, 16 insertions(+), 49 deletions(-)

Apart from the wrong subject line I really like this patch. :-D

Thanks!
Ren=E9
