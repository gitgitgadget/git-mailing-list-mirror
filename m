From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Re: Rerunning merge on a single file
Date: Tue, 14 Oct 2008 14:48:01 +0200
Message-ID: <48F49501.3010005@trolltech.com>
References: <48F48CDB.1010309@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 14:49:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpjL1-0005Iw-Pn
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 14:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbYJNMsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Oct 2008 08:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbYJNMsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 08:48:09 -0400
Received: from hoat.troll.no ([62.70.27.150]:53767 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178AbYJNMsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 08:48:08 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id D206F20545;
	Tue, 14 Oct 2008 14:48:03 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id C8B6A2045D;
	Tue, 14 Oct 2008 14:48:03 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m9ECm0XW030401;
	Tue, 14 Oct 2008 14:48:01 +0200
Received: from [172.24.106.14] ( [172.24.106.14])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 14 Oct 2008 14:48:00 +0200 (CEST)
In-Reply-To: <adf1fd3d0810140521g7f43ee3bs5d4e60772bcc1d8c@mail.gmail.com>
References: <adf1fd3d0810140521g7f43ee3bs5d4e60772bcc1d8c@mail.gmail.com>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080519)
X-Enigmail-Version: 0.95.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98186>

Santi B=E9jar wrote:
> On Tue, Oct 14, 2008 at 2:13 PM, Kristian Amlie
> <kristian.amlie@trolltech.com> wrote:
>> Hey, I have question about advanced merging.
>>
>> Suppose I have a huge merge with conflicts all over the place. There=
 is no
>> way to avoid them, so I start working from the top. At some point, h=
owever,
>> I make a mistake and lose the merge information for one file (for ex=
ample by
>> checking out the file from HEAD).
>>
>> In that case I would like to get the conflict markers back, and do t=
hat file
>> over again, but I don't want to throw away the rest of the index sta=
te.
>> Currently the only way I can see to do this is by checking out sever=
al file
>> versions under different names and then using git merge-file on them=
=2E
>>
>> Is there a better way to achieve this?
>=20
> If the different versions are still in the index you could use:
>=20
> $ git checkout --merge $file

In my case the files were added to the index already, so I guess it=20
doesn't work then?

Kristian
