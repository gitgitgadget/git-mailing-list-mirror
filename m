From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: StGit and charsets
Date: Mon, 4 Aug 2008 11:21:31 -0400
Message-ID: <9e4733910808040821t492b74fcq7c2178690c0a6831@mail.gmail.com>
References: <9e4733910808040721n6c47908o9d8fabd8f16293c1@mail.gmail.com>
	 <20080804153146.GF12232@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:22:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1tN-0001J3-2p
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbYHDPVd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 11:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbYHDPVd
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:21:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:34089 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbYHDPVc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 11:21:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so157221yxm.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PPXgVRnC6Zsi4W/p4y371xwgwZC1sGzpZjYY3W+26RY=;
        b=SeczOQnmrfjcLoYfnbq+Sq+iV3CRzbQySt3DVH4b6k9Moj1CAa0M/GL/7vBrTi7a8l
         vAUQgZ5bZI+9mMl1T1ASjNdNegaif1LcWN90AQZ4TUpKAXlyHd2zSzsaDo/3Cmgc4Roh
         o/3HVJMcnPyPvU1evpIiWIO15Gu6LkUI4u5WI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=yGtIeZCF2tTxcn8+pa1dBG0xLfI0IhC0uZOsGdoPtnsNUlF70r5rcY6ZQsBJJkdkQG
         vIgXCo8mG/OmZ/nmocMw+FuzyRodUT1v/DJvHTG7vt7c5MG2FcNt+2Dsw3wMfQJY/XYq
         T/h6pDh07FrP+EpOLUKQCEeaE4bFkowhk2smE=
Received: by 10.151.149.14 with SMTP id b14mr1480754ybo.236.1217863291247;
        Mon, 04 Aug 2008 08:21:31 -0700 (PDT)
Received: by 10.65.214.7 with HTTP; Mon, 4 Aug 2008 08:21:31 -0700 (PDT)
In-Reply-To: <20080804153146.GF12232@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91372>

On 8/4/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-08-04 10:21:20 -0400, Jon Smirl wrote:
>  > I don't work much with international charsets. If someone is using
>  > something like Russian or Finish locally, is the metadata in the
>  > patch converted to UTF8 before exporting or sending it as mail?
>
>
> I think what happens is that it's assumed to be utf8. No one has
>  complained that their non-utf8 locale doesn't work, but my guess is
>  that's because those people just haven't tried StGit yet.

This might be worth testing for Asian locales. If Asian locales make
it through ok everything else probably will too.

I don't know enough about Unicode to decode the mangled names, I
suspect they are still in the local charset and haven't been UTF8
converted.  Of course the name mangling may be coming from other
tools. There is no way to tell.

This problem happens in other ways in the kernel. There is a file in
the DRM code where two people's names have been inserted in different
charsets. If I set my editor to display one right the other is always
wrong. checkpatch probably needs to make sure that patches are
completely valid UTF8.

--=20
Jon Smirl
jonsmirl@gmail.com
