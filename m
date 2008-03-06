From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: Re: [RFC] git add -a
Date: Thu, 6 Mar 2008 12:57:27 +0200
Message-ID: <e29894ca0803060257u19c98074t789f87e1f8c120e7@mail.gmail.com>
References: <e29894ca0803060223p6de78b1br1aab956c2c99fc1f@mail.gmail.com>
	 <200803061146.00500.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michele Ballabio" <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDoF-0004Io-Kg
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764476AbYCFK5c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 05:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764454AbYCFK5b
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:57:31 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:49529 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764435AbYCFK5a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 05:57:30 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1445829gve.37
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 02:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2nEgOyq3itrhiZOviA1gA31R9Io6HA4LgbkdBPyn28c=;
        b=oJ7a+PSVdaZDtR9Tgs93+LlR9RCeMiX0zys245EnsPbr3p1Bkcdh/TFLSxcbcLLkwdalHk0buMB6W/RWJiKuBGDkRHMNycXD6rIYODU0yHKpP4wCCF8GuPlBX2iWRI6wBfjyjvT43IFjNIkgmmMfWiDlLSpHSlq10kVG6z5CS9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HnFRJcDFhg3rhc/ZazngR9CMZkhNgfyALLil/GedcFP/quJr1869KgcL3hlcOJDmv5K3d3DK8rZtBpbnLA4cIlgmH49aXNI/wSK1dzT2xrweiSTHElWlekwsgS15Msscs9iGa8Dq2bKLFzbnYFJgkcPwoY2NFYVKNP/e72CWoks=
Received: by 10.142.141.21 with SMTP id o21mr1130958wfd.84.1204801047191;
        Thu, 06 Mar 2008 02:57:27 -0800 (PST)
Received: by 10.143.8.21 with HTTP; Thu, 6 Mar 2008 02:57:27 -0800 (PST)
In-Reply-To: <200803061146.00500.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76371>

Hi,

On Thu, Mar 6, 2008 at 12:46 PM, Michele Ballabio
<barra_cuda@katamail.com> wrote:
>
>  There's "git add -u". It should do what you want.
>

Thanks for this answer :) I wonder why "-u" and not "-a".. After all
git commit "-a" could be "-s" if we follow that distinction
(Update/Stage/All).

Regards,

--=20
Marc-Andr=E9 Lureau
