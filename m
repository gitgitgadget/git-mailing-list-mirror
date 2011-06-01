From: Robert Garrigos <robert@garrigos.cat>
Subject: unable to get type of object
Date: Wed, 01 Jun 2011 09:11:07 +0200
Message-ID: <4DE5E60B.2030903@garrigos.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 09:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRfW9-0002Uo-Cf
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 09:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab1FAHG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 03:06:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64082 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab1FAHGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 03:06:55 -0400
Received: by wwa36 with SMTP id 36so5689851wwa.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 00:06:54 -0700 (PDT)
Received: by 10.227.204.197 with SMTP id fn5mr6870057wbb.36.1306912014131;
        Wed, 01 Jun 2011 00:06:54 -0700 (PDT)
Received: from robert-garrigoss-macbook-pro-3.local (r15.santpau.es [193.146.15.253])
        by mx.google.com with ESMTPS id en1sm530175wbb.35.2011.06.01.00.06.52
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 00:06:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; ca; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174852>

I'm having one of those nasty 128 errors which I cannot debug:

************
predircam@eduab:~/public_html/idosing> git pull
Generating pack...
Done counting 117 objects.
error: unable to find c3117d23df0c01ba8558bad81ad3488f0e8d430a
fatal: unable to get type of object c3117d23df0c01ba8558bad81ad3488f0e8=
d430a
fatal: early EOF
fatal: git-unpack-objects died with error code 128
=46etch failure: /home/predircam/gitrepos/idosing.git
***************

google suggests me to run git fsck to get a list of corrupted files.=20
Besides that I'm running git 1.2.4 and that the git command for that=20
version is fsck-objects, I'm not having any result at all.

Could this be a compatibility problem? As I said, I run git 1.2.4 on th=
e=20
repo server and git 1.7.0.2 on my development server. BTW, on my devel=20
server running the git command fsck gives no result either.

I would appreciate any help.

Thanks
--=20

Robert Garrig=F3s
Tf. 607 997 973
http://garrigos.cat
