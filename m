From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question about scm security holes
Date: Thu, 4 Mar 2010 22:19:13 -0500
Message-ID: <32541b131003041919u6a477b46s447a6aeb18f3b393@mail.gmail.com>
References: <hmp427$d6h$1@dough.gmane.org> <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com> 
	<43d8ce651003041900x66000be4s9a15ab0cde3a0fe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 04:23:11 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnO4r-0001yU-NR
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 04:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab0CEDTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 22:19:34 -0500
Received: from mail-yx0-f185.google.com ([209.85.210.185]:61952 "EHLO
	mail-yx0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab0CEDTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 22:19:34 -0500
X-Greylist: delayed 33488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2010 22:19:33 EST
Received: by yxe15 with SMTP id 15so1829848yxe.25
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 19:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4p7Rvp0eJp71VnTaSF2+hfmncey/tIBoj8tFa0zyryE=;
        b=Soi4Uav83AWjW5/4VssXOMb4sPTSt2gtc0B4HbrtDSpllveSNgahA03hKUoTpB6MPF
         TuaH0UljS571Jj6X9nkzkPUdONFxtpSmatbzvAQGXtb20zxl9Xr8c9uFPi5PT3rT1pUi
         ZOBK8h9xHq/0HFPfeCo9NZADt5CB9mO+ClpUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Fdw0FwjvFWAWiBC7J71VKRgl2kZHyPgbYuKF5MHbJw4vOH6y9XB56CHdmXo+vFpooA
         yUZ9QJusmLpZKVE7HILAGM1ygsTZYx2/PikCiHvAzteFv6s2sL+54mb10VeQ5hs6l8DB
         7AdxoeYgL+hEDKZfFc1JsQkGGOWvlKslIcULg=
Received: by 10.150.120.7 with SMTP id s7mr485952ybc.345.1267759173140; Thu, 
	04 Mar 2010 19:19:33 -0800 (PST)
In-Reply-To: <43d8ce651003041900x66000be4s9a15ab0cde3a0fe7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141557>

On Thu, Mar 4, 2010 at 10:00 PM, John Tapsell <johnflux@gmail.com> wrot=
e:
> On 5 March 2010 02:03, Avery Pennarun <apenwarr@gmail.com> wrote:
>> modified code would be a little more interesting. =A0git makes this =
sort
>> of thing pretty much impossible to do without it being *noticeable* =
at
>> least. =A0Traceable, not so much, because you can create a commit wi=
th
>> whatever committer/author names you want and then push them in.
>
> Which is why you simply record the username of whoever pushed them in=
=2E
> =A0This is what gitorious.org does etc.

Not bad, but it's still very hard to trace properly.  Imagine I pull
from a peer, then push my combined branch into the central repo.
It'll say I'm pushing in patches from me *and* my friend.  Did I forge
them or are they real?

Avery
