From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: Re: git push don't setup tracking?
Date: Thu, 14 May 2009 10:52:19 +0200
Message-ID: <1de9d39c0905140152y2059840x809dcd36d63d1a32@mail.gmail.com>
References: <1de9d39c0905110446h5a0b54e3ic7cf58dda24d4bc4@mail.gmail.com>
	 <20090514063451.GB10411@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 10:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Wg8-0003XX-Bs
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 10:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759274AbZENIwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 04:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757824AbZENIwV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 04:52:21 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:24422 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760898AbZENIwU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 04:52:20 -0400
Received: by an-out-0708.google.com with SMTP id d40so2316292and.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vyt9GywZujuMt3+/o4WLDbHIHj6Y8/RlbUDB0PqEQ2o=;
        b=RXbKc4SCJbTwdKEeOEVs1atauJMSUMJn8zEw/DPOobN2fJxLk+Vz1zL89Y/0UYTwGn
         tpnhB8DxjscG31IWvlWNezQidcmkfvMeCaHE6daauAI4sMUB/o3n2GiPDfYodG+SarC6
         d38r2GRhAfSzbgzoKkrhpUETHia8HYLL4vcTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jqS/E/dVZnrHvuY6zxJmufZEx/hIpuc5jvSqIjj6XCGhGoMFFW9Bz9LS1UDivn7oLs
         0KDeVVyg0yGjDEZy4mM6V0+oEcQ0qU9fyVUpBoWqhrQEzkP3b51ObP5FIOlfTHvrJKDn
         v8eResLQ+6f41KSK3hOqYuipym4cHPeBOJgAY=
Received: by 10.100.213.13 with SMTP id l13mr2825164ang.110.1242291139595; 
	Thu, 14 May 2009 01:52:19 -0700 (PDT)
In-Reply-To: <20090514063451.GB10411@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119172>

On Thu, May 14, 2009 at 8:34 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 11, 2009 at 01:46:10PM +0200, jean-luc malet wrote:
>
>> I want to use git in a "star" configuration.
>> I have =C2=A0"repository" and 2 client "home" and "work"
>> I cloned repository on home and work, then I created a branch at wor=
k,
>> and pushed it to repository, at home I "git branch --track
>> origin/newbranch" and done some work... all ok there... then I pushe=
d
>> again to repository
>> come back at work I wanted just to do a git pull.... and there it sa=
ys
>> me that it don't have any tracking information... so I add to add by
>> hand the following lines into .git/config :
>> [branch "newbranch"]
>> =C2=A0 =C2=A0 =C2=A0 remote =3D origin
>> =C2=A0 =C2=A0 =C2=A0 merge =3D refs/heads/newbranch
>>
>> and now it's working.... I think there shall be a way like "git push
>> --track newbranch origin" so it store tracking information
>
> Yeah, this is on my todo list, but it is pretty low. There is a littl=
e
> bit of cleanup that probably needs to happen first to unify http:// a=
nd
> git:// push (Daniel did some of that recently, but I haven't had time=
 to
> look carefully at his work).
>
> If you wanted to work on it, I would be happy to help guide you.
> Otherwise, I may get to it eventually.
>
> -Peff
>
Hi,
thanks for the reply,
since I never looked into git code yet, I think I need first to get
familiar with it... I will look at it, and if I come to have a
solution I'll send it as a patch to the list, but since it might take
time for me to go into git's code if you find time to do it please
notice me ;)
thanks
JLM


--=20
KISS! (Keep It Simple, Stupid!)
(garde le simple, imb=C3=A9cile!)
"mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des chos=
es
simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
-----------------------------
"Si vous pensez que vous =C3=AAtes trop petit pour changer quoique ce s=
oit,
essayez donc de dormir avec un moustique dans votre chambre." Betty
Reese
http://www.grainesdechangement.com/citations.htm
