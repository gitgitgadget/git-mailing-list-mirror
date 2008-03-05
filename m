From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: tracking renames
Date: Wed, 5 Mar 2008 17:15:56 +0100
Message-ID: <200803051715.58375.jnareb@gmail.com>
References: <20080304135734.b2c2f473.akpm@linux-foundation.org> <m3zltegmj0.fsf@localhost.localdomain> <965172C8-C7A4-4932-899B-1E1A77BD7C12@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Harvey Harrison" <harvey.harrison@gmail.com>, git@vger.kernel.org
To: =?iso-8859-1?q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Wed Mar 05 17:16:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWwI0-00087w-EX
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 17:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbYCEQPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 11:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755784AbYCEQPl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 11:15:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:17668 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYCEQPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 11:15:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3348386ugc.16
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=D/mHZaQ0jl0OIEKRIiyMt4/ex8Lm2pu7XNVQ4wO//Go=;
        b=Y1qHLbJVQfmJmjrDQIpnccwfc17FKgn8pB54TIHPyBDuf+yqKNbkNk7xxgA+yioVTi+DXIeHsRwfNq32ELLs05zGnddUvL78ufttEiB+j/Nsn6nfyRWnGWe0EbWfuN3ujVxmY5AQopz4aawX1c+rk7tUPaUvkMTZ9cBHkeg2chk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d7fE08AnJnT4aPIL2sjuAQANPwUZpo6Oeu+4i7oSeH3HufabNg9krU2w+ZC5DeOE/vFJeXZx7Jv6YTOn3G8XatfrqOoWOy6Q8JQw1ZMwNJsSeRL05BtICbT6TFDRByr+P8AquIp03QtjH1Lnllv9HmrR/IvR5WC7dBbL6bGeQKU=
Received: by 10.66.244.2 with SMTP id r2mr6547721ugh.64.1204733738544;
        Wed, 05 Mar 2008 08:15:38 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.248.32])
        by mx.google.com with ESMTPS id y7sm13088857ugc.16.2008.03.05.08.15.34
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 08:15:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <965172C8-C7A4-4932-899B-1E1A77BD7C12@yahoo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76239>

On Wed, 5 Mar 2008, Jean-Fran=E7ois Veillette wrote:
> Le 08-03-04 =E0 17:19, Jakub Narebski a =E9crit :
>> Andrew Morton <akpm@linux-foundation.org> writes:
>>>
>>> On Tue, 4 Mar 2008 14:03:54 -0800
>>> "Harvey Harrison" <harvey.harrison@gmail.com> wrote:
>>>>
>>>> git-whatchanged --follow drivers/watchdog/iTCO_wdt.c
>>>>
>>>
>>> Oh.  Thanks.  It seems dumb that one needs to add an option to get
>>> it to do this.
>>
>> In "git log <paths>..." or "git whatchanged <paths>..." the <paths>
>> option is "path limiter" and can be a directory. There can be more
>> than one path. And following renames is more costly.
>=20
> Am I the only one who think rename could be explicit?

No, you are not the only one. Use Bazaar-NG (bzr) or Mercurial (hg)
if you think you truly need rename _tracking_ as opposed to rename
_detection_.

> Don't take me wrong, I do appreciate the fact that git recognize =20
> renames after-the-fact, when specifically asked for it.
> But as a developer, at some point, a rename is no longer a point-of-=20
> view discovery, a rename is a rename by 'design', by the nature =20
> itself of the change, it's no longer an after-the fact realisation.

There is a point why git does rename detection and not (usually=20
file-id / file-inode based) rename tracking, besides historical
reasons. This discussion crops now and there; you can search mailing
list archives (and perhaps look up GitFaq at GitWiki).

> It seem to me that no mather how smart we try to discover renames, =20
> there will always be cases where algorithm won't discover due to time=
/=20
> space/other constraints.

Then we will improve rename (and copy) detection heuristics.

> I would like something like 'graft' where after the fact, we can =20
> educate git that there is a connection between 2 commits.  In a =20
> similar way, at some point, I would like to tell git, 'ok stop trying=
 =20
> to figure out which changes are renames, you guessed it right for the=
 =20
> last 10 times, just freeze it ... but let me adjust it if you guessed=
 =20
> it wrong'.

There was idea of _local_ second level of rerere (reuse resolved=20
resolution of conficting merges), more persistant, which would remember=
=20
tree merge conflicts (rename detection and other such conflicts).
But as far as I know it never got implemented.
=20
IMVHO it is only sensible solution, see below.

> This is a comment from  a git user, I've not looked at the code at =20
> all (and probably won't do anytime soon).

=46irst, I think it could be good idea to store helper advisiory=20
information about explicitely stated renames, or tree merge resolutions=
=20
as a [proposed] 'note' header in commit object, to be remembered when=20
traversing graph of commits to find common ancestor(s) and later reuse=20
in rename detection. But this never got past the wishful thinking...


Explicit rename tracking has many caveats.=20

If you remember it with commit info, you would loose at least somewhat=20
nice assertion that only endpoints (which includes merge bases) matters=
=20
when doing merge, not the path taken.  IIRC it is what Mercurial does.

If you use some kind of automatic assigned file-ids (file-inodes) you=20
can have problems with independently added (on different branches)=20
files.  Linus also suggests that if you have file-id conflict, you=20
would have to resolve it again, and again, and again.  IIRC it is what=20
Bazaar-NG (following original Arch idea) does.

And of course with rename (and copy) tracking you _have_ to explicitely
state renames, which is a bit out of question if some of your commits=20
comes as a patches in email, or from foreign SCM. Or if you forget to=20
explicitely state rename.


Besides wholefile rename tracking is only small fragment of dealing wit=
h=20
code movement, something what "git gui blame" ("git blame -C -C") is=20
good at...

--=20
Jakub Narebski
Poland
