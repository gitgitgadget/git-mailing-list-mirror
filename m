From: Anand Kumria <akumria@acm.org>
Subject: git svn clone issues with buddypress subversion repository
Date: Sat, 24 Sep 2011 17:50:39 +0100
Message-ID: <CAM1C4G=o_Q5scdv=Jk3ou-3OjnZiukZV3nz0NJR7CTaKLbB2jw@mail.gmail.com>
References: <CAM1C4G=YbK5PF21UujxNRR0PX9xqQBSEvcB45Zxy1hwZuyuL8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 18:51:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7VRd-00035w-UY
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 18:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab1IXQvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Sep 2011 12:51:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47680 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab1IXQvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 12:51:10 -0400
Received: by wwf22 with SMTP id 22so4931589wwf.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=KK/UZRsmnxAKn86Gq/x4FfDFKW2Qd48Fg2dLfkrVdWI=;
        b=G4LbEUGEBWD5e8P7BkJ2c18ZEkqVLrCxypzyvx5N/ntQxzmtuvURt1jyGDXkxUv8rq
         wDNuleweMMhMKkgYGFkv53ft7v/cRvWfRBZZr3PVetpIx7zh78AB5rew4n6y9WdcQvAq
         9fz+xoh3AzAqoiUB/qyi3PXYy2kK16kD77nTU=
Received: by 10.227.11.18 with SMTP id r18mr5053227wbr.14.1316883069148; Sat,
 24 Sep 2011 09:51:09 -0700 (PDT)
Received: by 10.180.100.168 with HTTP; Sat, 24 Sep 2011 09:50:39 -0700 (PDT)
In-Reply-To: <CAM1C4G=YbK5PF21UujxNRR0PX9xqQBSEvcB45Zxy1hwZuyuL8Q@mail.gmail.com>
X-Google-Sender-Auth: pmYX5uAdDh5TpogjFJ8g04FvKi4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182034>

Hi,

I'm trying:

% git svn clone -s http://svn.buddypress.org/trunk/ buddypress
Initialized empty Git repository in
/home/anand/Projects/wordpress/buddypress/.git/
Using higher level of URL: http://svn.buddypress.org/trunk =3D>
http://svn.buddypress.org

% git --version
git version 1.7.0.4

And at the end, git svn appears to successfull complete but nothing
has occurred. I'm successfully using 'git svn' against other
repositories with no problem, just wondering if anyone else has come
across this.

% find buddypress
buddypress
buddypress/.git
[omitted]
buddypress/.git/svn
buddypress/.git/svn/refs
buddypress/.git/svn/refs/remotes
buddypress/.git/svn/refs/remotes/git-svn
buddypress/.git/svn/refs/remotes/trunk
buddypress/.git/svn/refs/remotes/trunk/.rev_map.cdf35c40-ae34-48e0-9cc9=
-0c9da1808c22
buddypress/.git/svn/.metadata

% cat buddypress/.git/svn/.metadata
; This file is used internally by git-svn
; You should not have to edit it
[svn-remote "svn"]
=C2=A0=C2=A0=C2=A0 reposRoot =3D http://svn.buddypress.org
=C2=A0=C2=A0=C2=A0 uuid =3D cdf35c40-ae34-48e0-9cc9-0c9da1808c22
=C2=A0=C2=A0=C2=A0 branches-maxRev =3D 5188
=C2=A0=C2=A0=C2=A0 tags-maxRev =3D 5188

Thanks,
Anand
