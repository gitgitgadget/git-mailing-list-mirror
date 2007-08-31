From: "Stephen Cuppett" <cuppett@gmail.com>
Subject: Re: [RFC] Change handling of RelNotes
Date: Fri, 31 Aug 2007 08:52:38 -0400
Message-ID: <316a20a40708310552r3d445d03h2ab44508a0608f0c@mail.gmail.com>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
	 <200708310645.l7V6jKJk009287@mi0.bluebottle.com>
	 <7vveaw2na9.fsf@gitster.siamese.dyndns.org>
	 <316a20a40708310539w1d20c391w8566a042c7a8679a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 14:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR5zT-0001Qm-ED
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 14:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbXHaMwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 08:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbXHaMwm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 08:52:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:60679 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964955AbXHaMwl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 08:52:41 -0400
Received: by ug-out-1314.google.com with SMTP id z38so46814ugc
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 05:52:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VVfBvrifmMH6AYks1MxeUAAdX+ujz8JL/V+DNOPc4GlMr2m4Pe9gkP6lONbt2ctml/oHP6kBxpGPJX76wXGmoMumz8RajGFVjn+EzY825RcwE4hAkRD1PQX+2xL5x2DR1OsFpbVfsS6NOVqAaBxnhDxp31JpYNBFoukx0Sh/NWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X+vGKrJJGQ7nV8Ix076IiY4nUAzgPtiiiL+8i5k3JyvWOIBPx6vM+MbyxqIbkYn3hS0HLTKW6mImtOkSZRcaewHLKiG8CoYvGzrOQ4eQhmqKmZBiqj6un/UvMtTdzp7XF01Sd9BDFJ90lBH+iN3KhJclX9/AJ5S/JTotNJKkWtY=
Received: by 10.142.222.21 with SMTP id u21mr74013wfg.1188564758928;
        Fri, 31 Aug 2007 05:52:38 -0700 (PDT)
Received: by 10.142.111.8 with HTTP; Fri, 31 Aug 2007 05:52:38 -0700 (PDT)
In-Reply-To: <316a20a40708310539w1d20c391w8566a042c7a8679a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57166>

Sorry, I didn't mean to imply a demand on anybody, or mandate anybody
change their workflow if really awkward or inconvenient.  Just new to
git and was trying some things and noticed this oddity.  In software
test, so I typically file reports for usability nits as well as big
things, and never expect to fix them myself.  Used to my
"recommendations" getting rejected too.  ;)

Just trying to lower a barrier to entry in a weird case....

I tested out the patch on Linux with a regular filesystem and with a
memory stick.  It picked it up and did the right thing with RelNotes
in both cases, leaving the symlink alone on ext3 and changing it to a
regular file on the memory stick.

I tried compiling it on Windows (cygwin), but ended up with:

/home/stcupp/git/builtin-init-db.c:305: undefined reference to `_xmkstemp'

I tried including git-compat-util.h and some other things to resolve
it, but was unable with my limited knowledge of their toolchain.
