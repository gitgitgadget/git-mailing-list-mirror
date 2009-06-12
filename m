From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: EasyGit Integration
Date: Fri, 12 Jun 2009 23:21:55 +0200
Message-ID: <200906122321.57479.jnareb@gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <200906110242.57475.jnareb@gmail.com> <94a0d4530906121357h63723278i7663c25707d3c754@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:22:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFECg-0007pd-Bw
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 23:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbZFLVWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 17:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZFLVWN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 17:22:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:61449 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbZFLVWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 17:22:12 -0400
Received: by fg-out-1718.google.com with SMTP id d23so36067fga.17
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IkF9CXswbwXY5EjL3NEuUflDrZpL5YYD0iOorASYo64=;
        b=R3uaBEoYW/JaDtoA9SrT6l8fd9t/uAL9vSL5HzgaNKbhLugdL62zJinx9LFiAsSBIK
         CB8vp+37/8/OYpiZAv/d9fn6K4ayrWM2XwhoHKmAOHI4WhBWf9SZs3AkxZIVinRevF1d
         oVNLo+guVBEHmDuvwveo5vhe2M8ZEGvG6mNRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HdqPqCGCUJ9ITiKsMs4IhsS9i2kEIVUSPFlVHpwAHU1vBzC1Q0qkQBw4Qnd/hdk589
         rYuHNF6cXB0jTnny3u4H14KVmqf2q10pmjcsxjdmlnV6saqwH1NdBLdKunJwHbTQ/R83
         2SoWh3nfBysvY86kVt5eYd04rZHd4/aCpI74g=
Received: by 10.86.23.20 with SMTP id 20mr4381155fgw.17.1244841733637;
        Fri, 12 Jun 2009 14:22:13 -0700 (PDT)
Received: from ?192.168.1.13? (abwe201.neoplus.adsl.tpnet.pl [83.8.228.201])
        by mx.google.com with ESMTPS id 12sm5097806fgg.15.2009.06.12.14.22.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 14:22:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530906121357h63723278i7663c25707d3c754@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121450>

On Fri, 12 Jun 2009, Felipe Contreras wrote:
> On Thu, Jun 11, 2009 at 3:42 AM, Jakub Narebski<jnareb@gmail.com> wro=
te:
>> On Thu, 11 June 2009, Felipe Contreras wrote:

>>> 'git reset' also gets something out of the repository and into the
>>> working area, that's not reason enough to put them under the same
>>> 'checkout' command, is it?
>>
>> Nope. 'git reset' resets something to the state in repository (to gi=
ven
>> commit). =C2=A0The fact that some combination of options for 'git re=
set' gives
>> the same result as some specific combination of options of 'git chec=
kout'
>> means only that one can arrive at some destination in two different =
ways.
>=20
> You can describe what 'git reset' does in many ways, but in the
> process it's still getting something out of the repository and into
> the working directory, does it not? 'git checkout <commitish>' and
> 'git checkout <commitish> -- <path>' also do that.

Nope. 'git reset' always reset some part of state to a given commit,
HEAD by default.  It can reset current branch with --soft, branch plus
index with --mixed (default), and branch plus index plus working=20
directory with --hard.  Source is always commit.

'git checkout' however checks out something into working directory.
It can be branch, in which turns it sets HEAD to point to it, and
index too.  It can be file, in which it gets version of file from
index or (if specified) from given commit.  Destination is always
working area (and sometimes something else beside it).

>=20
> Is that relevant? No. What is relevant is the final action the user i=
s
> expecting to achieve.
>=20
> Therefore, the fact that 'git checkout <commitish>' modifies the
> working directory is irrelevant, it's still doing an extra step;
> update HEAD, and that final action is what is important for this
> particular command; it switches to another commitish.

It is not uncommon for a word to have different meaning depending on
context, or on some auxiliary word used in addition...
--=20
Jakub Narebski
Poland
