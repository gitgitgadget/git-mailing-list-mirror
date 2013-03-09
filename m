From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 13:22:00 +0100
Message-ID: <20130309122200.GA7755@paksenarrion.iveqy.com>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
 <CACsJy8CphBDKsAAKjCoze98jv=4U+3pN3cW1OYD5XNhYgfcVCA@mail.gmail.com>
 <CACsJy8BbXjJeTgo0DzKKMY7B3NZB=r3r+Z-WsWJR=t00DkTVzQ@mail.gmail.com>
 <20130309110815.GA8328@paksenarrion.iveqy.com>
 <CACsJy8D4Yqm3s+ALf=KnMQRQ6SrVcM5jjktpGXiGcOaqtEsyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 13:22:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEImt-0007Bb-KQ
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 13:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757220Ab3CIMVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Mar 2013 07:21:41 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44262 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab3CIMVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 07:21:40 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so1969742lbo.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 04:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lCL3TbeAPCazWTwIe9Hv5S9CMK3I0/muasjNDKJjrCc=;
        b=Zd+3qfUl6Ko2OTnXMmnNsW77lJrL0TMjm7dscLsRbfpRCE8/k1K0gUXNHy+IvGE7ps
         tDu/YHY8R+U1Amenmtvl6JN95zzBs6c1SjIHCx1rKC6HvagIYhTIqAr5+Fxniz5qWXLU
         qBYMXHdfQTJoS5vu+6ta+xChkAUaDIWqTTCN5G4UvuG95pzJnVOyktHPbzKS7ZH2haLU
         WnWQXWSWs8+Hl2uSwGHdj/qL6RZ0ZAhDm9P1ROnyzaGC3tZDMosn8sZpouQgaA3BcxHS
         omf2CLpWDxBgz/VrXUwzbCAk4x35ThKAaNW25EFlnUUiX2XeBaicdJvcWkxyKYBZfR7R
         odFg==
X-Received: by 10.112.16.102 with SMTP id f6mr2318326lbd.3.1362831699181;
        Sat, 09 Mar 2013 04:21:39 -0800 (PST)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id fl9sm2570402lbb.9.2013.03.09.04.21.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 04:21:38 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UEImn-000234-S6; Sat, 09 Mar 2013 13:22:02 +0100
Content-Disposition: inline
In-Reply-To: <CACsJy8D4Yqm3s+ALf=KnMQRQ6SrVcM5jjktpGXiGcOaqtEsyMg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217724>

On Sat, Mar 09, 2013 at 07:05:37PM +0700, Duy Nguyen wrote:
> On Sat, Mar 9, 2013 at 6:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> =
wrote:
> > Actually when implemented a str[n]equal_icase that actually should =
work.
> > I break the test suite when trying to replace
> > strncmp_icase(pathname, base, baselen)) on line 711 in dir.c and I =
don't
> > get any significant improvements.
>=20
> Hmm.. mine passed the test suite.

Using my patch or your own code? Maybe I just did something wrong. Coul=
d
you see any improvements in speed?

>=20
> > I like work in this area though, slow commit's are my worst git pro=
blem.
> > I often have to wait 10s. for a commit to be calculated.
>=20
> Personally I don't accept any often used git commands taking more tha=
n
> 1 second (in hot cache case). What commands do you use? What's the
> size of the repository in terms of tracked/untracked files?

It's a small repository, 100 MB. However I have a slow hdd which is
almost full. I often add one file and make an one-line change to an
other file and then do a git commit -a. That will make git to look
through the whole repo, which isn't in the kernel RAM cache but needs t=
o
be reed from the hdd.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
