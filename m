From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Challenge with Git-Bash
Date: Sun, 18 Jul 2010 18:11:30 +0000
Message-ID: <AANLkTinZCKIDh8bJUVXceqNYD1qkmWZ1fO67t0XJI5Uo@mail.gmail.com>
References: <001d01cb25cb$eb176980$c1463c80$@net>
	<20100717171303.GB10730@burratino>
	<008a01cb26a4$4313e360$c93baa20$@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Rainer Lauer <lauerr@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:11:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYKt-0006bz-Or
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab0GRSLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:11:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39915 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab0GRSLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 14:11:30 -0400
Received: by iwn7 with SMTP id 7so3820088iwn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bxuUsVGjpWvtllxXxCvqB+oXtTwMeM2jtYeAow11+Qw=;
        b=r1KRInelnkYZkRut/DJA716eHTY+CslwtW58/JFS5+iaNcokt/DnmPRK5sbcKKzkC0
         OwNQ6WdkESt5dKO8dA8XU2CFJixSKbEcpanicZKEK2z+R+7jrJQw2dMigEdztd556YW2
         vxu3EZPwGPrgMLZIaM5GSCAWRLgny037qKEL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ArE40KZ/Sawu11hZeJmP6vQcnoW+tILmt2ddH/omft1/AH5vU5Wmaw6CcnwObAsSqy
         +1qqALIUaMN4NIj3FbAXjOyN09LrlIm+vK2YriwXKxb5GGrUPpJw7OLHTJEJ6hgeEhco
         VMxf53kalUkk9AQFokgln/einzUW9YwKPDPN0=
Received: by 10.231.171.18 with SMTP id f18mr4631464ibz.9.1279476690124; Sun, 
	18 Jul 2010 11:11:30 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 18 Jul 2010 11:11:30 -0700 (PDT)
In-Reply-To: <008a01cb26a4$4313e360$c93baa20$@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151228>

On Sun, Jul 18, 2010 at 18:08, Rainer Lauer <lauerr@gmx.net> wrote:
> Hi Jonathan,
> thanks for this hint. Now it is working on the base of environment va=
riables.
>
> In order of automatically setting up my projects I'd like to use the =
configuration file for preparing =C2=A0CVS-work instead introducing env=
ironment variables.
> Unfortunately, I'm facing another problem.
> Following commands don't modify .git/config coming along with my proj=
ect(s).
> git config user.name=3D"Rainer Lauer"
> git config user.email=3D"Rainer.Lauer@gmx.net"
> git config core.editor=3D"c:/Program Files/SlickEditV14.0.2/win/vs.ex=
e"
> The file seems to stay in initial revision as created with the comman=
d git init.
>
> Where is following information stored? Command: =C2=A0git config --gl=
obal user.name=3D"Rainer Lauer". Did I get the documentation right that=
 this is a definition for all projects?

If you're asking why your .git/config file isn't being carried over
when you clone the repository that's because it's not supposed to, Git
doesn't work like that.
