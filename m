From: "R. Klomp" <r.klomp@students.uu.nl>
Subject: Re:
Date: Mon, 8 Sep 2014 16:36:49 +0200
Message-ID: <CAE8x=qVrK5-nhzL57ADwzQmD+NE-ScnJyPgum6cK6hPox5+VMg@mail.gmail.com>
References: <CAE8x=qW7EwO9YyrQ49vYH50BFcF7RF43eVqDeVex7FKut0oaaw@mail.gmail.com>
	<CAOqJoqGSRUw_UT4LhqpYX-WX6AEd2ReAWjgNS76Cra-SMKw3NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: p.duijst@stylecncmachines.com, git@vger.kernel.org
To: Jim Naslund <jnaslund@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR03v-0008Ej-1j
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 16:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbaIHOgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 10:36:53 -0400
Received: from mail-lb0-f193.google.com ([209.85.217.193]:49067 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaIHOgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 10:36:52 -0400
Received: by mail-lb0-f193.google.com with SMTP id z11so1391393lbi.4
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 07:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GenqoslfQNd4aKXAO+E8qFqNObclO87GoAbRYQc0Ys4=;
        b=L3KrTjbcdtdmN/odYmwc6OCMK7GomeaEwtmJravEKnOIlYpFu76olRleU3YZWDKmQy
         DMMDwJIOEiDpKCpTuxFs38/zrFPp5rwKCgDd117CF1394vzi4zx9M/VolILKJ8iYuxhX
         l4/XCOnuPgTW1en1QgF5c/oqbLuFPSczzkSYg/d66ktyPA1tA5nGtm9GJBRZ4piVCJVs
         jbTslFoRV0eurOJKw6w0YHsN88XuBlVo1ZuWemgkngd8jqsCco9Pi8f3o5MF11yR/ULG
         wnBPWbmWzyDXBmS7wYrpaX9cpyFpWhf54d6CG4Kc4ChH6MEcrLEVcCE6b1K1EjN3TYlf
         Mh4w==
X-Gm-Message-State: ALoCoQnjuPPY6YHoN5SwdcaDM7nKc+m1dYjMZoeOGszUvEZilZWMprPNPgthU4AOEJBIAPTxu0on
X-Received: by 10.112.135.230 with SMTP id pv6mr3018685lbb.105.1410187009698;
 Mon, 08 Sep 2014 07:36:49 -0700 (PDT)
Received: by 10.112.167.3 with HTTP; Mon, 8 Sep 2014 07:36:49 -0700 (PDT)
In-Reply-To: <CAOqJoqGSRUw_UT4LhqpYX-WX6AEd2ReAWjgNS76Cra-SMKw3NQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256650>

Ok great! That indeed fixed the issue.
Although I still don't understand why it didn't work without -solo..
since it didn't work when no instance of Beyond Compare was running as
well.

There must be something not quite right in either Git or Beyond Compare.

On Mon, Sep 8, 2014 at 3:37 PM, Jim Naslund <jnaslund@gmail.com> wrote:
>
> On Sep 8, 2014 7:39 AM, "R. Klomp" <r.klomp@students.uu.nl> wrote:
>>
>> It seems like there's a bug involving git difftool's -d flag and Beyond
>> Compare.
>>
>> When using the difftool Beyond Compare, git difftool <..> <..> -d
>> immidiatly shuts down once the diff tree has been created. Beyond
>> Compare successfully shows the files that differ.
>> However, since git difftool doesn't wait for Beyond Compare to shut
>> down, all temporary files are gone. Due to this it's impossible to
>> view changes made inside files using the -d flag.
>>
>> I haven't tested if this issue also happens with other difftools.
>>
>> I'm using the latest versions of both Beyond Compare 3 (3.3.12, Pro
>> Edition for Windows) and Git (1.9.4 for Windows).
>>
>>
>> Thanks in advance for your help!
>
> I see the same behavior. For me it had something to do with the diff opening
> in a new tab in an existing window. Adding -solo to difftool.cmd will make
> beyond compare use a new window which fixes the issue for me.
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message tomajordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
