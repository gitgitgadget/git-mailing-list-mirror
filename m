From: Frank Li <lznuaa@gmail.com>
Subject: Re: C# Git Implementation
Date: Mon, 13 Jul 2009 08:37:53 +0800
Message-ID: <1976ea660907121737r33e05479jae32f6474edfd60d@mail.gmail.com>
References: <001501c9515e$66e8ac70$34ba0550$@com>
	 <alpine.DEB.2.00.0811291308120.17643@vellum.laroia.net>
	 <1247347556196-3243735.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: henon <meinrad.recheis@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 03:01:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ9ur-0006d7-1Y
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 03:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbZGMBBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 21:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbZGMBBA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 21:01:00 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:46375 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZGMBBA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jul 2009 21:01:00 -0400
X-Greylist: delayed 941 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jul 2009 21:01:00 EDT
Received: by pxi15 with SMTP id 15so279451pxi.33
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 18:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FPgFdXEPe4/ZP4p7xKU8MyIGcawXM5E7riTpwB/M/pw=;
        b=r9xiTs1UWHpQOqXDydegO9VoUwMp1ZhjpvVyH7q/m/wlh65RtJDIa5USuXBnzw4/hk
         9fqbg/YY2XQ3VpqC/Qawd7yy6DsriIR7gEb72P7Pe+rTSPcsOoIhLaVoNuHCwBmr6ooe
         JCQJhUbYVitm5KQF7q1wWwKB1ITHCQ5Zb4MiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hFmmPDYBerumOD8vIqb9+F0IO2tSK9HCh1yrrWAR1PUbGk6cP/gZoZk8CFRmFOQajp
         dxr14+lSsCAtQ9pKa9k49lbZuF4lwUuZnlKYkDgQdxrALRDdsDyi2zdmXa4tQpsTNBGV
         kSKgjKzmnpRZsazPp2i2gNxlrboe+rxZG1b7Y=
Received: by 10.114.95.19 with SMTP id s19mr7084176wab.10.1247445473945; Sun, 
	12 Jul 2009 17:37:53 -0700 (PDT)
In-Reply-To: <1247347556196-3243735.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123169>

I hope portable git library, which can port to any languadge and platfo=
rm.
Git itself use such library. So library can be verified at big scope.


2009/7/12 henon <meinrad.recheis@gmail.com>:
>
>
> Asheesh Laroia-2 wrote:
>>
>> On Fri, 28 Nov 2008, JD Guzman wrote:
>>
>>> I read in the archives that there was once talk of porting Git over=
 to
>>> C# and was wondering if anything ever came of this? =A0I realize th=
ere
>>> were some that didn't see the use for this but as Git is becoming m=
ore
>>> and more popular a more native implementation of Git for windows us=
ers
>>> would be a good endevour IMHO.
>>
>> Is it possible to compile the Java-language jgit with the Common Lan=
guage
>> Runtime and access that from a C# application?
>>
>> -- Asheesh.
>>
>
> Hi,
> Just in case some of you are still interested in a git implementation=
 in C#.
> I evaluated all of the existing projects and chose the one of them wh=
ich was
> most advanced and had the most promising strategy of getting done soo=
n:
> kevin thompsons gitty. gitty is a =A0port of about 6k of ~20k lines o=
f a jgit
> snapshot from 2008. The gitty code is mostly not working because it h=
as
> never been debugged after porting.
>
> I figured that the easiest way to a pure c# implementation of git is =
to port
> jgit. Automatic porting attempts have not really been successful so I
> decided to do it manually. Based on Kevin's very erraneous but yet va=
luable
> work I ported even more substantial parts of jgit and its tests to C#=
 and
> got much of the code working as the over 200 passing tests can tell. =
By now
> we have ported about 47% of the jgit source (snapshot from june 2009)=
 and
> got reading of repos and writing of trees, blobs and commits to work
> already. The project is called Git# now and has already found a few
> contributors on github. More info is available at the
> http://www.eqqon.com/index.php/GitSharp Git# =A0website.
>
> I know that there have been several attempts by the Mono project to c=
reate a
> git implementation in C#. They seem inactive and in a very basic stat=
e to me
> but correct me if I am wrong. I will try to contact the mono folks fo=
r
> collaboration on the matter.
>
> -- henon
> --
> View this message in context: http://n2.nabble.com/C--Git-Implementat=
ion-tp1589227p3243735.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
