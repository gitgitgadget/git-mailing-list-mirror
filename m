From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: stash refuses to pop
Date: Sun, 15 Apr 2012 21:29:49 -0400
Message-ID: <4F8B760D.6030207@ubuntu.com>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org> <4F84827B.80104@ubuntu.com> <CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com> <4F84F39B.6070907@ubuntu.com> <20120414042713.GA13889@inner.h.iocl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 16 03:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJalP-00052V-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 03:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab2DPB3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 21:29:52 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:19138 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab2DPB3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 21:29:51 -0400
X-Authority-Analysis: v=2.0 cv=ReYS+iRv c=1 sm=0 a=QETZmXXmyubuBiJjAgCHWw==:17 a=zF0nvurNEAYA:10 a=2TzjGJVPWd4A:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=xe8BsctaAAAA:8 a=eSXQjH11rlzfZ4NsrEIA:9 a=wPNLvfGTeEIA:10 a=QETZmXXmyubuBiJjAgCHWw==:117
X-Cloudmark-Score: 0
X-Originating-IP: 97.103.252.48
Received: from [97.103.252.48] ([97.103.252.48:33351] helo=[192.168.1.4])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 8D/CE-07741-D067B8F4; Mon, 16 Apr 2012 01:29:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120402 Thunderbird/11.0.1
In-Reply-To: <20120414042713.GA13889@inner.h.iocl.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195597>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/14/2012 12:27 AM, Andreas Krey wrote:
> (Late to the game.) Actually, this is exactly what I would have proposed
> to do. Git is a bit shy on performing a merge into a locally modified
> file. I assumed so far that is because there is no way of aborting
> such a merge (resetting to the state of local modifications before the
> attempt). With the temporary commit you have a way of retrying the pop
> merge if you lost your way in it.
> 
> And I think that is a good idea; I never liked the way in which a cvs/svn
> update merged into locally modified files without a way to undo, and
> thus forcing you to clean up the potential mess manually. (Ok, they leave
> the old files lying arond, but that doesn't help rewinding the state.)

That makes sense for the default behavior, but there should be a way to override.  Or maybe git could automatically stash the current state to a temporary commit before applying the requested stash and print the sha1 of that commit ( or save it as ORIG_HEAD ) so you could undo the stash pop/apply.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPi3YKAAoJEJrBOlT6nu75OXAH+gK4pfFomFgblw1sLb9Bpgud
0O88dtWWOr9/bNR6NIiIWj76x+xMiRMxuq2YP3/6vkuhGAtVxYqoHc/BkWUmzop/
oma30g244H17Oa0r9H0yf6n6v824xv3tVx166cQ0pVeBnnFs1GINxjODuD0QGTnH
VewepnyaYkPRSjgzrJShOadaxRZFZWUBNlncLbHMLBNJl+n4cMXsg9uasEv3rG73
Mw+zAKcMMf4zCfxE0T2dpbf0hOOde8PWtJY12RAYWvhn7YTVP9Uj+t3a9flb2UyB
zuo84Xv49meMB9ce4DDtANXeH8uKamBGk94NH6Khv6LewuG5SOS7DukDEJxA+B0=
=xaNu
-----END PGP SIGNATURE-----
