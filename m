From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 11:11:44 -0600
Message-ID: <flFRWuefszqSabGvIxamBeKJiW26VnyHEVC9IErJWJA@cipher.nrlssc.navy.mil>
References: <808wqhzjl9.fsf@tiny.isode.net> <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com> <20081215140834.GA3684@atjola.homenet> <20081215155610.GA11502@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:14:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCH0u-00087g-Pl
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbYLORMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYLORMa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:12:30 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54175 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYLORMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 12:12:30 -0500
Received: by mail.nrlssc.navy.mil id mBFHBiT6024169; Mon, 15 Dec 2008 11:11:44 -0600
In-Reply-To: <20081215155610.GA11502@mit.edu>
X-OriginalArrivalTime: 15 Dec 2008 17:11:44.0559 (UTC) FILETIME=[349F93F0:01C95ED8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103186>

Theodore Tso wrote:
> I've
> often wished for a --yes-I-know-what-I-am-doing-and-it's-unsafe-but-
> just-drop-the-unreachable-objects-cause-this-is-just-a-tracking-repository
> option to "git gc".

repack -a -d -l

Notice the lowercase 'a'.

git-gc calls repack with uppercase 'A' which is what causes the unreachable
objects to be unpacked. Little 'a', is for people who know what they are
doing, and want git to just drop unreachable objects.

-brandon
