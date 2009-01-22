From: =?utf-8?Q?S=C3=A9bastien?= Mazy <melyadon@gmail.com>
Subject: How to prefix existing svn remotes?
Date: Thu, 22 Jan 2009 18:32:11 +0100
Message-ID: <20090122173211.GB21798@locahost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 18:33:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ3R1-0007GX-Vx
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbZAVRcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 12:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbZAVRcU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:32:20 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:64132 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbZAVRcS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 12:32:18 -0500
Received: by ewy13 with SMTP id 13so2793782ewy.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=CLWUypwZUGEh6q6vWY35HBEjTuzEtqwiBokgrowcdLc=;
        b=DQwVvhsTyPsHN4233QxAHeykTdkR654vRuUOHKofgOn9nOVsXr4DFd7yA/Yg498ACp
         elFxACtMnMH5rD14DN2jJGaheq+7lwzZtYD9s8Afd/G6p0u0eHvRTWTJkrZDovwnfcTf
         GrEaTlpoSKwPZ0OPNnF2qNGeh8nfCL+JjtAFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=cX5vEAeqaVyWnOka6eXAuZgXQWcDuDrtQ6HIx5UF9B8Abl/lCmjojSTlN+BudtSKo0
         Kk+K8m2JVH1ctUMGJ0OHyQBwLHCkG1QammYhzmO0OloMBTVS5AlyWNH0hDu9Asx+XNGO
         3DXJiXUwoXMxLaMAUWWL4QLuSTa+eZ5BwHJnY=
Received: by 10.86.95.8 with SMTP id s8mr313832fgb.28.1232645535858;
        Thu, 22 Jan 2009 09:32:15 -0800 (PST)
Received: from localhost (vpn-cl-166-68.rz.uni-karlsruhe.de [141.3.166.68])
        by mx.google.com with ESMTPS id e20sm2059382fga.53.2009.01.22.09.32.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 09:32:15 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106779>

Hi all,


I created a few months ago a git-svn repository using:
git svn clone -s https://my_svn_repo .

wich also created the following remotes:
git branch -r
  branch0
  tags/tag0
  trunk

I would like to prefix theses remotes, so that it shows:
git branch -r
  prefix/branch0
  prefix/tags/tag0
  prefix/trunk

Of course I should have used the -prefix back when creating the repo bu=
t
it's too late. 'git help svn' doesn't explain how to achieve that and
simply editing .git/config to add the missing prefix will cause the nex=
t
'git svn fetch' to download again the whole history (which in my case i=
s
huge).


Is it possible? Did I miss something obvious?


Cheers,

--=20
S=C3=A9bastien Mazy
