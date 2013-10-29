From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 15:02:48 -0400
Message-ID: <CAPig+cRpEvAjiQWZ08kW2oqwR6XZ=u7dE=3OfVyB9SZzf8+saw@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 20:02:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbEZ4-00061I-GR
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 20:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab3J2TCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 15:02:50 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:39883 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3J2TCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 15:02:49 -0400
Received: by mail-la0-f54.google.com with SMTP id gx14so258798lab.27
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1eU57uvxb939k07sNHizzBWvoobYwXu/mraGksmoFsQ=;
        b=MfeP0iJz6UGQaJp+dGXzfxAXEzvGbxyoCSyUAshnivu7187nfQIsS3ZaLpG0SIJ9fQ
         zCM7Tq/E+T1NPGLIsvqN6BlXEga4QXHcO4VPD0k1On/OdOeGbtlkrQY15Y3sKSLgAzVf
         G4OPeHukIrassw4+MId32XleATNk1F40ZfL/SPQiMIsEogHAAv/A8a6zFI3RSek87364
         YX/ybemeM4ptoCQmd1PN0HFx3z6i3COG2OhVbjpI9MIfut7JRb+w34k08WvehJ27G3E7
         XNvDugzwlzfVtWRZPxBUXDaJv77oZcruX+g6w9v+jjLwTvLHYBsxe3crtaeuNFwrNF8l
         Vrcg==
X-Received: by 10.112.200.100 with SMTP id jr4mr981611lbc.36.1383073368444;
 Tue, 29 Oct 2013 12:02:48 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Tue, 29 Oct 2013 12:02:48 -0700 (PDT)
In-Reply-To: <CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
X-Google-Sender-Auth: wlUbBnuQrwBFyamC4t0RWl7tBRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236940>

On Tue, Oct 29, 2013 at 4:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Oct 29, 2013 at 2:34 AM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>> 2) For some commits I get error messages from "git blame" in function
>> get_blame because multiple -L options are specified:
>>
>> $ git contacts b0783baacd20be7007df40cf274985c4863d63fb
>> fatal: More than one '-L n,m' option given
>> fatal: More than one '-L n,m' option given
>> fatal: More than one '-L n,m' option given
>> fatal: More than one '-L n,m' option given
>>
>> From reading git-blame's man page it indeed seems to me as if only one
>> -L option is allowed, so is this something that needs to be fixed in
>> git-contacts?
>
> You are probably using a newer version of the script on an older version of Git.

Right. git-blame learned to accept multiple -L's in 58dbfa2e59a1, and
git-contacts started taking advantage of that feature in 4c70cfbfbc2d.
A git-contacts prior to 4c70cfbfbc2d might work for you.
