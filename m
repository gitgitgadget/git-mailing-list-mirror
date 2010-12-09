From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] config: add git_config_from_sha1() to read from a
 blob
Date: Thu, 9 Dec 2010 11:02:28 -0600
Message-ID: <20101209170228.GC5974@burratino>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
 <1291907388-9068-3-git-send-email-pclouds@gmail.com>
 <AANLkTi=qt-uwXdUquRAv_1VpMUQuUR+aNMuxSHdpMhXd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 18:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQjtK-0006Wg-4C
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 18:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab0LIRCp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 12:02:45 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:47004 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0LIRCo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 12:02:44 -0500
Received: by qyk4 with SMTP id 4so581022qyk.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=W4ZASr5QNwO53FxI0EnhOHGsvN6luIQXit5P4YFs7wU=;
        b=eHS9wEWXyENZ0ylLFxmsDEX0kLJ79A6uIslmq+sw/+KL70Rnma+DXFDt3IgdtXUkFz
         9ekAoy8zrwJDLwxRqUWCK+LRutiwPnrCbJhi+5CcTPWXuR7YhrXK2Lz9Q5CwKulOMNoZ
         ihhiI8gveA49U2GMkmMVi9g1B3XZufSXHFZLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=H+tlDNMuPyp3mYJdvElm+iw+OQZcuO4bdIrAFEclJlMvkxYCss8H1E67U+XmzDMCOI
         Oxo6XSUig8CgaMMkOqVr1bwKwCqV8MAFzPEAQ666ge3ENvVEWiyHmdisWYIq34XK3MMU
         9hmtiMzOSByVSinfH50YocJvwpPO8N60EkvSU=
Received: by 10.224.19.199 with SMTP id c7mr8511510qab.140.1291914163467;
        Thu, 09 Dec 2010 09:02:43 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id y17sm1297369qci.33.2010.12.09.09.02.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 09:02:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=qt-uwXdUquRAv_1VpMUQuUR+aNMuxSHdpMhXd@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163294>

Thiago Farina wrote:
> 2010/12/9 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:

>> +static int git_config_from_sha1(config_fn_t fn, const char *sha1_na=
me, void *data)
>> +{
>
> Is worth documenting the return value of this function and what it
> does? It returns 0 on success otherwise returns -1.

If that is the return value, then no.  It is the usual in git (and
other C programs that follow libc conventions).
