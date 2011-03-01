From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Tue, 01 Mar 2011 12:16:35 +0100
Message-ID: <4D6CD593.2090705@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 12:20:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuNcd-0008It-Pm
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 12:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab1CALUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 06:20:01 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44637 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755822Ab1CALUA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 06:20:00 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 184E220782;
	Tue,  1 Mar 2011 06:20:00 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 01 Mar 2011 06:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=I1+N98qc8wxdhSCpulMX+7g8hHQ=; b=jyKyz8cGQV0/j6i1jVDHKT0EDVQ0UCYkQ12g5VqhgKXs/ujG2PBZn8Q5+j9okjYxmEcbmZiTlv860en76/XUOvBk/B+IeK1f4sbKFd7W+6+15xTghlyn+levdXvlKD0XohYbJO/7R402EXv8hqm69aVMklEFGHoe2xpPmJiZb6s=
X-Sasl-enc: 89UYielWASQ39rDvh5QRA1V4CI7hPaDjJf/mG665JhAw 1298978399
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 78481442B4A;
	Tue,  1 Mar 2011 06:19:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168210>

Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 12:13:
> 2011/3/1 Michael J Gruber <git@drmicha.warpmail.net>:
>> Introduce a leading ':' as the notation for repo-wide pathspecs.
>>
>> This is in line with our treeish:path notation which defaults to
>> repowide paths.
>>
>> Heck: Even ':./path' works for pathspecs, and I have no clue why!
> 
> If you are going to turn pathspecs into something more complex,
> reserve room for future extension. I have negative pathspecs that can
> utilize it.
> 
> I take it, from now on people must refer file name ':foo' as './:foo'
> with your patch?

That is up for discussion, of course. When discussing a new approach for
file mode dependent attributes, I was hoping to get through with
symlink:path, and did not. But it was decided that something like
:symlink:path would be good enough, in the sense of avoiding enough
possible conflicts. That made me hope that :path would be, too.

(I have not checked for interaction of those two, which are in flight.)

I would think that file names like ":foo" are problematic on msys
already, so in a sense they are no-no already, and free to take as
special notation.

Michael
