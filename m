From: Magnus Hagander <magnus@hagander.net>
Subject: Re: [PATCH] Allow gitweb tab width to be set per project.
Date: Mon, 18 Oct 2010 12:31:11 +0200
Message-ID: <AANLkTimOxim60=gMNZu3n_AztZR7mPAOzg1NevJA2m+4@mail.gmail.com>
References: <1285673709-24924-1-git-send-email-magnus@hagander.net>
	<201009291122.01272.jnareb@gmail.com>
	<AANLkTimPte3eQMuCE3NTS=03Vv+Q2-nnu8BmXq=4YCbA@mail.gmail.com>
	<201010012302.47269.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 12:31:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7mzw-00035Y-3r
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 12:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab0JRKbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 06:31:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52247 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab0JRKbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 06:31:13 -0400
Received: by ewy20 with SMTP id 20so1420204ewy.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 03:31:11 -0700 (PDT)
Received: by 10.213.8.136 with SMTP id h8mr309604ebh.36.1287397871565; Mon, 18
 Oct 2010 03:31:11 -0700 (PDT)
Received: by 10.14.127.133 with HTTP; Mon, 18 Oct 2010 03:31:11 -0700 (PDT)
In-Reply-To: <201010012302.47269.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159249>

On Fri, Oct 1, 2010 at 23:02, Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 1 Oct 2010, Magnus Hagander wrote:
>> On Wed, Sep 29, 2010 at 11:22, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>> On Wed, 29 Sep 2010, Magnus Hagander wrote:
>>>> On Tue, Sep 28, 2010 at 14:25, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>>>> Magnus Hagander <magnus@hagander.net> writes:
>
>>> Nevertheless it is a good practice to check if a change passess
>>> appropriate tests from git testsuite; t9500-gitweb-standalone-no-er=
rors
>>> should detect this.
>>
>> Good point. Now I just need to figure out how to be able to run the
>> tests :-) I guess I should just set off a job to build the whole tre=
e,
>> and then it will just work..
>
> To test other parts of git, you need to first compile, and then run t=
ests
> (e.g. by running "make test" after "make"). =A0Gitweb tests check the
> source version (for historical reason, namely that there were no gitw=
eb
> target in main makefile, and gitweb didn't get compiled by default),
> so in that case you need to compile git once (to satisfy test suite),
> and then run e.g.
>
> =A0# (cd t && ./t9500-gitweb-standalone-no-errors.sh)
>
> from the top directory of git repository.

Yeah, I got that working a while ago. Just had to build the whole thing=
=2E


>>> P.S. If it is not a %feature, we might want to add description of
>>> gitweb.tabwidth to the "Per-repository gitweb configuration" sectio=
n
>>> in gitweb/README (as next to last item)
>>
>> Ok. Will add that. Want me to send a new patch with these things inc=
luded?
>
> Yes, please do.

Sorry, this one ended up filed under the completely wrong tag in my
in-<real-life>-memory-bugtracker, forgot all about it. New patch
forthcoming in a couple of minutes - just need to complete the tests
again.

--=20
=A0Magnus Hagander
=A0Me: http://www.hagander.net/
=A0Work: http://www.redpill-linpro.com/
