From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Problems Fetching from HTTP?
Date: Thu, 1 Apr 2010 14:12:25 -0400
Message-ID: <k2tc115fd3c1004011112y38265ec1h53c8e297b47983b@mail.gmail.com>
References: <v2xc115fd3c1004010803g98a279e8mf395a0d14be4f6bd@mail.gmail.com> 
	<20100401162907.GA3783@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 01 20:12:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxOt1-0000Ww-8l
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 20:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab0DASMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 14:12:48 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:56453 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab0DASMq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 14:12:46 -0400
Received: by ywh2 with SMTP id 2so975602ywh.33
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ibnMA/QBtHrMl+q0tlIgndR5f1J/kyk/2ufjYhCRF7I=;
        b=PLETi5ZxG7hjfBoZWRsAhAPS8gFWWa7vlbu2zLT4dtexq9T75y439C0+FUyqrnpVz5
         TLkMKcQTtAuQLdiOQy8boadUd3DlgwlcmWDTp5kudt99teJ2eEQGG0yhEfTMMlgNQ5m2
         TA2Oj006oG8R69ZGFBUyApt8AmiCcEgk/HFsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=luH0Hfisb3RswEEoBLC8TPC7ExiNbc7ibzrnXM2YNZ9jYfgyXCJBI/gk9SSPJcX4sI
         8dF3ooZldpT0Vn6q8FV8E8eiOCzEsKzDpx4KlX7jh/60qLu2MXO3uVunAFQjkL39K9LY
         ZAnAPq+JqKbQ8STf8D8lokwINy2pI2DwmO+Oc=
Received: by 10.100.209.20 with HTTP; Thu, 1 Apr 2010 11:12:25 -0700 (PDT)
In-Reply-To: <20100401162907.GA3783@inner.home.ulmdo.de>
Received: by 10.101.101.13 with SMTP id d13mr2693711anm.249.1270145565154; 
	Thu, 01 Apr 2010 11:12:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143738>

On Thu, Apr 1, 2010 at 12:29 PM, Andreas Krey <a.krey@gmx.de> wrote:
> On Thu, 01 Apr 2010 11:03:20 +0000, Tim Visher wrote:
> ...
>> =C2=A0 =C2=A0 error: Failed connect to git.kernel.org:80; Connection=
 refused
>> while accessing http://git.kernel.org/pub/scm/git/git.git/info/refs
>>
>> =C2=A0 =C2=A0 fatal: HTTP request failed
>>
>> What could be going on here? =C2=A0I can't pull from `git://` as I'm=
 behind
>> a firewall.
>
> It pretty much looks like the firewall doesn't let you directly acces=
s
> HTTP as well. You may need to use your proxy, and you (seem to) need =
to
> set the environment variable 'http_proxy=3D"http://10.0.0.1:3128"' to
> point to your proxy. Google will take you from there, like
> http://rip747.wordpress.com/2008/09/12/git-clone-over-http-who-knew/

Strange.  I suppose they reconfigured the firewall recently as I never
had to set that before and I've tracked git through http for over a
year.  I ended up setting `http.proxy` in ~/.gitconfig.

Thanks!

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
