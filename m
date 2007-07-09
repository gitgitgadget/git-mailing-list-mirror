From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 09 Jul 2007 20:04:35 +0200
Message-ID: <469278B3.40905@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org> <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707090142130.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7xbJ-0005yG-MT
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 20:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbXGISEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Jul 2007 14:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbXGISEm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 14:04:42 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:52499
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419AbXGISEl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 14:04:41 -0400
Received: from [10.0.1.201] (p508E48CD.dip.t-dialin.net [80.142.72.205])
	by neapel230.server4you.de (Postfix) with ESMTP id 028D13B00E;
	Mon,  9 Jul 2007 20:04:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <Pine.LNX.4.64.0707090142130.6977@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52009>

Daniel Barkalow schrieb:
> On Sun, 8 Jul 2007, Junio C Hamano wrote:
>=20
>> Are _identifiers with leading underscore Kosher thing to do, I
>> wonder...  We do have ones with trailing ones (mostly qsort
>> functions) and I think they are done that way for the sake of
>> standards conformance.
>=20
> I'm not sure; I inherited that bit of code from Julian. Do we have a=20
> standard idiom for a function that sets a bunch of static variables?

You could put all flags and settings into a struct fetch_pack_args.

You could then go one step further by exporting the struct definition
and letting the internal interface take a pointer to such a struct,
thereby getting rid of static variables and their setup routine.

Ren=E9
