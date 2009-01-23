From: =?utf-8?Q?S=C3=A9bastien?= Mazy <melyadon@gmail.com>
Subject: Re: How to prefix existing svn remotes?
Date: Fri, 23 Jan 2009 13:42:31 +0100
Message-ID: <20090123124231.GA17616@locahost>
References: <20090122173211.GB21798@locahost> <4979A64E.6030608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 13:44:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQLOF-0005Zw-OI
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 13:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbZAWMmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 07:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbZAWMmj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 07:42:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:44848 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbZAWMmi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 07:42:38 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2540249fgg.17
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=COo5/iuF4qDnoDjsgdIUPDlFmVKtE44yX8QXUSQ806s=;
        b=d0QaT2QC7KUUoJtbJDEjd99fELL9K4JqJbkp6GpciTH9SSjAFlChGnfK/oo7O2rqiX
         /3zmERDquwxKQBZrOjTk0ljFev/2bU1zdS/V5/z9Kx5bSKp3ST+WZz60hVPCgepIcl+n
         P6stfdsjfoGRBE16gDH5QstAOBQfnd2tdh6wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pN6FnsxpcQKe0SzkeolAw3bs+6whf/zA5D7Is8FF4zqPDo5yhKXN0J79Ly5LYMtjdI
         GMMcZLSGzHVtnpNRzTta7WC5lujC25dyPAikNTG93jDeNzCh2/S+7feo1ppiFljOOIpY
         bFtvdKr/UByBfxaKdtF83s1iGtprA4SJ1CVV4=
Received: by 10.86.57.9 with SMTP id f9mr369737fga.32.1232714556602;
        Fri, 23 Jan 2009 04:42:36 -0800 (PST)
Received: from localhost (vpn-cl-165-189.rz.uni-karlsruhe.de [141.3.165.189])
        by mx.google.com with ESMTPS id d4sm4219994fga.51.2009.01.23.04.42.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 04:42:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4979A64E.6030608@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106877>

Hi Michael,

Thanks for your reply.

On Fri, Jan 23, 2009 at 12:13:18PM +0100, Michael J Gruber wrote:
> The following works for me:
>=20
> 0) fetch to make sure you're current (optional)
> 1) edit .git/config and add the prefix (right hand side of the
> refpsecs), or really rename in any way you want

OK.

> 2) rename the existing remote branches in the same way

I'm not sure how I can do it. 'trunk' is the only remote-tracking svn
branches under .git/refs/. Here is how it looks:

ls -R .git/refs
 .git/refs:  heads  remotes  tags
 .git/refs/heads:  master
 .git/refs/remotes:  trunk

Still, a 'branch0' remote exist:

git show-ref
 refs/heads/master
 refs/remotes/branch0
 refs/remotes/trunk

--=20
S=C3=A9bastien Mazy
