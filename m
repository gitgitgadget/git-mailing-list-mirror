From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 16:13:37 +0100
Message-ID: <e5bfff550909250813y27971c12m63d445272f674f1c@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
	 <4ABC9C5D.5030202@viscovery.net>
	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
	 <4ABCD6AF.8080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: alexandrul <alexandrul.ct@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 17:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrCUT-0000Fi-9Z
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 17:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZIYPNf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 11:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbZIYPNf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 11:13:35 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:53123 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbZIYPNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 11:13:34 -0400
Received: by ewy7 with SMTP id 7so2652937ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fnpsUX/sfmSwp0H9Z+USkLYPsgCsMryVt8YbMLp0H/4=;
        b=UH0JMfTBy5tDdyP2nVXQNwY3MJHw3n0TmsAKklylkBg4n8DFTPkOyl5DG0M0u1mYCW
         UIfCaWPAdoUb/aGIUgxAwruBDyYEmNfVWgojR84tIwNxT0UXjmj/FKAqXhOpowTu3xKl
         vkN1AZS2uOSyhHUWnFQC8YqrNTHL0Ti6oUjMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XNJVhzfmJnDRD9OJ5NYYc5//0ln3DjCIgTPK+mURO+tzLOTCNgOmxISSib6zLvTzce
         sEVBdzMpp8cyfrHiBWYiTApnff2qZFiXXKULltw/+XML2w8lOYNZQphezWas/KfMclDV
         HCmv1p9nc7MyJqzVM84F9teH4W0yPlJjia7CQ=
Received: by 10.216.2.213 with SMTP id 63mr51232wef.207.1253891617523; Fri, 25 
	Sep 2009 08:13:37 -0700 (PDT)
In-Reply-To: <4ABCD6AF.8080407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129089>

On Fri, Sep 25, 2009 at 15:41, alexandrul <alexandrul.ct@gmail.com> wro=
te:
>
> If nothing else works, you could try to uninstall your current versio=
n of
> git, clean up any traces left, and reinstall.
>
> http://code.google.com/p/msysgit/issues/detail?id=3D336
>
> Have a nice day,
> =C2=A0A.
>

Thanks, I have tried but with no success.

Another info is that it seems git related, from msysgit bash shell:

$ ls -a
=2E .. .git

$ ls -A
=2Egit

$ git --version
git version 1.6.4.msysgit.0

$ git --VERSION
git version 1.6.4.msysgit.0

So only the git command seems to treat command line arguments in a
case-insensitive way, while other commands do not.
