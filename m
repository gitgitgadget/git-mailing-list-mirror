From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 12 Jun 2010 02:55:42 -0500
Message-ID: <20100612075542.GB2918@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 12 10:00:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONLdz-0008LR-1p
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 10:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab0FLHzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 03:55:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48997 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0FLHzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 03:55:51 -0400
Received: by iwn9 with SMTP id 9so1251866iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iELTZ21FztrSqLSUwdn4vjcfzhkLDo9pFss9a6Ecn94=;
        b=tIYZyD/Fnd5KCp8v2t0oYrGQx84Y/t9hBEo3QSQ4sPETP4KhKdvNpVEhxsRI7kE5D/
         CC2FltusCz1jB7bOCcSPGxNPSNF2lMocvYadiPR4JyU/aMfhZLnswErZ8ntmsGrSS+Kn
         DqQchkWOczwD2U2IWQrjMK2Zq9KgK7KoxnYHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pCMRxXzve0SFWDgQUbXec2145HY140207NDJiJ7DbjVDT4M1lkgSTMZQ6K3m10P5Hn
         L1lGV2ABNmFpsHLP9alwUERVj7QmX48wpLTSSpUveqinZ1y42LZkpvLIkJmuTzS9V55X
         Vq8allzroNjGFzEadGYmQfhl/um5v95Jsuyn0=
Received: by 10.231.189.103 with SMTP id dd39mr2923722ibb.199.1276329349710;
        Sat, 12 Jun 2010 00:55:49 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm9284751ibg.6.2010.06.12.00.55.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 00:55:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1006051810300.1732@bonsai2>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148995>

Johannes Schindelin wrote:
> On Fri, 4 Jun 2010, Jonathan Nieder wrote:

>> Johannes Schindelin (2):
>>   grep: Add the option '--open-files-in-pager'
>>   grep -O: allow optional argument specifying the pager (or editor)
>
> Last time I tried, it also needed the patch "Unify code paths of thre=
aded=20
> greps". Don't know if that one made it in already.

Thanks for the pointer, but I can=E2=80=99t seem to find any such patch=
=2E  Maybe
it was squashed into Fredrik=E2=80=99s patch (5b594f4)?

Jonathan
