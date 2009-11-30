From: Dan Carpenter <error27@gmail.com>
Subject: Re: does clone --depth work?
Date: Mon, 30 Nov 2009 10:18:00 +0200
Message-ID: <20091130081800.GR10640@bicker>
References: <20091129160352.GO10640@bicker> <20091129163242.GA7921@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1SW-0006qP-GO
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZK3IR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 03:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbZK3IR7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:17:59 -0500
Received: from mail-ew0-f215.google.com ([209.85.219.215]:51180 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbZK3IR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:17:58 -0500
Received: by ewy7 with SMTP id 7so4185382ewy.28
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+mO3NxF42d+ZqdOlRq9dZiHSwFZ56MEs1+CRsR0We9k=;
        b=r6o3WOFbr9X04XlB60PFVjTcN/1KOsoYyWleGmX9DS86/wLeLpHgzPkZdiueHH6DvG
         KSevefv2l2yWZKTGv0cemW9PnQmxiwY9s9FIW+6pgW3dB18mxlYF0n673kVTxDRAycOG
         Hf2z/V2tYFQrFW3ZdqL5Sh29wF5sqpP8r4eDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lXceAc2xrDTXtzZMsPYT8xcXpNsi6OyNBlyW+daChjnTTE6bf1CtT+BmW+UlJdHJv3
         M/L138BAzRWxFvwP2Ez4VMTMDMbN+8CJCjrFjrHtd1hjkDbjJeT0CqWBcERd7zJVxyq0
         TbPwncgbcL0/vhHJh3c2Jlpq6pk2MHlBqyO/Q=
Received: by 10.213.107.17 with SMTP id z17mr4526387ebo.10.1259569083827;
        Mon, 30 Nov 2009 00:18:03 -0800 (PST)
Received: from bicker ([41.222.20.196])
        by mx.google.com with ESMTPS id 14sm2416565ewy.11.2009.11.30.00.17.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 00:18:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091129163242.GA7921@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134080>

On Sun, Nov 29, 2009 at 05:32:42PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.11.29 18:03:52 +0200, Dan Carpenter wrote:
> > I do: `git clone --depth 0 ./repo1/ repo2`  I expected that=20
> > "git log" in repo2 wouldn't show any revisions, but it does.
> >=20
> > I'm using 1.6.5.3.171.ge36e.dirty (small unrelated modification).
> >=20
> > Am I doing something incorrectly?
>=20
> Two problems:
> a) IIRC depth =3D 0 is like not specifying depth at all
> b) When using plain paths, clone optimizes the process by just doing =
a
> copy, that doesn't apply the depth setting at all
>=20
> git clone --depth=3D1 file://$PWD/repo1 repo2
>=20

Awesome.  That does work.

thanks,
dan

> That should work. Of course you still got some commits, so "git log"
> will show them. You just don't get all of them, but only to a certain
> depth.
>=20
> Bj=F6rn
