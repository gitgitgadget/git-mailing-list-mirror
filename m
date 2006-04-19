From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 21:51:34 -0700
Message-ID: <4445C1D6.3070504@zytor.com>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org> <20060418175853.GA25688@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604181104420.3701@g5.osdl.org> <20060418182650.GB25688@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 06:51:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW4fL-0004PG-Vx
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 06:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDSEvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 19 Apr 2006 00:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWDSEvp
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 00:51:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62422 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750760AbWDSEvo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 00:51:44 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k3J4pdTn030676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Apr 2006 21:51:40 -0700
User-Agent: Thunderbird 1.5 (X11/20060313)
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20060418182650.GB25688@wohnheim.fh-wedel.de>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18908>

J=F6rn Engel wrote:
> On Tue, 18 April 2006 11:08:40 -0700, Linus Torvalds wrote:
>> On Tue, 18 Apr 2006, J=F6rn Engel wrote:
>>>> 	git clone git://git.kernel.org/... foo/
>>> Is it possible for non-owners of a kernel.org account to do this?
>> Yes, kernel.org runs the git daemon.
>=20
> Excellent!  I have a faint memory of hpa recently saying that the git
> daemon would be too resource-hungry.  One of the cases where being
> wrong is a Good Thing.
>=20

Well, we ended up making some tweaks to the git daemon, and it hasn't=20
been a problem since.

	-hpa
