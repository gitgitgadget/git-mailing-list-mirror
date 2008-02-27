From: =?ISO-8859-1?Q?Gabriel_Salda=F1a?= <gsaldana@gmail.com>
Subject: Re: msgmft segfaulting on tiger
Date: Wed, 27 Feb 2008 12:42:02 -0600
Message-ID: <47C5AEFA.5020004@gmail.com>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>  <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>  <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 27 19:40:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURCY-0002dG-LQ
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529AbYB0Sja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 13:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755776AbYB0Sja
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:39:30 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:56137 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbYB0Sj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:39:29 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2975555wxd.4
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=I0ItcbKIvhXG7A9u8YRvsyen9Ks98yjy22jCaGqVcDA=;
        b=wuG6eIhMQGZDIl2xUeYg5xb4NWKpeiGP7cx+F7ZK6ZUypyTi8yPa74BHOCs/NJAAm2/fuAgU6CjhvwprDzQ8nMPqyN/lhQ109FmNoeQ5JySUMuj/BHEOiX7cjVp3dFmmIqr9Op0JN8XzvxF6ITsdkVrJWXoC0GiUasgMj5XtNgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=EC8ASl+jKo4vzorBMgoOdGrkkVZsfFpUwqDPNNIz9/MK8OTuOkTna9KqnQmcGBxhrW2T0s+IB341U7Dzj4jWIJUfqGIxUEg993yQlcKBCZ1fYYx369sO6yyPfr1QetgXt2WtplLvC/CVd/AYulGM2h+bBJZrx81riSQrJgyszmQ=
Received: by 10.141.193.1 with SMTP id v1mr4812533rvp.245.1204137567839;
        Wed, 27 Feb 2008 10:39:27 -0800 (PST)
Received: from ?192.168.0.121? ( [189.152.130.115])
        by mx.google.com with ESMTPS id t1sm13718205poh.0.2008.02.27.10.39.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Feb 2008 10:39:27 -0800 (PST)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <alpine.LSU.1.00.0802271825330.22527@racer.site>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75244>

Here it is:

$ msgfmt --tcl; echo $?
msgfmt: unrecognized option `--tcl'
Try `msgfmt --help' for more information.
1

Gabriel

Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 27 Feb 2008, Gabriel Salda=F1a wrote:
>=20
>> msgfmt --statistics --tcl -l de -d po/ po/de.po msgfmt: unrecognized=
 option
>> `--tcl'
>=20
> Could you try this, please:
>=20
> $ msgfmt --tcl; echo $?
>=20
> Maybe we can have a clever autodetection of msgfmt which does not=20
> understand --tcl?
>=20
> Ciao,
> Dscho
