From: =?utf-8?Q?S=C3=A9bastien?= Mazy <melyadon@gmail.com>
Subject: Re: How to prefix existing svn remotes?
Date: Fri, 23 Jan 2009 18:13:55 +0100
Message-ID: <20090123171355.GA20413@locahost>
References: <20090122173211.GB21798@locahost> <4979A64E.6030608@drmicha.warpmail.net> <20090123124231.GA17616@locahost> <4979BFE7.8090402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 18:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPcx-0000K6-AL
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 18:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbZAWROF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 12:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZAWROF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 12:14:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:59221 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbZAWROC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 12:14:02 -0500
Received: by ey-out-2122.google.com with SMTP id 22so992552eye.37
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jDZo+6eugP9ILyFw/ph01nef85Na4vzSewBDHI98G/o=;
        b=ZQGpW/ef83UGsJcLLaFBjNKfdjtNXC9S6vixnR+b4+OcCzJOYFirA0i2V02xx2MEVy
         YszDWCH3gjMJvFsj/QPUQIK1f5ExKpa6cqgl5fUItQWNvHJrGADUQYF1Zk68EuhESo6Q
         7nQOpVyGjdPP+YUn1WOP+z0Ycgmz0/1oLD2CE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EBS1zmIIl7/gD4VLIVopjcH7Y2Mo2P1VUJoPR3l4tkvbvDyxbyvrlpiZtYUCkZuWKj
         TIPvInHrRn9P2RvDgSMAlcgzwuafJQUkumuAArsncXzT46f9OVtp101a3C1lwSOBqbUh
         /arBKu3LRaCZa/w8Hc1eL6QoolDn2sSmoQNfE=
Received: by 10.86.62.3 with SMTP id k3mr920738fga.47.1232730840496;
        Fri, 23 Jan 2009 09:14:00 -0800 (PST)
Received: from localhost (vpn-cl-165-189.rz.uni-karlsruhe.de [141.3.165.189])
        by mx.google.com with ESMTPS id 4sm4593231fge.55.2009.01.23.09.13.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 09:13:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4979BFE7.8090402@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106890>

On Fri, Jan 23, 2009 at 02:02:31PM +0100, Michael J Gruber wrote:
> You can do (bash)
>=20
> for b in trunk branch0
> do
>   git update-ref refs/remotes/yournewprefix/$b refs/remotes/$b
>   git update-ref -d refs/remotes/$b
> done

That did the trick. Thank you so much!

By the way, my renamed remote tracking svn branches now show under
=2Egit/refs/ as expected.

--=20
S=C3=A9bastien Mazy
