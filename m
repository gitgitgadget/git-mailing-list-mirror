From: Jeff King <peff@peff.net>
Subject: Re: unable to push
Date: Sun, 1 Jun 2008 14:24:17 -0400
Message-ID: <20080601182417.GB742@sigill.intra.peff.net>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net> <48418242.1050606@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, git@vger.kernel.org
To: Adam =?utf-8?Q?Pi=C4=85tyszek?= <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:25:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2sEy-00042E-A0
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbYFASYU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2008 14:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYFASYU
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:24:20 -0400
Received: from peff.net ([208.65.91.99]:2984 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYFASYT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:24:19 -0400
Received: (qmail 32613 invoked by uid 111); 1 Jun 2008 18:24:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 01 Jun 2008 14:24:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jun 2008 14:24:17 -0400
Content-Disposition: inline
In-Reply-To: <48418242.1050606@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83457>

On Sat, May 31, 2008 at 06:52:18PM +0200, Adam Pi=C4=85tyszek wrote:

>>> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote public
>>> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        HEAD
>>> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        refs/heads/localmas=
ter
>>
>> So you have only one branch, "localmaster".
>>
>>> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote .
>>> 71ab4eea48eb3407a2ff4eef2befe9251897d676        HEAD
>>> 71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/heads/master
>>
>> But the remote has only one branch, "master".
>>
>> If you want to push your localmaster to his master, you can do:
>>
>>   git push origin localmaster:master
> [...]
>
> I guess Peef described it the opposite way. In my opinion "localmaste=
r" =20
> is the only branch on the remote "public" repository and the local =20
> repository has only one "master" branch.

Oh, sorry, I did totally read that backwards. So yes, there is a local
"master" branch but not a remote master branch (instead it has
"localmaster"). So the problem is the same (push without a refspec
pushes matching refs, and you don't have any matches) but the fix is, a=
s
Adam pointed out:

> So to push local "master" to the remote "localmaster" branch you shou=
ld use:
>
>   git push public master:localmaster

Sorry for the confusion.

-Peff
