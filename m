From: demerphq <demerphq@gmail.com>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 13:12:48 +0100
Message-ID: <CANgJU+V-nSRwz7YitsDLsUA=5nm5S6L59pUhw4x50kKojLBFuA@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<vpqeht3qpev.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:12:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5cDG-0006go-03
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401Ab2CHMMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 07:12:49 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46615 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab2CHMMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:12:49 -0500
Received: by ghrr11 with SMTP id r11so123946ghr.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PtHw9iUzct7oimxeHHDcQ7cHU289mc+36CYSlQqFEvo=;
        b=bVOiv72x7P4aHLowMWKg13ip+ZkocUVf6gAsTMy+xLHW3vG3n8OGsH8+hLdqlhqm+k
         52wnE5IIgRhmiFunyPyk+XAJLPpWSYQD2uROgqQU0HhfvqUMtlgILDILbIGjNg5DKgJd
         TPgDdvfhGMbrg24X1saw8XyreetHaEuv+eQXHKpCRqKSeiV+IfkQLQ3o+ry7je1J/SOr
         8RpK8axq1e9oEM/JqQt5ilt75OwaLB+gHD6vw8zMvjzK4yz01c5iK9I6ROJ4KHGCN3Mg
         uTvupEa/fH5RnOseI3/7bxyt2pfqXMuTxExfStixLyLqs6jS8ecxXGVGyCykKImWYIlv
         y6ag==
Received: by 10.236.197.66 with SMTP id s42mr9872478yhn.69.1331208768443; Thu,
 08 Mar 2012 04:12:48 -0800 (PST)
Received: by 10.236.176.1 with HTTP; Thu, 8 Mar 2012 04:12:48 -0800 (PST)
In-Reply-To: <vpqeht3qpev.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192581>

On 8 March 2012 12:54, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrot=
e:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>
>> On Thu, 2012-03-08 at 10:13 +0000, Jeremy Morton wrote:
>>> Right, so I guess I'm saying that the default value for push.defaul=
t
>>> should be upstream instead of matching...
>>
>> Any default is going to leave some people unhappy. If upstream is th=
e
>> right thing for you, then that's what you should use. Most questions=
 I
>> see about push not doing what the users expect would actually benefi=
t
>> from 'current'. 'matching' is a fairly safe default, as it won't try=
 to
>> push private branches or changes in private branches that track
>> something upstream.
>
> There were some discussions about changing the default, and I thought
> people agreed that 'upstream' was a better default value for
> push.default:
>
> =A0http://permalink.gmane.org/gmane.comp.version-control.git/167149
>
> it needs to be done with a sane migration path, however, and I guess =
no
> one stepped in to start the process (but I may have missed some furth=
er
> discussions).

=46rom the point of view of new users the current default is sub-optima=
l
and confusing. I actually find the current default an odd choice, as I
personally have *never* wanted to push all the branches at once, nor
have I ever seen a colleague want to do that.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
