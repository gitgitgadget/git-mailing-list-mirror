From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: error when installing 1.7.0.1: "ImportError: No module named 
	distutils.core"
Date: Mon, 1 Mar 2010 16:24:30 +0100
Message-ID: <fabb9a1e1003010724g7c4d2517v1515b846e288713a@mail.gmail.com>
References: <20100301144000.GA17135@cs-wsok.swansea.ac.uk> 
	<be6fef0d1003010715l31d7b49bs36ee69685e1684e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Oliver Kullmann <O.Kullmann@swansea.ac.uk>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Mar 01 16:25:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm7UP-0007SA-UZ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 16:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350Ab0CAPYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 10:24:52 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41547 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab0CAPYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 10:24:51 -0500
Received: by pva4 with SMTP id 4so524140pva.19
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 07:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=eNgGaE+WU3TeCzxgUkYWMva+GWsrXUMT3Ww0RoDHuxA=;
        b=IWUpvddVr7MOg4hESEKG94iVKo/0ljqxCxV/+V5qdic2iCreFXm7uDPo1Kr50ad6uM
         jll1PkIpIT8TIBC2fIOcs8vHIeTrVrfyMThUiiNn9b94dIRLRAm4Q+eW1JOcfwSpK07L
         pYQAPzaf2saKM6Jcuieg13qWxeH7wYdNWqwMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LOSxvUp/fhBPR8/PrPfm+EcmmB4Vpyr9fTJQv0LArA+FO2kaGe1239/HJiMjl6aXPN
         0/JhufCDbE/3UzzPRnssnLICsPUmvaB4nS2YiC+cOoa23N/qErcuBtLDM0YBEM3ujkPp
         5Cau9lS+q/Tz+6DXCBp5daeuHgh0Fyp41XG+c=
Received: by 10.142.151.22 with SMTP id y22mr2632590wfd.126.1267457090446; 
	Mon, 01 Mar 2010 07:24:50 -0800 (PST)
In-Reply-To: <be6fef0d1003010715l31d7b49bs36ee69685e1684e8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141324>

Heya,

On Mon, Mar 1, 2010 at 16:15, Tay Ray Chuan <rctay89@gmail.com> wrote:
> (adding Sverre to the Cc list, perhaps he has something to add)

This is Johan's code, but IIRC setup.py is pretty much generic setuptools code.

> you need to install setuptools from python, or pass NO_PYTHON to make/configure.

Correct.

>> I've checked the README and INSTALL file, but I don't see that there are new
>> requirements? (That is not regarding doc.)
>
> I guess we should improve on this.

Aye, at the very least we need to document this requirement, but it
would probably be even better to test for the existence of setuptools
and give a useful error message if it's not found?

-- 
Cheers,

Sverre Rabbelier
