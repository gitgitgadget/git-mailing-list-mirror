From: Jeremy Morton <jeremy@configit.com>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 10:38:15 +0000
Message-ID: <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:38:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ajy-0007gk-Kl
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab2CHKiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 05:38:19 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34664 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755757Ab2CHKiR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 05:38:17 -0500
Received: by lahj13 with SMTP id j13so329659lah.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 02:38:15 -0800 (PST)
Received: by 10.152.102.228 with SMTP id fr4mr4039907lab.23.1331203095664;
 Thu, 08 Mar 2012 02:38:15 -0800 (PST)
Received: by 10.112.23.225 with HTTP; Thu, 8 Mar 2012 02:38:15 -0800 (PST)
In-Reply-To: <1331202483.21444.11.camel@beez.lab.cmartin.tk>
X-Gm-Message-State: ALoCoQkN+CjvH4fNH1O1x+WN9hu7e5SU6jt9eGBurjnBBcF4plsxPuuB6oEK1HykLINYMEL1CvKh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192553>

But 'push --force' WILL try to push your (probably outdated) master
upstream, killing any changes there made since you last updated.  That
alone is so dangerous it seems like reason enough to avoid it by
default.

Best regards,
Jeremy Morton (Jez)

On Thu, Mar 8, 2012 at 10:28 AM, Carlos Mart=EDn Nieto <cmn@elego.de> w=
rote:
> On Thu, 2012-03-08 at 10:13 +0000, Jeremy Morton wrote:
>> Right, so I guess I'm saying that the default value for push.default
>> should be upstream instead of matching...
>
> Any default is going to leave some people unhappy. If upstream is the
> right thing for you, then that's what you should use. Most questions =
I
> see about push not doing what the users expect would actually benefit
> from 'current'. 'matching' is a fairly safe default, as it won't try =
to
> push private branches or changes in private branches that track
> something upstream.
>
> =A0 cmn
>
>
