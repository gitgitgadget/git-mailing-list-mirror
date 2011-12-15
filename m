From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered by path
Date: Thu, 15 Dec 2011 11:42:38 -0800
Message-ID: <CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
	<CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
	<alpine.DEB.1.00.1112151023280.2615@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, Git <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 20:42:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbHCd-0001yS-FP
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 20:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab1LOTml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 14:42:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55726 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678Ab1LOTmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 14:42:39 -0500
Received: by iaeh11 with SMTP id h11so3191011iae.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v12soexP2r926+Z8H9Qx8ORRRYCI6N/47KQyL6RJMig=;
        b=MTyvsl9KWlTvp48Vqedc7Jy7srZ+hHMn65mw0s0f5b2bD6MRBiNDlOxf/4Apq1tOHK
         8F+BXTlS7By+UZkB5LzIg+FDv+nG08FXFAaVH7MB70UQ33ZOuk/sTBO6X+I6/cEikxsn
         JCBid9PmNsi0FeX2PAjuuZ4B1WR7+x+MqJm2Y=
Received: by 10.50.220.231 with SMTP id pz7mr3938055igc.94.1323978158878; Thu,
 15 Dec 2011 11:42:38 -0800 (PST)
Received: by 10.231.23.213 with HTTP; Thu, 15 Dec 2011 11:42:38 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1112151023280.2615@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187225>

Hi,

On Thu, Dec 15, 2011 at 1:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 14 Dec 2011, David Aguilar wrote:
>
>> On Tue, Dec 13, 2011 at 8:50 AM, Pat Thoyts
>> <patthoyts@users.sourceforge.net> wrote:
>> > Launching 'gitk -- .' or 'gitk -- ..\t' restricts the display to files
>> > under the given directory but the file list is left empty. This is because
>> > the path_filter function fails to match the filenames which are relative
>> > to the working tree to the filter which is filessytem relative.
>> > This solves the problem by making both names fully qualified filesystem
>> > paths before performing the comparison.

How is this related to my patches from April? See
http://thread.gmane.org/gmane.comp.version-control.git/170853. It's
clearly not the same problem, but will the patches conflict? Will some
of mine be unnecessary?

> Thanks for reminding me that I did not yet apply and push. Did so now.

What do you mean by this? Push to where?
git://git.kernel.org/pub/scm/gitk/gitk.git is still down.

Paul and Junio, the patches I sent in April are still not in git.git,
are they? Can we use another repo until the kernel.org one is up? More
than eight months to get a patch (or eight) merged is way too long,
IMO.

Martin
