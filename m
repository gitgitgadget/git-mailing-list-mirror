From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-svn changing file:// to svn+ssh://
Date: Mon, 26 Oct 2009 15:18:42 -0400
Message-ID: <32541b130910261218x5fdc0233jcce7c5769aad73ec@mail.gmail.com>
References: <4AE5EF55.2070902@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Mon Oct 26 20:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2V5y-0002zw-98
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 20:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZJZTS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbZJZTS6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 15:18:58 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:37947 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbZJZTS5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 15:18:57 -0400
Received: by ywh40 with SMTP id 40so8549700ywh.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=a+2NbUnopOwtB8AZ0qy59faReorzM1fytb3rSUW+s1s=;
        b=FhBxmTkH6/xRuvmw+csWZRQ/LF2vGkjPWmi7oPPMWs/GfDlpAjDMozdwmHesjUjnCW
         juXEhk4hVZ7Krj2JBabHgzO09CH3LELGWC5CgTlPEVlfnuCqsZ0/f6ola3Gs/e8+Gt4L
         J5NMfABJMyrKLDPa0CImH5qSPRP6B9/9YKtb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=K/7CLmSCCV1EheuqzWlk0CN3Er4h0hzty/b4rpn+OG2cuyNvMF1fXyHBSwdlVoNUnt
         Z9OFtsk9a3hhLyS7s1KL5vXWixYcEMnQCXAb93MlLY9cYZ4pMis7mphgyinzYN+lt8tA
         jCveIN3JQ/ACcyVToVf2zyxcWdpr45hL7/1Zk=
Received: by 10.150.114.14 with SMTP id m14mr4368057ybc.162.1256584742220; 
	Mon, 26 Oct 2009 12:19:02 -0700 (PDT)
In-Reply-To: <4AE5EF55.2070902@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131262>

On Mon, Oct 26, 2009 at 2:49 PM, Pascal Obry <pascal@obry.net> wrote:
> On a large project it is failing. Here is what I have done:
>
> I have cloned the repository using:
>
> =A0 $ git svn clone --prefix=3Dsvn/ file:///path/repo \
> =A0 =A0 =A0 =A0--revision=3D15314:HEAD --trunk=3Dtrunk/project \
> =A0 =A0 =A0 =A0--tags=3Dtags/project --branches=3Dbranches/project \
> =A0 =A0 =A0 =A0--branches=3D"branches/global/*/project" project
>
> Not simple, ok but working :)
>
> Now I have converted the file:// to svn+ssh:// using:

I'm not sure about the actual bug you're experiencing, but you could
have done this more simply using the --rewrite-root option to git-svn.
 It might still save you time to just do that from scratch.

If you really want to debug it, you might want to run it through
'strace' and see if it's having any trouble creating those files.

Have fun,

Avery
