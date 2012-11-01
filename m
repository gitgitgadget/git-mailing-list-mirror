From: James Nylen <jnylen@gmail.com>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Thu, 1 Nov 2012 17:10:08 -0400
Message-ID: <CABVa4Nh_-XD2m4HkPjWBaY8ReJVMbzfn-MC6i-vY-o35xCZUHA@mail.gmail.com>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
	<CA+39Oz7iuSPh2DqQFoO9o+V3TouMUy8T00KgXEP0vY758=S5gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:10:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU21v-0003PJ-Vp
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 22:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762200Ab2KAVKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 17:10:11 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56073 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab2KAVKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 17:10:09 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4174621iea.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uPGolhXY5/FctbPXTzw/H2OdnFZag1SA0VCMfqO6KCY=;
        b=nVeiDdqG47FO+vW7U+LJc174NCHTbpU3pLFad+KXs6ud8Yge2pCi73zpwZK1kjRYod
         OXcu4COV2E1WJPxqR9KU0yKbzcad+RyeGqIvyYQGCDbaeqoJ/4eRZ9sC5YaUlG1+XDFT
         DSiQofTaUXF9wRskkyimc2cBsN6/TCswWlfBC40EO3Cy0eMbZ+Rp3IPqKcJrbyoiVEjw
         owQ4mBnIrViHasWgaa2O3IgC7CZVA5GSXTcXiZKfFKyW5ubUXdm+K2P5yUJYMuJ6FTBY
         CKS5ms0qgfDPg1PEl6UUQ9SdImevihdaKt8XGxr1c/5bcLklq0IBvCyd957J89DP9WsJ
         KyMQ==
Received: by 10.50.188.136 with SMTP id ga8mr2632140igc.24.1351804208630; Thu,
 01 Nov 2012 14:10:08 -0700 (PDT)
Received: by 10.42.173.130 with HTTP; Thu, 1 Nov 2012 14:10:08 -0700 (PDT)
In-Reply-To: <CA+39Oz7iuSPh2DqQFoO9o+V3TouMUy8T00KgXEP0vY758=S5gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208888>

On Thu, Nov 1, 2012 at 2:12 PM, Thomas Adam <thomas@xteddy.org> wrote:
> Hi,
>
> On 1 November 2012 16:07, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>>
>> Hi,
>>
>> Some of my colleagues are lazy to fire up an editor and write proper
>> commit messages- they often write one-liners using `git commit -m`.
>> However, that line turns out to be longer than 72 characters, and the
>> resulting `git log` output is ugly.  So, I was wondering if it would
>> be a good idea to wrap these one-liners to 72 characters
>> automatically.
>
> Can't you do this already?  From "git-log(1)":
>

I think he's talking about git-commit wrapping the message as it is
being committed, instead of git-log doing the wrapping as it is being
displayed.

I personally would rather see git-commit refuse to accept messages
wider than 72 characters.
