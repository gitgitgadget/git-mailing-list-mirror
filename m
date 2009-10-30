From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool 
	option
Date: Thu, 29 Oct 2009 23:00:52 -0400
Message-ID: <76718490910292000t7b024b83y68d71b6ff810c15@mail.gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
	 <20091029221234.GB32590@hashpling.org>
	 <76718490910291747l165baf49tab781727d010610a@mail.gmail.com>
	 <200910300202.02016.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Bailey <charles@hashpling.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Oct 30 04:01:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3hjp-0007td-4H
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 04:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbZJ3DAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 23:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756710AbZJ3DAt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 23:00:49 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:39357 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbZJ3DAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 23:00:49 -0400
Received: by iwn10 with SMTP id 10so1862763iwn.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AkbjXe0lhBycAUJTl/wQPLjDqr+EVs2cloMCb9Z4z6g=;
        b=fdXJ35hpDr9nBma4g+upDDk66P9WpLmjEt+771Tw7mGfpEx8XOr8lvB4EULww1VSYw
         mf+Si0kZb3sQjwgKiE79bXWCDYaSzWfQ+/P3ursXChoan/xwmJbXfugVjKFH73H67OwM
         Yx72FxI3shNLnH0b7JkPw/r6fjlRH0ZKe1OYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HCiGw5gYNqV27xDXdc3XXDFfP7AML/5i6Lb87HqmertJ3VNQnXSdeSkeENNCGZd+zM
         Z5P7J4LW02/lVYiR8VqIonGrBdprC1e7qp9I113iNJBfEu0ony3qQ15qug668PyAXfSo
         DmCSEGsQxb5+LgzLPWtHAA8fwFwc41QEX0fAM=
Received: by 10.231.81.148 with SMTP id x20mr2737854ibk.2.1256871652353; Thu, 
	29 Oct 2009 20:00:52 -0700 (PDT)
In-Reply-To: <200910300202.02016.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131671>

On Thu, Oct 29, 2009 at 9:02 PM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> He didn't mean p4merge on other platforms, but other merge tools on Mac
> OS X. What about all the other merge tools already in mergetool--lib?
> Should they get special handling, too?

If someone wants to scratch that itch, then yes. The default diff tool
for OS X has its helper already in /usr/bin (opendiff). p4merge is
arguably a better merge tool, and it installs as an app bundle in
/Applications. I'm not sure about the other diff tools, I haven't
looked.

> And for Windows we could add C:\Program Files\MergeToolX\tool.exe for
> every merge tool.

If it makes those tools easier to use with git, and if someone on
Windows wants to scratch that itch, then yes, we should.

> But where will we end?

I don't understand this argument. It's a few lines of code to make git
a little friendlier. We end when folks stop contributing patches
because either no one cares of there's nothing left to improve.

j.
