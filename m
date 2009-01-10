From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: git submodule merge madness
Date: Fri, 9 Jan 2009 17:13:59 -0800
Message-ID: <F01C5A5A-1FA3-42EC-BEE7-46A6C0E7C5DF@develooper.com>
References: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 02:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSRh-00029K-EK
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337AbZAJBOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jan 2009 20:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755432AbZAJBOD
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:14:03 -0500
Received: from x8.develooper.com ([216.52.237.208]:52052 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbZAJBOB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jan 2009 20:14:01 -0500
Received: (qmail 9158 invoked from network); 10 Jan 2009 01:14:00 -0000
Received: from gw.develooper.com (HELO g5.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 10 Jan 2009 01:14:00 -0000
In-Reply-To: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105055>


On Jan 9, 2009, at 1:50 PM, Ask Bj=F8rn Hansen wrote:

> The typical problem is that we get an error trying to merge a "pre-=20
> submodule" branch into master:
>
> 	fatal: cannot read object 894c77319a18c4d48119c2985a9275c9f5883584 =20
> 'some/sub/dir': It is a submodule!
>
> Mark Levedahl wrote an example in July, but I don't think he got any =
=20
> replies:  http://marc.info/?l=3Dgit&m=3D121587851313303

Replying to myself for the archives:

Looking in the code I noticed it's the recursive merge algorithm =20
giving that error.  Making it use the resolve strategy ("git merge -s =20
resolve") made it work in the cases I had today, yay.

  - ask

--=20
http://develooper.com/ - http://askask.com/
