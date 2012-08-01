From: Ammon Riley <ammon.riley@gmail.com>
Subject: Re: Broken git-svn tests known?
Date: Wed, 1 Aug 2012 10:24:23 -0700
Message-ID: <CAMvPOPsKYkVBic4Dj0z5K08-GzNk01pVY+R+5=E793q0CbD5tA@mail.gmail.com>
References: <CAMvPOPuxdtaQPD6T4M7knPFhQbWGk8psp+DKn4gaHxW48WPFOw@mail.gmail.com>
	<CAH6sp9PyFan=JEL_Hmjxf54j3up2ArPb2qQP5hsWCGLzaWj5BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:24:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swcet-0004is-8v
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 19:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab2HARY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 13:24:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41033 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab2HARYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 13:24:25 -0400
Received: by yhmm54 with SMTP id m54so7563989yhm.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KwjrJ0XMPSjqaIqz6mJ3vaFb7+fsnIU6yogcGezzmes=;
        b=qLy1U61PG2O0+VyVMszbJXwhnqe7OHQv54YgfRbH7U1PUuj4VdTTrgVOjG4VFAP2Bs
         Cqf85paT/GYeDIIPPcaIek6sOT5cDqLYywWHi2jNhHJeZjPGfuj5lQsxUENCOTnHG1VJ
         Yt/xums+EseuJIc78jVOdsN6f0UL3+tXuTGyoEANBDA4Z/qC9GCf6vMMBGPi0xF/NXEh
         ETlbrum87Zp0emO30n+q/RmUfEh9yYr40vi/ayeVvRrCLCCgHlAi+Muf4D7U/7y51uXv
         LyofZ5pyylrgxiPXWf3z0yL4GY2c1me9Z1yKWxqTN8++NoFzw370nFfrnF9ohgqtfwV6
         93eg==
Received: by 10.68.136.68 with SMTP id py4mr8301485pbb.151.1343841863453; Wed,
 01 Aug 2012 10:24:23 -0700 (PDT)
Received: by 10.143.79.1 with HTTP; Wed, 1 Aug 2012 10:24:23 -0700 (PDT)
In-Reply-To: <CAH6sp9PyFan=JEL_Hmjxf54j3up2ArPb2qQP5hsWCGLzaWj5BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202714>

On Tue, Jul 31, 2012 at 11:51 PM, Frans Klaver <fransklaver@gmail.com> wrote:
> On Wed, Aug 1, 2012 at 1:44 AM, Ammon Riley <ammon.riley@gmail.com> wrote:
>> On a freshly checked out copy of the maint branch (0e4c8822), the
>> t9100-git-svn-basic.sh tests are failing 21 of 25 tests. Is this
>> known, or am I missing some dependencies? Is it possibly due to
>> using subversion 1.7?
>
> Yes, and work is done on it as we speak[1].

Ah, thank you for the pointer. As I no longer have SVN 1.6 available,
I'll go with Michael's WIP.

Cheers,
Ammon
