From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Confusing text in git-prune.txt
Date: Fri, 16 Jan 2009 17:56:05 +0100
Message-ID: <4970BC25.7020007@viscovery.net>
References: <20090116165013.GA14196@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?QWRlb2RhdG8gU2ltw7M=?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:57:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNs0h-00072M-UQ
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640AbZAPQ4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbZAPQ4J
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:56:09 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10462 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbZAPQ4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 11:56:08 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LNrzK-0005np-Ac; Fri, 16 Jan 2009 17:56:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0F5E86C4; Fri, 16 Jan 2009 17:56:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090116165013.GA14196@chistera.yi.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105977>

Adeodato Sim=C3=B3 schrieb:
> From git-prune.txt:
>=20
>     [...] prunes all unpacked objects unreachable from any of
>     these head objects from the object database. In addition,
>     it prunes the unpacked objects that are also found in packs by
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     running git-prune-packed.
>=20
> How can "unpacked objects" be "found in packs"?

An object can exist more than once in the database. prune-packed remove=
s
the loose (unpacked) instance of the object if it also available in a p=
ack.

-- Hannes
