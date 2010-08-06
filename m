From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git merge - "both added" conflict resolution
Date: Fri, 6 Aug 2010 10:57:07 -0400
Message-ID: <AANLkTik0NmRg1Du+QM_SexZvijRUD5X6zyuCgwq0+GUR@mail.gmail.com>
References: <AANLkTi=Hp6DsE75XbgehS2bucp-M9NXmGgYbvw0kp6j8@mail.gmail.com>
	<20100804205916.GC2920@burratino>
	<AANLkTi=dScNMsf4XZ+sS8R+424fESyOr6wYO4WamAutj@mail.gmail.com>
	<20100804233652.GB3595@burratino>
	<AANLkTimJmHwzDQL00=Mbo2ENR1beRB=P0WKU4S7fRctQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 16:57:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhOMM-00019O-MH
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 16:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab0HFO5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 10:57:17 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39331 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759071Ab0HFO5Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 10:57:16 -0400
Received: by qwh6 with SMTP id 6so5032518qwh.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vEIDGTof9aLEJXzZb2nCWsSBzDl0WYsKsydVSu4CGAA=;
        b=rFU051LnLU4XHONcAVxTx+mAjb9H94UHgSI8p1/CnIvHiRRQwAdmaLJiRfvE2gGdEs
         cxtjoAyBXsYdRbqo6MfB5gAb0bA8DdpjeFRgD0jusqMU3inU59wvW3S5wpEPvJECv7NV
         bTCqThO1qDUAxSRFqtUT473RBQp1oZPhZ81e4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mAH248YnCYfVhz4zN/uJF0OupGplXfFmdqgfW7GXwYT/cROum04MyZW0LwBA+iv/oc
         yeagnNNIgVLKF7m0pp06lbrnqnawcz3L5BPboEFBWF3e7kwUc6WzQz3S7fHyr+COddoL
         a46WTNAZXT3YqDDsSiK3kRBeKKMe89fu3rtJs=
Received: by 10.224.29.4 with SMTP id o4mr6238085qac.203.1281106627529; Fri, 
	06 Aug 2010 07:57:07 -0700 (PDT)
Received: by 10.229.55.7 with HTTP; Fri, 6 Aug 2010 07:57:07 -0700 (PDT)
In-Reply-To: <AANLkTimJmHwzDQL00=Mbo2ENR1beRB=P0WKU4S7fRctQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152786>

On Thu, Aug 5, 2010 at 10:41 AM, Eugene Sajine <euguess@gmail.com> wrot=
e:
> On Wed, Aug 4, 2010 at 7:36 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>> Eugene Sajine wrote:
>>
>>> So, I'm removing all conflict markers and removing the incoming lin=
e
>>> with the property value=3DprojectOne leaving it as projectTwo.
>>> This effectively means that there is no changes in build.xml for gi=
t.
>>> And I'm stuck because i cannot add file, that is not changed
>>
>> Sorry I wasn=E2=80=99t clear before. =C2=A0Could you give output fro=
m attempting
>> to add the file? =C2=A0It is supposed to work.
>>
>
>
> There is no output after I add build.xml with resolved conflicts. Whe=
n
> i do git status build.xml doesn't show up there.
>
> I tried another way:
> After i have a conflict i add the build.xml withtout resolving
> conflicts. Then I unstage it - it's status changes from "both added: =
"
> to "modified"
> Then i can resolve the conflict, which means build.xml returns to it'=
s
> last committed state. But then i'm back to square one as build.xml is
> not showing in changes, so i cannot add it and i still cannot commit
> because of partial commit.
>
> Thanks,
> Eugene
>

When i experimenting with it with test repos - it is working OK.
So, i believe it will be very difficult to reproduce.

I'm still having this problem with two repos of mine, but as it is not
common, i gotta dig deeper there.

Thanks,
Eugene
