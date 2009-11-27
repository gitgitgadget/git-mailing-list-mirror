From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Breaking expectations in 1.7.0, was Re: What's cooking in
 git.git (Nov 2009, #06; Wed, 25)
Date: Fri, 27 Nov 2009 09:33:49 -0600
Message-ID: <20091127153349.GA24647@progeny.tock>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
 <20091127065904.GE20844@coredump.intra.peff.net>
 <20091127144553.GA24366@progeny.tock>
 <alpine.DEB.1.00.0911271536100.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 16:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE2dt-0000Nx-CC
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbZK0PVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 10:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbZK0PVk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:21:40 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:33835 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbZK0PVk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 10:21:40 -0500
Received: by yxe26 with SMTP id 26so1379913yxe.4
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Jgj2PF/LnGurptKFf+sCgX1nSPHiFT9zBNWmS1PM+tM=;
        b=v80bgJ/RoM4hxAj09CO3KLa2Ghg2R+R0doq+O3XUDBpVxEfQxtCk73/otzNx3v1GJ7
         YrL3vxQwlPbYH0Tx24BD/ikV22V7tpjiCrrKwoeSNTY6j2G4SAbsc1SHhPgB7Zm9IIdw
         DCglOc4NEHZKhgslGD/cofazTh51F/SIu2pXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dCTog21hguevX4c0jeZgpDgxT6TbwCBsf3C+36sUyFsaLVZ3U2p3VTzxx8ZDAoW/h7
         d6Rs+n/hWPAybfFe6X3JkRRxjzIbyIs3Y/Iz6KmwsYWxzTpLXih0ARY/RGaZrV9jtkIc
         3jHL05G6YWIGlx/ekZnstCJZupfxyrjxoWhxg=
Received: by 10.100.233.35 with SMTP id f35mr492593anh.41.1259335306391;
        Fri, 27 Nov 2009 07:21:46 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 5sm851807yxd.17.2009.11.27.07.21.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 07:21:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0911271536100.4521@intel-tinevez-2-302>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133901>

Johannes Schindelin wrote:

> I recently read more and more about 1.7.0 being expected to break=20
> expectations, and more and more expectations about more and more bein=
g=20
> expected to be broken there.
>=20
> This is a very slippery slope.  You have been warned.

I was trained by 1.6.0 and 1.5.0, I guess.  I think it would be hard to
argue that 1.5.0 breaking compatibility in some places (the behavior of
'git add', for example) was a bad thing.  I also liked the major 1.6.0
change, but I did have the benefit of being warned far in advance.

Of course, the best break with compatibility is the one that does not
break expectations.

I=E2=80=99m on the fence about the default git grep behavior for that r=
eason.
I think --full-tree really would be a better default.  Every once in a
while, I really do find myself wondering why git grep has not given me
the results I expected; it can take a moment to remember that this is
because I am in a subdirectory.  But it is not clear it is worth the
change.=20

Am I right to infer you are less conflicted about this, or was it just
a good opportunity to bring to mind that important principle?

Jonathan
