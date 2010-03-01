From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: error when installing 1.7.0.1: "ImportError: No module named 
	distutils.core"
Date: Mon, 1 Mar 2010 23:15:20 +0800
Message-ID: <be6fef0d1003010715l31d7b49bs36ee69685e1684e8@mail.gmail.com>
References: <20100301144000.GA17135@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Mon Mar 01 16:16:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm7M4-0005eu-PB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 16:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0CAPPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 10:15:23 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:56522 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab0CAPPV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 10:15:21 -0500
Received: by iwn12 with SMTP id 12so2429950iwn.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a/8xjXL0uaZCLQUhPxCnZk8ZVQCktpDFpGP8oa2uXpI=;
        b=RlRYWoKz0Q4EnAOm6uMs9LeY3jbtrIGKdqrV9ziQxigkiA46dKKWWZKDhQk4DvgSrI
         bD2Y1qMc5CL4q4aBlfdB5l6BEdlP50WpzxCs9o/jJhXlYiAywD9xIjgs00Maf1rxeaLC
         8Z+m8wdUB8E9wykw8Ov9LFeTai1dd5d/ajWqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=POJ6ohFejemMXei/PJ/LdGAqgVNKDUO6GhGRy4V7ofJAY3m5YQGrnL454ZyYLJKvGP
         biaBO9s43D9L5C9Fg+Qf8o94iMgK7qs2dbs8zu88PD3c22woXpH45f+gpEOayCV82O1h
         VQVK8vSvb++MJxBXK57WHMY131jnrv4YBxlJo=
Received: by 10.231.168.136 with SMTP id u8mr760570iby.56.1267456520072; Mon, 
	01 Mar 2010 07:15:20 -0800 (PST)
In-Reply-To: <20100301144000.GA17135@cs-wsok.swansea.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141323>

Hi,

On Mon, Mar 1, 2010 at 10:40 PM, Oliver Kullmann
<O.Kullmann@swansea.ac.uk> wrote:
> make[3]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform=
/ExternalSources/builds/Git/git-1.7.0.1/perl'
> make[2]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform=
/ExternalSources/builds/Git/git-1.7.0.1/perl'
> make[2]: Entering directory `/home/csoliver/SAT-Algorithmen/OKplatfor=
m/ExternalSources/builds/Git/git-1.7.0.1/git_remote_helpers'
> Traceback (most recent call last):
> =A0File "setup.py", line 5, in ?
> =A0 =A0from distutils.core import setup
> ImportError: No module named distutils.core

(adding Sverre to the Cc list, perhaps he has something to add)

you need to install setuptools from python, or pass NO_PYTHON to make/c=
onfigure.

> I've checked the README and INSTALL file, but I don't see that there =
are new
> requirements? (That is not regarding doc.)

I guess we should improve on this.

--=20
Cheers,
Ray Chuan
