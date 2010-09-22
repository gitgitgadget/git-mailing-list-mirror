From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Thu, 23 Sep 2010 02:15:38 +0400
Message-ID: <AANLkTin27ny4f2rPZSRWDVj3gOF1oH0t17WmsKH8TYXz@mail.gmail.com>
References: <1285080133451-5555023.post@n2.nabble.com>
	<m3mxrak937.fsf@localhost.localdomain>
	<1285114417273-5557145.post@n2.nabble.com>
	<1AF8A1BC-1E52-4385-A0FC-16A04B4724FF@kellerfarm.com>
	<1285155943433-5558696.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 00:15:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyXbO-0007Re-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 00:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662Ab0IVWPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 18:15:42 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62568 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0IVWPl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 18:15:41 -0400
Received: by qyk33 with SMTP id 33so1375407qyk.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uQDs5kZ8a78GdaYy0XCCDWpu0rbJmUasix1SxJSy8zw=;
        b=SXmukwMalAz8dHTY5p3L58mfI6eq7PvTLhP/6gv4s5aPFVabJME/QF+9C7TjuzzOYT
         JvMFOmzcvqGFQjgmB0k82MaXW1HjdaGqGFLHl6ZZrV5vDktvvHIpU5fjIOzLKwNEJDb3
         8mUScvu97rt7N2f6o5L8z//4+HO5+Y+pcqDQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k7NiwFJmPJoCvWSz0sCyCyA4WoXuPoKCkYrSI4ejINwrrSIgr/IDKPAI+ZQ9WV7CgG
         ywwoYP5NyLgoLg3pTNcO3JJS91Z1CAJElt9rwNT6hkW/IrT6LpTs+KmKND3jZWPktn2A
         EpdqlFZaJR/1s571mcxyfBc8BjGEJwT7nvXZY=
Received: by 10.224.65.138 with SMTP id j10mr600318qai.147.1285193738955; Wed,
 22 Sep 2010 15:15:38 -0700 (PDT)
Received: by 10.229.215.6 with HTTP; Wed, 22 Sep 2010 15:15:38 -0700 (PDT)
In-Reply-To: <1285155943433-5558696.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156839>

On Wed, Sep 22, 2010 at 3:45 PM, FernandoBasso
<FernandoBasso.br@gmail.com> wrote:
>
> =A0On 09/22/2010 12:52 AM, Andrew Keller wrote:
>> The only thing is, in your example, since master did not progress si=
nce
>> testing diverged,
>> git simply thinks of it as being "behind" testing...
>
>
> You have used the word 'behind'. I think 'time' what is making me fai=
l to
> understand git merging. It depends on which branch I have changed las=
t.

Not really. Time is irrelevant, what matters is the common ancestor.
Please, run gitk and take a look at the history graph. I think it will =
make
some things obvious. They say one picture is worth a thousand words...


Dmitry
