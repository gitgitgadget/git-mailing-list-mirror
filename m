From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: HTTP access via proxy
Date: Wed, 3 Jan 2007 14:05:51 +0100
Message-ID: <8b65902a0701030505s1a80ef62vb42b5fe1088218fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 03 14:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H25oZ-0002gs-Sz
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 14:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbXACNFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 08:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbXACNFx
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 08:05:53 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:52220 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbXACNFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 08:05:52 -0500
Received: by wr-out-0506.google.com with SMTP id 68so607722wri
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 05:05:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZWjzLKzuN9vhRdEV8btzGzmQv82eOqaBp4eJfyqGB9wSxO0mS85Gcr5cL+bOCOaaViR5moHMMbDQjwEvj1t6eG/OjMUcuwU80K75zCQfXNPuaeHNN2mHjTUUa2lJvGN6bTC9RQXxvMFLRoCoIROyrrKhJq6FfzCMEe4tCI5zYQ8=
Received: by 10.90.70.10 with SMTP id s10mr14938135aga.1167829551938;
        Wed, 03 Jan 2007 05:05:51 -0800 (PST)
Received: by 10.90.117.19 with HTTP; Wed, 3 Jan 2007 05:05:51 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35864>

Hi,

I'm new to GIT. I've just discovered it recenntly, I found it powerfull.

Actually, I'm trying to "connect" to GIT repositories from office.
There is a proxy. I set the http_proxy varenv. But the cloning failed.

Seems to be a 407 error, but I do not understand what to do. Any help
is welcome.

Here is the output:
$ git-clone http://repo.or.cz/r/cogito.git
Getting alternates list for http://repo.or.cz/r/cogito.git/
Getting pack list for http://repo.or.cz/r/cogito.git/
Getting index for pack 605b6b3b97cd6a8725f9be2c858812646de69340
Getting index for pack fbfa016d2f36e7317c82ccae9ba84f98ee23c232
Getting index for pack 3e83e7bd975592d35f507a83d9d72b8f6fa2f90c
Getting index for pack 3718e548f38e28d2b5c0fa845ecde4fa8011097f
Getting index for pack 2ca93e541574382d920bb2310d774e1c4ce3f097
Getting index for pack ec503789c27cc660192d567defd4d4620e5ff433
Getting index for pack be4d257c2efb91623aeb6031689f348aa897cfd6
Getting index for pack b8d235df7313ca48648dedea9fd059d7fe0fc440
Getting index for pack 05ee5f60265a8cf543e5a42c04af0f7dacdf7ce3
Getting index for pack a33f5335e33bb274e7c838fc0dc6deec5713ca3f
Getting index for pack 8530b481a7f02b3d09fe00c6b6afedc658933dc1
Getting index for pack 4b7808cea29f690eaa10aacff9eac93a38b5ddd3
Getting index for pack f8c8b06fec5010796ce83d3809d022e8e2ac1c16
Getting index for pack 7ddc7c3ff0dc06aefe42ad477ba3be48a54b6c48
Getting index for pack f3e337782d2bf95568a7bd96866c4bdffb2f183f
Getting index for pack 298348359dbe6956c697261eb88b47d9e6c6666e
Getting index for pack 57964c548d649be865d283d6ab3ca10bf302f082
Getting index for pack 78202a8501eff4614d7bb1972902a6c880bb2002
Getting index for pack 51412f3fc46ba6059457a5890369895a96a6b427
Getting index for pack 9b452ef8de67af41587ebb196ca4518280ba1795
Getting index for pack 56df4494fdb935bb2f8de3388c901be086cf9bd7
Getting index for pack cd046245115aa0b088f1b53bba2e68e0000b1c54
Getting index for pack bdf83dd134bd89eca9431f0d6b7601e32d516ae9
Getting index for pack 48baac389492f0071f8713547371eaae5507868d
Getting index for pack 8b4c56b9f2e0d9586b10c24ef87b933f8d3c0d72
Getting index for pack 49e12d13de0cb60255b343c59eeaf61b168fa0de
Getting index for pack 9af7de2760000428a9bb60ea5afc150bb8a60fb8
Getting pack 9af7de2760000428a9bb60ea5afc150bb8a60fb8
 which contains b6a6e87cb3e1368ad0f78c18fdb6c29dde4ae83e
walk b6a6e87cb3e1368ad0f78c18fdb6c29dde4ae83e
Getting alternates list for http://repo.or.cz/r/cogito.git/
Getting alternates list for http://repo.or.cz/r/cogito.git/
Getting alternates list for http://repo.or.cz/r/cogito.git/
Getting alternates list for http://repo.or.cz/r/cogito.git/
Getting alternates list for http://repo.or.cz/r/cogito.git/
Getting pack 49e12d13de0cb60255b343c59eeaf61b168fa0de
 which contains 18d0bd75adae8c1994373e8e5afdb388268c048c
error: Unable to get pack file
http://repo.or.cz/r/cogito.git//objects/pack/pack-49e12d13de0cb60255b343c59eeaf61b168fa0de.pack
The requested URL returned error: 407
Getting alternates list for http://repo.or.cz/r/cogito.git/
error: Unable to find 18d0bd75adae8c1994373e8e5afdb388268c048c under
http://repo.or.cz/r/cogito.git/
Cannot obtain needed commit 18d0bd75adae8c1994373e8e5afdb388268c048c
while processing commit b6a6e87cb3e1368ad0f78c18fdb6c29dde4ae83e.
Waiting for http://repo.or.cz/r/cogito.git/objects/c2/8d9943e5d8a51088266db92030480602c35fc1


Surprisingly, if I download the pack file directly with curl, it works:
curl http://repo.or.cz/r/cogito.git//objects/pack/pack-49e12d13de0cb60255b343c59eeaf61b168fa0de.pack


I'm using:
- a freshly downloaded GIT tarball.
- curl-7.12.1-5.rhel4
- curl-devel-7.12.1-5.rhel4

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
