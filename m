From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 05 Sep 2012 21:38:17 +0200
Message-ID: <5047AA29.2000003@dewire.com>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com> <20111206215102.GA3654@centaur.lab.cmartin.tk> <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com> <20111207220345.GA21596@sigill.intra.peff.net> <CAJ8P3RB=Gj-QCe6meqXSZ7N8+PnfNxSD8omUxT6dDh00bUf0QQ@mail.gmail.com> <CAJ8P3RA48W7ZiABvjkn_KkU-JPnCnaF_X_WK0wPtToph3DGDvg@mail.gmail.com> <20111207225827.GB641@centaur.lab.cmartin.tk> <20111207230625.GC21852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:38:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9LQh-0002Xa-W9
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 21:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240Ab2IETiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 15:38:21 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:45602 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab2IETiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 15:38:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id BD68182401;
	Wed,  5 Sep 2012 21:38:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZmsKW3G32IK; Wed,  5 Sep 2012 21:38:18 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h30n1fls32o828.telia.com [213.65.101.30])
	by zimbra.dewire.com (Postfix) with ESMTPSA id 649C682400;
	Wed,  5 Sep 2012 21:38:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20120828 Thunderbird/16.0
In-Reply-To: <20111207230625.GC21852@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204842>

Jeff King skrev 2011-12-08 00.06:
> On Wed, Dec 07, 2011 at 11:58:27PM +0100, Carlos Mart=C3=ADn Nieto wr=
ote:
>
>> If you want to use OSX to develop this project, you'll have to eithe=
r
>> rename one of those files or set your filesystem to be case-sensitiv=
e
>> (and unset core.ignorecase afterwards). From what I've heard, the OS
>> itself will work fine with a case-sensitive filesystem, but not all
>> applications might. YMMV.
>
> I've never done it, but my understanding is that for HFS+, going
> case-sensitive is not a simple flip of a switch, but you have to
> actually make a new filesystem. Given that complexity, and the fact t=
hat
> some other apps might not like it, your best bet might be to create a
> new case-sensitive filesystem in a loopback file, and then mount that
> just for this project.
>
> I'm not sure of the exact commands under OS X, but I'm sure some
> googling could probably turn up a solution.

The disk tool does this for you. Can't be much easier than it is.

-- robin
