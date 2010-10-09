From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in case
Date: Sun, 10 Oct 2010 00:31:10 +0200
Message-ID: <201010100031.11791.jnareb@gmail.com>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com> <m3aamng3dt.fsf@localhost.localdomain> <AANLkTinzH3EWy=E2H9hQJzCdPB3Epu5WQkmuv2CWKFtc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 00:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4hwu-0006Uy-K3
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab0JIWbV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 18:31:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33504 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab0JIWbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 18:31:20 -0400
Received: by fxm14 with SMTP id 14so1063889fxm.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=250pN9uK8QVLAqzGc9iM76Cv5RG68Q5xgmphrK+cd2E=;
        b=sYLObOTL8d6HbPK2E8njZ5CRb412qEMvzZLbo9GeQNIAT1NFCvi819AlkghDT69VlL
         kcD83taFoPHfi5HP893tukgajnutT6neD/rQoMmo+EMsInuzMvppOSJWmbu9EXyCjF8a
         O620Xgxt9QwsB15RzSoDqivpaSTeqmywWkpig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K/xwGGrlMoNNiiFau4wynAn2zZNlB4Pbe/nm1EwwXDZ26/dEkMLHGsWR4xMeO22UtU
         3zd03G0inVQPUr0OLhrKv3Z6tInQ2DtGCl0NNnpBEkh14IFQ4VdlcFpUjhOkJwEDb7z+
         fjqofxqhLwhFjr8EUYxX6lkEWDUxEj9abANLc=
Received: by 10.223.73.193 with SMTP id r1mr802055faj.128.1286663479645;
        Sat, 09 Oct 2010 15:31:19 -0700 (PDT)
Received: from [192.168.1.13] (abvg64.neoplus.adsl.tpnet.pl [83.8.204.64])
        by mx.google.com with ESMTPS id m8sm2136882faj.11.2010.10.09.15.31.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 15:31:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinzH3EWy=E2H9hQJzCdPB3Epu5WQkmuv2CWKFtc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158634>

On Sun, Oct 10, 2010, Dun Peal wrote:
> On Sat, Oct 9, 2010 at 3:47 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:

> > Sidenote: why not detect violation earlier, by having pre-commit ho=
ok
> > in each developer repository check for such violation? =A0It is not=
 as
> > time sensitive on the local side (when creating a commit, you have =
to
> > take some time to write commit message anyway).
>=20
> That's a solution, but as you surely know hooks are not automatically
> cloned with the repository. There's no way to ensure that all of our
> many users install that hook, and we can't allow an incorrect state o=
n
> the central node.
>=20
> A pre-receive hook on that node seems like the only way to really ens=
ure that.

Well, if you can control git installation on client side, you can
modify git templates (usually in /usr/share/git-core/templates) to
have appropriate pre-commit hok enabled in all repositories created
there... but I agree that it is not an universal solution.

--=20
Jakub Narebski
Poland
