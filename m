From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/9] Introduce vcs-svn lib
Date: Thu, 24 Jun 2010 22:27:27 +0200
Message-ID: <AANLkTim3ApkAjSoy4CD7Q_o7ECP0_KYJKErxt8AeXsN4@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624105243.GB12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:27:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORt1e-0001ol-5Y
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab0FXU1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 16:27:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64591 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0FXU1s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 16:27:48 -0400
Received: by gye5 with SMTP id 5so4654005gye.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JCfMWntNQgKGKU+qCCrCxPEJDlAzPOqK7mTTfBrzjxc=;
        b=t/t+Afpv7UBac0hFOWu0SDAF23hosPy36XTTwGFIhduk9ihsj1oOx++sTmjSNsCCyB
         wX7kcdla5LzjqzqCo+VQUZ87GT9HHO3u5l3pUNd8bFOVVqkj1fiaISEHLR+z/l/9xTXY
         8Tf5i9DtGcD7l1iMYujjcRHvJBn4eVVwOeURo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Xt4/0teT+WwZ26EUaYm2Nqrl0jRAgw9dZHKZ3E7XQSdDXuYnvFMvDzNFo6OrqRINm9
         r15uA/5fzVwpYJ4N+EwxaooH8WDJPms0STNDgiT2zbXyp2YueseZYC9vJTUDCx13CsWP
         LlwVn30q/a6unCqHt4iomTo3jMeMuXhe2UaxY=
Received: by 10.229.190.80 with SMTP id dh16mr5679744qcb.29.1277411267636; 
	Thu, 24 Jun 2010 13:27:47 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 13:27:27 -0700 (PDT)
In-Reply-To: <20100624105243.GB12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149637>

Hi,

Jonathan Nieder wrote:
> Teach the build system to build a separate library for the
> upcoming subversion interop support.
>
> The resulting vcs-svn/lib.a does not contain any code, nor is
> it built during a normal build. =C2=A0This is just scaffolding for
> later changes.

This is very elegant indeed!
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- Ram
