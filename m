From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: Git Gui does not want to work on chunk level
Date: Thu, 4 Sep 2008 13:20:21 +0400
Message-ID: <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com>
	 <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
	 <20080903230814.GJ28315@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git-users@googlegroups.com, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:21:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbB1s-00050k-Cy
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYIDJUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbYIDJUW
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:20:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:14894 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbYIDJUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:20:21 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2239553waf.23
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xqArAtV4KZ5IRSck7TaDefXk19WRWgsCCn+6sAtedV0=;
        b=bDRTZErjgYXEl70Lza9GG0qk6Rj3lkiiAw6dRPNRluA+zKBmIh1G5GXkAPG8vTrok5
         HBVUKLFpmNEr6xdK1pdBhL+SgO8N/4j+wzlKt3vX0UUSo7JUhjnAce5cYgeITyhWTg+1
         wnnRPTJvm4PEfYyWEZ9iiHmAYVQWweoGpPgGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SPLj8i7DSdyko9/NN2KXU6w8H2zLf0uItoDofQvzNcm4hh4dr4cTUWa5o4kbYrqEZf
         O1jfY1xpLKGwvM8sneeRKN67fTSCzBCIkbkYnaslimkp54j2Vow3vJScYvDmUu9R7qjh
         ofqa8Jep6ImJNnVZdMJJz4hXhc0hzgyCpR2cs=
Received: by 10.114.200.2 with SMTP id x2mr8548254waf.79.1220520021066;
        Thu, 04 Sep 2008 02:20:21 -0700 (PDT)
Received: by 10.115.95.8 with HTTP; Thu, 4 Sep 2008 02:20:21 -0700 (PDT)
In-Reply-To: <20080903230814.GJ28315@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94913>

On Thu, Sep 4, 2008 at 3:08 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Alexander Gladysh <agladysh@gmail.com> wrote:
>> On Wed, Aug 27, 2008 at 1:16 PM, Alexander Gladysh <agladysh@gmail.com> wrote:
>> > I like 'stage hunk for commit' feature in Git Gui, but often it gives
>> > me an error message box:
>> >
>> > fatal: git-apply: bad git-diff - inconsistent old filename on line 4
> ...
> I've never seen that before, but its clearly dumping a bad diff
> into git-apply.
>
> Open up lib/diff.tcl and find "proc apply_hunk".  Inside of the
> catch maybe insert a puts to see the diff, e.g.:
> <...>
> Then if you can scrub the context and +/- lines for a bad diff and
> send us at least the headers, or tell us how they are malformed,
> it would help to debug it.

Thank you!

Header looks well-formed to me:

diff --git a/path/file.ext b/path/file.ext
--- a/path/file.ext
+++ b/path/file.ext

I have sent you full output privately. I do not see anything unusual
in it... Anyplace where I may put more logging?

Thanks again,
Alexander.
