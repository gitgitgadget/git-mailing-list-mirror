From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 12:30:47 -0400
Message-ID: <9e4733910708230930k3f6d1b4i47d03753bc0d3c1@mail.gmail.com>
References: <86absjenc3.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	 <Pine.LNX.4.64.0708221713540.20400@racer.site>
	 <86mywjcwv7.fsf@lola.quinscape.zz>
	 <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
	 <Pine.LNX.4.64.0708231006220.20400@racer.site>
	 <20070823102036.GG7267@thunk.org>
	 <e1dab3980708230355x1d5d2febw6814e8f24d745ddd@mail.gmail.com>
	 <Pine.LNX.4.64.0708231122450.20400@racer.site>
	 <20070823112413.GJ7267@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"David Tweed" <david.tweed@gmail.com>,
	"Reece Dunn" <msclrhd@googlemail.com>, git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 18:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOFa9-0005pO-Gz
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 18:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762931AbXHWQat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 12:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762780AbXHWQas
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 12:30:48 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:19954 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbXHWQas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 12:30:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so429577rvb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 09:30:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UIz4jULCN09V4fBOCk2ijhNOOGh88s9HvpJfr3Xm8Mm2aO9oed16RXbnZoqa7uiV5/F1GRFvq2I50EqJn6cJ5IFl9Wic2uew43lMP3gqSGY6KpVm71LVQ94ZTL4Vs76JSj6S/70+/+Dt0bv3r8xrzeB5F4c1CdA9rCIqFYBzCT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q3gXkjutG57qiAyoSETkza3A8qJ93EUfreZuwMjasUtXklwoj6DgZtKCts2gf15gGLlPbolIddxFcf9d73kSQ7Td4LYkZxvU1yhc5gUS3BXMqZQDg25ym8g/gyqwZxWUjj0feGz8TEbSCotqSSA+06rEjT5+dae1rUtzY9xAAUg=
Received: by 10.141.202.12 with SMTP id e12mr908670rvq.1187886647513;
        Thu, 23 Aug 2007 09:30:47 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Thu, 23 Aug 2007 09:30:47 -0700 (PDT)
In-Reply-To: <20070823112413.GJ7267@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56506>

On 8/23/07, Theodore Tso <tytso@mit.edu> wrote:
> I don't know enough about LUA to say for sure.  Having taken a quick
> look at lua.org, the implementation looks pleasantly small, and LUA
> scripts look more comprehensible than say Tcl (which is not saying
> much, I know).  But part of "show me the code" is people demonstrating
> that no really, LUA is an appropriate tool for simple scripts that is
> portable enough that we don't need to have external dependencies on
> bash and perl, and that it is easier than rewriting all of our shell
> scripts in C.  Maybe that is a true statement.  I don't know.  My
> suggestion to "Show us the code" was a way of hoping someone who cared
> enough about this issue could show us.

I just threw LUA out as an example of a tiny language in the hope of
avoiding something giant like mono. LUA is already installed on most
Linux distributions, liblua50.so on mine. It is 100KB.

LUA is used as a scripting language in some popular games. Because of
that it has good ports to Mac/Windows. There are over a dozen books on
Amazon about using LUA.

I only care about the scripting issue in that I don't want git to get
tied to a giant scripting system. LUA is small enough to package with
git.

-- 
Jon Smirl
jonsmirl@gmail.com
