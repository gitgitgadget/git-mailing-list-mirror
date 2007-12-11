From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git blame with valgrind massif
Date: Tue, 11 Dec 2007 16:45:48 -0500
Message-ID: <9e4733910712111345i23d86a85jfedb4f37f20a5b0@mail.gmail.com>
References: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com>
	 <20071211212052.GC29110@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Cvg-0005Qq-Ew
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbXLKVpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 16:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbXLKVpy
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:45:54 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:58699 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbXLKVpy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 16:45:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2176626rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 13:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kG8VLr1CatTVWfE0XCqzNvVjaGumC3+vVWvAuvFob3M=;
        b=O6n2XQTUr3Ckd58KJwqid4J7obfVZwdTQz5P8q+8uvl16hx7lnf4b/f7dBwT982lEC7dii6jD5jXlrX532rP4NulCmwurDO7ww5cS09ilNELX44qFozoClUH1I1tI4m3igzkUvkPWtXz5x2LZeBg1FZ8TcjCGXfnrtdiQs3pqbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o00OIwCIMFjBYqGtqN7a6dgBGesdMksklgpXtUP8e78zA4pZ8fbk5dr0j1LRQPgmymGXXhRBEmvjcfTUAcNhuRUpuxhgslOX1qITqJokYemrFt2IBjAYI2+qFmEMTi59JPCwy18nEJ5iarlbbXplEorSf44p6YBXdMDRnIGaLN0=
Received: by 10.141.99.4 with SMTP id b4mr2394440rvm.1197409548926;
        Tue, 11 Dec 2007 13:45:48 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Tue, 11 Dec 2007 13:45:48 -0800 (PST)
In-Reply-To: <20071211212052.GC29110@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67952>

On 12/11/07, Pierre Habouzit <madcoder@debian.org> wrote:
> On Tue, Dec 11, 2007 at 08:57:24PM +0000, Jon Smirl wrote:
> > I ran:
> >  valgrind --tool=3Dmassif --heap=3Dyes git blame gcc/ChangeLog
> > it used about 2.25GB
> >
> > How do you interpret the massif output?
>
>   would you mind putting the postscript it generated somewhere too ?
> it's usually pretty informative, because the amount of data allocated=
 is
> not all, its liveness is an important information too.

It was very boring. A diagonal line from 0 to 2GB.

>
> --
> =B7O=B7  Pierre Habouzit
> =B7=B7O                                                madcoder@debia=
n.org
> OOO                                                http://www.madism.=
org
>
>


--=20
Jon Smirl
jonsmirl@gmail.com
