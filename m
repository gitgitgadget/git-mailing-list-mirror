From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [LHF] making t5000 "tar xf" tests more lenient
Date: Sat, 05 Jan 2013 23:50:01 +0100
Message-ID: <50E8AE19.5030700@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E8722B.8010408@lsrfire.ath.cx> <7vsj6fpeys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:50:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrcZU-0003JX-PN
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 23:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab3AEWuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 17:50:05 -0500
Received: from india601.server4you.de ([85.25.151.105]:36972 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab3AEWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 17:50:04 -0500
Received: from [192.168.2.105] (p579BE462.dip.t-dialin.net [87.155.228.98])
	by india601.server4you.de (Postfix) with ESMTPSA id EE99EF4;
	Sat,  5 Jan 2013 23:50:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vsj6fpeys.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212733>

Am 05.01.2013 21:11, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Anyway, I don't think the pax headers are to blame here.
>
> Hmph, I am reasonably sure I saw a test that created an archive from
> a commit (hence with pax header), asked platform tar to either list
> the contents or actually extracted to the filesystem, and tried to
> ensure nothing but the paths in the repository existed in the
> archive.  When the platform tar implementation treated the pax
> header as an extra file, such a test sees something not in the
> repository and fails.

t5000 avoids that issue by comparing only the contents of a=20
subdirectory.  The script could do with a little cleanup, in any case.=20
Moving ZIP testing into its own file, more explicit pax header file=20
handling, speaking file and directory names, and modern coding style=20
would all be nice. :)

Ren=C3=A9
