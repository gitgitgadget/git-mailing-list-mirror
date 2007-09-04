From: Wincent Colaiuta <win@wincent.com>
Subject: Re: HFS+ Unicode weirdness
Date: Tue, 4 Sep 2007 15:59:35 +0200
Message-ID: <040DB556-44BC-47AC-9085-2F1E9A68E9D8@wincent.com>
References: <052099D2-F79B-4063-82D3-BFB5D0102A55@wincent.com> <Pine.LNX.4.64.0709041359310.28586@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISYx8-0005Y0-Se
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbXIDOAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 10:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbXIDOAW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:00:22 -0400
Received: from wincent.com ([72.3.236.74]:40627 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbXIDOAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 10:00:21 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l84E0IEg012942;
	Tue, 4 Sep 2007 09:00:19 -0500
In-Reply-To: <Pine.LNX.4.64.0709041359310.28586@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57570>

El 4/9/2007, a las 15:00, Johannes Schindelin escribi=F3:

> Hi,
>
> On Tue, 4 Sep 2007, Wincent Colaiuta wrote:
>
>> On a brand new clone of git.git the file "gitweb/test/M?rchen" is =20
>> provoking
>> some weird behaviour running on Mac OS X and the toy HFS+ filesystem=
=2E
>
> Please search the mail archives.  This has come up quite a couple of
> times.

=46inally found it: for the record this thread seems to be relevant:

<http://marc.info/?l=3Dgit&m=3D117053359117549&w=3D2>

=46or what it's worth Subversion has exactly the same kind of problem =20
when only some developers in a team work on HFS. For example:

<http://svn.haxx.se/users/archive-2005-12/0373.shtml>
<http://subversion.tigris.org/issues/show_bug.cgi?id=3D2464>

Hopefully the wait for Apple to release a non-broken filesystem won't =20
be too long, ZFS being the most likely candidate at this stage.

Cheers,
Wincent
