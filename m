From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/23] http-push.c::fetch_symref(): use the new http API
Date: Fri, 05 Jun 2009 22:32:28 -0700
Message-ID: <7vvdnadj0z.fsf@alter.siamese.dyndns.org>
References: <20090606000559.483f22da.rctay89@gmail.com>
	<m37hzq5rod.fsf@localhost.localdomain>
	<be6fef0d0906051802n4f6d5df3g453b292787ed62d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 07:38:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCobz-0000Tz-Uf
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 07:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbZFFFc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 01:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbZFFFc2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 01:32:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61221 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbZFFFc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 01:32:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090606053228.WFSU2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jun 2009 01:32:28 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 0VYU1c0074aMwMQ04VYUqR; Sat, 06 Jun 2009 01:32:29 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=H-8FU1NQUpMA:10 a=BuE6NxGQqqQA:10
 a=pGLkceISAAAA:8 a=z23upLkTAAAA:8 a=-iqeroRl1tK8Yin71dsA:9
 a=62V76XeA9a2U87apTOAA:7 a=2FTpbquNS9xIVkhGnqEyZZAm7RUA:4 a=MSl-tDqOz04A:10
 a=Ak6yjH5nytEA:10
X-CM-Score: 0.00
In-Reply-To: <be6fef0d0906051802n4f6d5df3g453b292787ed62d0@mail.gmail.com> (Tay Ray Chuan's message of "Sat\, 6 Jun 2009 09\:02\:32 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120874>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Sat, Jun 6, 2009 at 4:54 AM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
>>> From: Mike Hommey <mh@glandium.org>
>>> Subject: [WIP Patch 09/12] Use the new http API in fetch_symref()
>>
>> What is the subject of this patch:
>> =C2=A0"http-push.c::fetch_symref(): use the new http API"
>> or
>> =C2=A0"Use the new http API in fetch_symref()"
>> [...]
>> If you wanted to note old subject, it would be better to put it in
>> comments (here).
>
> Since the title of the patch differed from Mike's original, I was
> afraid the attribution to the author's original patch was lost on the
> reader of the commit message, thus I added the original subject, in
> addition to the author and date, into the commit message.

Please don't.

If you chose to use a better (in your opinion) subject from the origina=
l
one, we'd want to have that improved one in our commit.  The same thing=
 if
you chose to rewrite the proposed commit log message, or the contents o=
f
the patch, to add your own improvement.  That is what we review here, a=
nd
if people think your submitted version is good, that is what we want to
record as a commit.

So, in general we would want to see something like this:

(1)     From: Tay Ray Chuan <rctay89@gmail.com>
        Subject: [PATCH 19/23] http-push.c:fetch_symref(): use the new =
HTTP API

(2)     From: Mike Hommey <mh@glandium.org>

(3)     Now the contents of a file can be slurped into a strbuf with a =
single
        call to http_get_strbuf(), use it to simplify fetch_symref().

(4)     Signed-off-by: Mike Hommey <mh@glandium.org>
        Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
(5)     ---
(6)      This is based on Mike's earlier patch:

         Subject: [WIP Patch 09/12] Use the new http API in fetch_symre=
f()
         Date:  Sun, 18 Jan 2009 09:04:34 +0100

         I retitlted Mike's patch in order to ...
         Also changed frotz and nitfol so that they distim doshes bette=
r...

(7)     http-push.c |   20 +++-----------------
         1 files changed, 3 insertions(+), 17 deletions(-)

(8)     diff --git a/http-push.c b/http-push.c
        ...

That is,

    (1) RFC2822 headers your MUA gives us;

    (2) In-body (fake)headers for From: if the author is different from
        what (1) records.  If you are forwarding somebody else's patch
        verbatim without modification, you may want to add Date: to kee=
p
        the original datestamp, but if you are sending a version with y=
our
        own improvements, we would rather use the Date: recorded in (1)=
 in
        the final commit.

    (3) Proposed commit log message;

    (4) Chain of Signed-off-by lines;

    (5) Three-dash separator;

    (6) Commentary to explain the history of the patch, and/or backgrou=
nd
        information if necessary,

    (7) diffstat;

    (8) the patch itself.

Thanks.
