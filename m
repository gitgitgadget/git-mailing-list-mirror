From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Noted that vi is the final choice of editor in git  
 help commit
Date: Wed, 14 Jan 2009 12:14:26 +0100
Message-ID: <496DC912.1070908@drmicha.warpmail.net>
References: <1231886016-31675-1-git-send-email-cfratrik@gmail.com> <20090114095512.GA29927@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Craig Fratrik <cfratrik@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?QWRlb2RhdG8gU2ltw7M=?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Wed Jan 14 12:16:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN3j1-0002fH-40
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 12:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZANLOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 06:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbZANLOa
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 06:14:30 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43150 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753338AbZANLO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 06:14:29 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 8A5D0211889;
	Wed, 14 Jan 2009 06:14:28 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 14 Jan 2009 06:14:28 -0500
X-Sasl-enc: iE8VBDk5faiUo2fqfhulEcwcAYmv5M901ZDCEefRmGmQ 1231931668
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C02522B678;
	Wed, 14 Jan 2009 06:14:27 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090114095512.GA29927@chistera.yi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105616>

Adeodato Sim=C3=B3 venit, vidit, dixit 14.01.2009 10:55:
> * Craig Fratrik [Tue, 13 Jan 2009 14:33:36 -0800]:
>=20
>>  The editor used to edit the commit log message will be chosen from =
the
>>  GIT_EDITOR environment variable, the core.editor configuration vari=
able, the
>> -VISUAL environment variable, or the EDITOR environment variable (in=
 that
>> -order).
>> +VISUAL environment variable, the EDITOR environment variable, or fi=
nally 'vi'
>> +(in that order).
>=20
> May I suggest:
>=20
>    The editor used to edit the commit log message will be chosen from=
 the
>    GIT_EDITOR environment variable, the core.editor configuration var=
iable, the
>    VISUAL environment variable, or the EDITOR environment variable (i=
n that
>   -order).
>   +order). If none of those are set, "vi" will be used.
>=20

+order). If none of those are set, "vi" will be used unless TERM is
+unset or set to "dumb".

There is also some special parsing of the value but I don't think it
needs to be advertised. The terminal-less case, on the other hand, may
be relevant for scripters and ssh'ers.

Cheers,
Michael
