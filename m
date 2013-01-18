From: Dennis Putnam <dap1@bellsouth.net>
Subject: Re: merge vs. rebase question
Date: Fri, 18 Jan 2013 13:59:50 -0500
Message-ID: <50F99BA6.5010204@bellsouth.net>
References: <50F8073F.90304@bellsouth.net> <CABURp0rTNh4Xe4h6RwvDgQaBKJFq-ami-wO+X0mR5hiubaF7mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MDUJHCMUFCHMRERJDNFO"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:00:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHAh-0008H4-Tz
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3ARS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 13:59:51 -0500
Received: from nm9.access.bullet.mail.sp2.yahoo.com ([98.139.44.136]:48699
	"EHLO nm9.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574Ab3ARS7u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2013 13:59:50 -0500
Received: from [98.139.44.96] by nm9.access.bullet.mail.sp2.yahoo.com with NNFMP; 18 Jan 2013 18:59:50 -0000
Received: from [67.195.15.62] by tm1.access.bullet.mail.sp2.yahoo.com with NNFMP; 18 Jan 2013 18:59:50 -0000
Received: from [127.0.0.1] by smtp103.sbc.mail.gq1.yahoo.com with NNFMP; 18 Jan 2013 18:59:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s1024; t=1358535590; bh=JKDLN1ypKx16C5cVnfX9DyTPiZ0XV/b9mDamHfdZMaE=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type; b=w3mdPuj8Zpn7kbb6gjQjpHePmQJ5/JuRylgSCH8Nzz9ey8KuBFf80XV+KSDxs4HxJYZT5KWq0UBosgkVvcl6gHxHBWULAM4dlMafq4QHa4UX1x07BU/+rF5JStCM3BpjuGMo3iut+QArlHX3w7FTey53r3SC/90J19pDp/cnG7c=
X-Yahoo-Newman-Id: 380728.35234.bm@smtp103.sbc.mail.gq1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: HDFnl5oVM1lj3w_OdaiMrBWMvjlrVSyF93IrOsgkcfW1.yV
 lWKRUGi3ByfaicP7M5eZbnH6NI4sZCOdRRd81kWI0lF64.oWMO3XGk65yXii
 _rUy.zkbZTUCzqnLhq3rO792NP_sm5u3r8ovyelF525oaujAStuaEV73F3Vf
 qjZVVWZ48A5FwjZJZt09WfIAUGPKCj9ocaupa1yTxOAh3s1LhJDUsfgUaBd6
 GGpYPjLcdJFA1onq1UHj1vRBwmQ0I8jyFcxxFAANwaRAVsD8ZZN2_e_6zQFW
 uBGzS06bROqrNMlGT8DAubNQ_C1KURlqF.aZG0LBxHN9S.uIG7jlWZgnREnv
 4qhBR2BAuMXrn58kOH1odGlcpZ_PzYKbI9tKRFN2pF9D_KgYShP6_3v_sg4l
 gUIzCduBJZPKLFpyS6i0TY8V7vW7IJT4SNh605ApJTohCStOB2gEA_8s-
X-Yahoo-SMTP: vUK3UKuswBCE01YQVYEZ1wHCa.HPSVCYhektzgdifA--
Received: from [192.168.0.100] (dap1@74.176.153.107 with plain)
        by smtp103.sbc.mail.gq1.yahoo.com with SMTP; 18 Jan 2013 10:59:50 -0800 PST
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CABURp0rTNh4Xe4h6RwvDgQaBKJFq-ami-wO+X0mR5hiubaF7mw@mail.gmail.com>
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213925>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MDUJHCMUFCHMRERJDNFO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the reply. I'm afraid this question has become moot. I can no
longer reproduce the problem as it is now working as expected. I did
find an incorrect ownership on one of the 'objects' sub-directories but
I would think that should have given me an error. Perhaps I used root at
the wrong time to do something and that changed the ownership. In any
case there is not much I can do at this point since the problem no
longer exists.

On 1/18/2013 1:38 PM, Phil Hord wrote:
> On Thu, Jan 17, 2013 at 9:14 AM, Dennis Putnam <dap1@bellsouth.net> wro=
te:
>> As a git noob I am having trouble understanding when to use which
>> commands. I have a repository (bare) on my Linux server. I also create=
d
>> a build directory as a local repository. In my build script I do a 'gi=
t
>> pull' to make sure the build directory is up to date. No changes are
>> made to my source so this repository never does an 'add' or 'commit'.
>> When I run my script with 'pull', the output indicates that changes we=
re
>> found and seems to have pulled them into the local directory. However,=

>> when I look at the resulting source, none of the expected changes show=

>> up. I then tried a 'fetch' and 'rebase'. That worked but I don't
>> understand why. I thought 'pull' did a 'fetch' and a 'merge' so I don'=
t
>> understand why a 'fetch' and 'rebase' worked but 'fetch' and 'merge' d=
id
>> not. Unless my understanding of what 'pull' does is wrong. In my case,=

>> what should I be using in my script to assure that the build directory=

>> is current?
> If your build directory never has any source changes or new commits,
> then pull is the right thing to do.  You might want to use 'git pull
> --ff-only' to guarantee that your build directory is not creating
> merges unexpectedly.
>
> You did not provide enough information to help figure out why your
> pull is failing to achieve the results you expect.  I suggest you
> perform the pull manually in your build directory.  If it fails, git
> should tell you why.  If it reports success but actually fails, you
> can post a detailed explanation of the problem here so someone can
> suggest the cause.
>
> Phil
>



------enig2MDUJHCMUFCHMRERJDNFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD5m6cACgkQ/fiWYqZ2tVRJ8QCfdpa0C3Wx5Y5gRrLNsHTUG2qS
JN4AnRF4vYNfHBmcST9c5K1LC8RVtK7s
=SZqD
-----END PGP SIGNATURE-----

------enig2MDUJHCMUFCHMRERJDNFO--
