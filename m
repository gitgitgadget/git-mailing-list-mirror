From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in archive
 files)
Date: Tue, 04 Sep 2007 07:45:19 +0200
Message-ID: <46DCF0EF.9020604@op5.se>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRE7-0001yU-VD
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbXIDFpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXIDFpX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:45:23 -0400
Received: from mail.op5.se ([193.201.96.20]:46075 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbXIDFpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:45:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9AB82194424;
	Tue,  4 Sep 2007 07:45:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRK9rACYkSSd; Tue,  4 Sep 2007 07:45:21 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id DCE6D1943D3;
	Tue,  4 Sep 2007 07:45:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57523>

Junio C Hamano wrote:
> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> The attribute is useful for creating auto-updating specfiles.  It is
>> limited by the underlying function format_commit_message(), though.
>> E.g. currently there is no placeholder for git-describe like output,
>> and expanded specfiles can't contain NUL bytes.  That can be fixed
>> in format_commit_message() later and will then benefit users of
>> git-log, too.
>=20
> Interesting.  I however wonder if "specfile" is a good name for
> this attribute, although I admit I do not think of anything
> better offhand.
>=20

"releasefile", perhaps?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
