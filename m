From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref: refs/remotes/origin/master
Date: Mon, 30 May 2011 16:44:08 +0200
Message-ID: <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com> <20110529232405.GA8369@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 16:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3hy-0001wF-UH
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab1E3Oo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 10:44:29 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:61439 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab1E3Oo2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 10:44:28 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so2509890pxi.10
        for <git@vger.kernel.org>; Mon, 30 May 2011 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=CtWTVZ172QNN+75yS9qAWRrdt+4QVhtDMTROE9t322U=;
        b=j9wwuLNbyXg7OGi/E2LbHOf0n2YAAK6sMw0v1IOKXvXDy9+Qtrn5hUw/voEmlmLbib
         IgGiIXQcTurQYfIBCtnDMC9VLAIXwpJYzhtd9fjbaALAYZdHdPfIEWfBZXsnKiJdPuBI
         ihlvZ3y8obMZUsye1WW0my4aXbMZUm+Od0MXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BNrsgAC5zIVvxsNjJVRJOhGdSZT/R64nS9GOwIUN6AW3/atrS90iC8cj/r559XAcyW
         Ggk/EfzxvtH6YQ4oAFpi0CvlB5H0LGHGN2AbVWBRPC+fmzFqI/n7q6HjT/wz7Q5/DkUs
         LZi1P1vh0ixth3NzpAT3wREf3pnDIpX/9pjJ8=
Received: by 10.143.63.10 with SMTP id q10mr702237wfk.291.1306766668071; Mon,
 30 May 2011 07:44:28 -0700 (PDT)
Received: by 10.142.13.11 with HTTP; Mon, 30 May 2011 07:44:08 -0700 (PDT)
In-Reply-To: <20110529232405.GA8369@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174750>

Jonathan,

> I just wanted to say, thank you for working on this[1].
>
> This code answers some questions I had about the remote helper
> protocol, among other things.

Glad we can help !

>
>> a "Warning duplicated
>> ref: refs/remotes/origin/master" is thrown.
>
> To end the suspense: I assume this was fixed by 9055039c (Bug fix for
> pulls with multiple revisions pulled, 2011-05-29).

No, I actually still have the problem. The version commited on github
is pulling revisions straight to refs/heads/master which is gross
After discussing this matter with our teacher Matthieu Moy, I wanted
to change this to refs/remotes/origin/master but then this warning
gets thrown.

Does anyone have an idea ?

Thanks,
Cheers,
--=20
J=E9r=E9mie Nikaes
