From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH] Add some new icons, and apply them where appropriate
Date: Fri, 15 Aug 2008 00:52:43 +0200
Message-ID: <48A4B73B.9090605@gmail.com>
References: <48A33C8E.6050008@gmail.com> <200808150002.40762.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlhd-0002XS-1X
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYHNWwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 18:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbYHNWwy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:52:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:62121 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYHNWwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:52:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so463048nfc.21
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Q501RKntO6o+GDjAvhMkCVBDy935FkzMfvWRW/snYOg=;
        b=cLSnAPFrtoHUX/cYqbkVBaLn7kJfMLpxngNnnke2wBM36eL6aXAr+zV6t/WwBDuAlb
         ZGPKBZ1agmMqHLCBUZEby067i4G1nwdH28rSGsROmTsJvAQVR7UNeljspZRQNurPaSrO
         kbhbg8hIo4McDX8jaFn2Zxzon/xmuWzAn/Wdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LTY+EiLlGa2qJrWSFIvwU6Gya4eUcX2It3rIK/9jQp9PdMFSSPEpGHGxs6NdKciopp
         /t56DHFKX2lDawHk5aR7XHRN1c3oxMADJ2D6w92KCX7jnuTSLeL7cZsvaBeh87xllUq9
         Tz+M3dM5S3Ce4Tf8I6CAbMdD06B2Gmh9fjmQY=
Received: by 10.210.16.1 with SMTP id 1mr2085081ebp.98.1218754372099;
        Thu, 14 Aug 2008 15:52:52 -0700 (PDT)
Received: from ?192.168.1.20? ( [84.202.12.123])
        by mx.google.com with ESMTPS id b30sm3251079ika.3.2008.08.14.15.52.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 15:52:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200808150002.40762.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92432>

Robin Rosenberg wrote:
> onsdagen den 13 augusti 2008 21.57.02 skrev Tor Arne Vestb=F8:
>> These icons are based on look of the existing CVS and
>> SVN plugins, only with a Git branding (gray, red, green).
>>
>> Having the same look and feel as the other team plugins
>> will probably help us in being distributed as part of
>> the Eclipse platform.
>>
>> Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>
>=20
> Looks nice,

Thanks

> but please remove the icons that are not actually used from the
> patch.

Done. I know I'm going to need them later though (commit dialog,
synchronize view), but that's OK.

> I also wonder also whether the sharing icon should have a network-lik=
e
> symbol. Connecting a project to a git repo involves no networking unl=
ike
> most other SCMs.

True. We could use the newlocation_wiz/newlocation_wizban pair. That
would actually also be consistent with what the newlocation-action
does for the CVS/SVN plugins, because we are hosting the repo locally.
It also signals that 'sharing' the repository does not involve pushing,
although we could have that as a separate step in the wizard (and then
use the 'network' icon).

On that note, have we considered something like the "CVS Repositories"
view, only for remotes?=20

I imagine the sharing wizard going something like:

Scan/create new repo -> Add remotes -> Push -> Finished

With the usual option to Finish earlier of course.


> Welcome to the project, btw!

Thanks! :)


Tor Arne
