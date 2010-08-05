From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git merge - "both added" conflict resolution
Date: Thu, 5 Aug 2010 10:41:03 -0400
Message-ID: <AANLkTimJmHwzDQL00=Mbo2ENR1beRB=P0WKU4S7fRctQ@mail.gmail.com>
References: <AANLkTi=Hp6DsE75XbgehS2bucp-M9NXmGgYbvw0kp6j8@mail.gmail.com>
	<20100804205916.GC2920@burratino>
	<AANLkTi=dScNMsf4XZ+sS8R+424fESyOr6wYO4WamAutj@mail.gmail.com>
	<20100804233652.GB3595@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 16:45:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh1h7-0003fL-OR
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 16:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359Ab0HEOmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 10:42:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53816 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223Ab0HEOlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 10:41:06 -0400
Received: by qwh6 with SMTP id 6so3999588qwh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=42g4jcG+hAGtjfL/pxARUgYRccBWXJgUuJLbMg0csHQ=;
        b=jQi+vkuqnh1mcFNAOsOEY3a0eEApbgyqwOzB7cBYOFD43NsRzAC9AHCp6AyvwMYmoa
         d2D8L5PoAmmgmojpUhN6go1ob56wJu+SXz9/xgr6HNdVNhH9xSMDZbJpG8o1iudOI1l7
         MGReWTkGFQIrnW6vwveYZlSCwbDye1rOodoaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kzkz/kx2PH4eTXC3GdasNE8jJE7CulYcvF4vS+KA+1iUqdAJSlM6+teyfVu5VYtkzJ
         TvFjVXM3x6FXnL0J9ehWvM8AsV2h63/fF/UDOzQBtZGxZMmMi/l98rvbVjlnAa87c3zb
         02gx2rSPt5Oh5bcAyzaPc0FDHCBNwbnlMdDiY=
Received: by 10.224.75.211 with SMTP id z19mr5091464qaj.185.1281019263214; 
	Thu, 05 Aug 2010 07:41:03 -0700 (PDT)
Received: by 10.229.48.205 with HTTP; Thu, 5 Aug 2010 07:41:03 -0700 (PDT)
In-Reply-To: <20100804233652.GB3595@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152660>

On Wed, Aug 4, 2010 at 7:36 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Eugene Sajine wrote:
>
>> So, I'm removing all conflict markers and removing the incoming line
>> with the property value=3DprojectOne leaving it as projectTwo.
>> This effectively means that there is no changes in build.xml for git=
=2E
>> And I'm stuck because i cannot add file, that is not changed
>
> Sorry I wasn=E2=80=99t clear before. =C2=A0Could you give output from=
 attempting
> to add the file? =C2=A0It is supposed to work.
>


There is no output after I add build.xml with resolved conflicts. When
i do git status build.xml doesn't show up there.

I tried another way:
After i have a conflict i add the build.xml withtout resolving
conflicts. Then I unstage it - it's status changes from "both added: "
to "modified"
Then i can resolve the conflict, which means build.xml returns to it's
last committed state. But then i'm back to square one as build.xml is
not showing in changes, so i cannot add it and i still cannot commit
because of partial commit.

Thanks,
Eugene
