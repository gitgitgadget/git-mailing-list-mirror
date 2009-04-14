From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/8] archive: add a failure test wrt .gitattributes 	misreading
Date: Tue, 14 Apr 2009 22:12:57 +0200
Message-ID: <49E4EE49.6030404@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> 	<1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> 	<1239185133-4181-4-git-send-email-pclouds@gmail.com> <7vab6rkl5f.fsf@gitster.siamese.dyndns.org> 	<49E3448B.8010602@lsrfire.ath.cx> <fcaeb9bf0904132341s777ca697p1930df10eb1ff37b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:15:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltp1u-00076k-SE
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbZDNUNS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 16:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbZDNUNS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:13:18 -0400
Received: from india601.server4you.de ([85.25.151.105]:49406 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZDNUNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:13:17 -0400
Received: from [10.0.1.101] (p57B7E023.dip.t-dialin.net [87.183.224.35])
	by india601.server4you.de (Postfix) with ESMTPSA id 586172F8056;
	Tue, 14 Apr 2009 22:13:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <fcaeb9bf0904132341s777ca697p1930df10eb1ff37b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116563>

Nguyen Thai Ngoc Duy schrieb:
> 2009/4/13 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
>> Also, the last sentence of the description may be taken to imply a
>> mixing of attributes from work tree and exported tree is done, which=
 is
>> not the case with the patch from series 2 (and shouldn't be).  Perha=
ps:
>> "With this option, .gitattributes files are read from the work tree
>> instead of from the exported tree."
>=20
> I'm at work and haven't had chance to read other mails carefully. Wrt
> to the description, it reads from index too if it fails to read from
> worktree. So perhaps "With this option, .gitattributes files are read
> from work tree (or from index if they are missing from work tree)
> instead of from exported tree.", unless you want to introduce another
> "attr direction" to read from work tree only.

Err, yes, that was nonsense, please disregard this part.  Sorry.  I
somehow mixed up falling back to the index and merging the contents of
attribute files from both sources, not sure why. :-/

Ren=C3=A9
