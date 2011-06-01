From: Robert Garrigos <robert@garrigos.cat>
Subject: Re: unable to get type of object
Date: Wed, 01 Jun 2011 12:05:47 +0200
Message-ID: <4DE60EFB.40601@garrigos.cat>
References: <4DE5E60B.2030903@garrigos.cat> <m3ei3dyjqe.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 12:01:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRiFH-0007ua-IM
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 12:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660Ab1FAKBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 06:01:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57206 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757574Ab1FAKBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 06:01:35 -0400
Received: by wwa36 with SMTP id 36so5845747wwa.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 03:01:33 -0700 (PDT)
Received: by 10.227.203.145 with SMTP id fi17mr6983217wbb.106.1306922493346;
        Wed, 01 Jun 2011 03:01:33 -0700 (PDT)
Received: from robert-garrigoss-macbook-pro-3.local (r15.santpau.es [193.146.15.253])
        by mx.google.com with ESMTPS id et5sm621839wbb.50.2011.06.01.03.01.31
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 03:01:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; ca; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <m3ei3dyjqe.fsf@localhost.localdomain>
X-TagToolbar-Keys: D20110601120547075
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174860>

Al 01/06/11 11:39, En/na Jakub Narebski ha escrit:
> Robert Garrigos<robert@garrigos.cat>  writes:
>
>> I'm having one of those nasty 128 errors which I cannot debug:
>>
>> ************
>> predircam@eduab:~/public_html/idosing>  git pull
>> Generating pack...
>> Done counting 117 objects.
>> error: unable to find c3117d23df0c01ba8558bad81ad3488f0e8d430a
>> fatal: unable to get type of object c3117d23df0c01ba8558bad81ad3488f=
0e8d430a
>> fatal: early EOF
>> fatal: git-unpack-objects died with error code 128
>> Fetch failure: /home/predircam/gitrepos/idosing.git
>> ***************
>>
>> google suggests me to run git fsck to get a list of corrupted
>> files. Besides that I'm running git 1.2.4 and that the git command f=
or
>> that version is fsck-objects, I'm not having any result at all.
>>
>> Could this be a compatibility problem? As I said, I run git 1.2.4 on
>> the repo server and git 1.7.0.2 on my development server. BTW, on my
>> devel server running the git command fsck gives no result either.
> Do this repository uses submodules?  IIRC pre 1.4.x (or even later)
> git didn't understand modules.
>
> Or it might be problem with deltabaseoffset, i.e. when objects is
> stored in pack as a difference (delta) from other objects, it refers
> to base by offset in pack, and not by sha-1 id.  I don't remember if
> ancient 1.2.4 supports this feature.  This is more likely.
>
> Why don't you upgrade git (perhaps installing it locally in your home
> directory)?
Upgrading doesn't depend on me, unfortunately.

The problem arouse when creating a first branch and merging later into=20
master branch. Does this give a clue?
--=20

Robert Garrig=F3s
Tf. 607 997 973
http://garrigos.cat
