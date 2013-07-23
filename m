From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: getting git from kernel.org is failing
Date: Tue, 23 Jul 2013 22:06:05 +0200
Message-ID: <20130723200605.GE5129@paksenarrion.iveqy.com>
References: <51EEDC78.4000507@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 22:04:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1iof-0005nU-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 22:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab3GWUEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 16:04:09 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33772 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab3GWUEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 16:04:08 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so6652004lbj.14
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yiq9iDqINFx68DrlTffCTz02fRH6t9Me34osx2EuChA=;
        b=Jdx3h8nw5PkatFTKlikvUX2QnMhjRwBdmsh576e3semPDKRxISl2JXdgapFfWm/81U
         VlrGhSjg8s/l5RXlQGdHpDfZxH3qRbz8+PZIPHvGfCQvLLJSSvGJMuWmasWc0GX6YMg4
         MnyNdMq+tXDTZmN8g2WCbuWTQQUW1MWNPl6AJVS31u1RsW58q838VIzktEqRWwkJ1Nzz
         7HNZvnIl74JsNkTpxMnNqCMGOVv2XdLjR0de2kTIkimCFFubZSMPmF9Q/qqyms9iy0pi
         nSAH8PEJ3zUbhloE8aoXrGoRfACPkCdmSFXt6efN43UjBj9zt2gI0Kzj9T5hsx2UQfb4
         ZPRw==
X-Received: by 10.152.36.6 with SMTP id m6mr920590laj.65.1374609845767;
        Tue, 23 Jul 2013 13:04:05 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id u1sm13683992lag.5.2013.07.23.13.04.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 13:04:05 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V1iqT-0007NI-2l; Tue, 23 Jul 2013 22:06:05 +0200
Content-Disposition: inline
In-Reply-To: <51EEDC78.4000507@googlemail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231057>

On Tue, Jul 23, 2013 at 09:41:44PM +0200, Stefan Beller wrote:
> git clone https://git.kernel.org/cgit/git/git.git
> Cloning into 'git'...
> error: Unable to get pack index https://git.kernel.org/cgit/git/git.g=
it/objects/pack/pack-1e2bca8b5127039cff42b1cd3d47767fb577cd4f.idx
> error: Unable to get pack file https://git.kernel.org/cgit/git/git.gi=
t/objects/pack/pack-6bfd3af75af71d7bf66a80d6374ac09245ad3ce5.pack
> The requested URL returned error: 404 Not found
> error: Unable to find bce6db96a333c2d47b07580c5a9207cf10935378 under =
https://git.kernel.org/cgit/git/git.git
> Cannot obtain needed blob bce6db96a333c2d47b07580c5a9207cf10935378
> while processing commit 5addd1c7531cc644787cd562a3c22a3b714c7d77.
> error: Fetch failed.
>=20
> as reported by ivegy on freenode/#git-devel
>=20
> Stefan
>=20

Confirmed (tested both with and without trailing /, IIRC there was some
configuration change recently that effect that):
iveqy@kolya:~/slask/git$ git clone
https://git.kernel.org/cgit/git/git.git/
Klonar till "git"...
error: Unable to get pack index
https://git.kernel.org/cgit/git/git.git/objects/pack/pack-1e2bca8b51270=
39cff42b1cd3d47767fb577cd4f.idx
^C
iveqy@kolya:~/slask/git$ git clone
https://git.kernel.org/cgit/git/git.git
Klonar till "git"...
error: Unable to get pack index
https://git.kernel.org/cgit/git/git.git/objects/pack/pack-1e2bca8b51270=
39cff42b1cd3d47767fb577cd4f.idx
error: Unable to find d6b65e204c6009e5c30f358810198319b70eda25 under
https://git.kernel.org/cgit/git/git.git
Cannot obtain needed blob d6b65e204c6009e5c30f358810198319b70eda25
while processing commit 5addd1c7531cc644787cd562a3c22a3b714c7d77.
error: Fetch failed.
fatal: Reading from helper 'git-remote-https' failed
iveqy@kolya:~/slask/git$=20


--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
