From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3 v2] use cache for function names in hunk headers
Date: Mon, 27 Sep 2010 00:17:12 +0200
Message-ID: <4C9FC668.8070701@lsrfire.ath.cx>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at> <20100923070439.GA29764@localhost> <4C9F7450.9060208@lsrfire.ath.cx> <20100926204318.GA19588@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 27 00:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzzX5-0001ny-Tx
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 00:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214Ab0IZWRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 18:17:17 -0400
Received: from india601.server4you.de ([85.25.151.105]:41806 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210Ab0IZWRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 18:17:15 -0400
Received: from [10.0.1.100] (p4FC5675F.dip.t-dialin.net [79.197.103.95])
	by india601.server4you.de (Postfix) with ESMTPSA id 14A1A2F8084;
	Mon, 27 Sep 2010 00:17:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20100926204318.GA19588@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157263>

Am 26.09.2010 22:43, schrieb Clemens Buchacher:
> On Sun, Sep 26, 2010 at 06:26:56PM +0200, Ren=E9 Scharfe wrote:
>> -	/*
>> -	 * Be quite stupid about this for now.  Find a line in the old fil=
e
>> -	 * before the start of the hunk (and context) which starts with a
>> -	 * plausible character.
>> -	 */
>>
>> It also removes an outdated comment.
>=20
> Actually, in the default case, the comment is still correct and
> helpful IMO.

The first sentence was probably written before the match function becam=
e
configurable.  The second one could be moved to def_ff().

>> The inlining part should probably split out in its own patch..
>=20
> I am not sure what you mean here. Do you want to add the parameter
> funclineprev to the function and remove the function in the next
> page, or do you want to refactor the below into an inline function?

I'd suggest having a first patch for folding xdl_find_func() into
xdl_emit_diff() without any functional change (manually inlining it) an=
d
a second one for adding funclineprev etc..

Ren=E9
