From: "Robin Burchell" <w00t@inspircd.org>
Subject: Re: Numeric Revision Names?
Date: Fri, 3 Oct 2008 13:41:21 +0100
Message-ID: <b19eae4e0810030541r27aa9af7l78a386263154ba8d@mail.gmail.com>
References: <19796862.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: marceloribeiro <marcelo@sonnay.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 14:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KljzN-0006fR-D4
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 14:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbYJCMlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 08:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbYJCMlW
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 08:41:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:34637 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYJCMlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 08:41:21 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1611138wfd.4
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=5juwMo4tYR8t8KBI4e7UgnkTAVeiqpFDyUM5r+patg8=;
        b=CZMe9d/EvOK58etSLaSENrw3aYqzP0f/zSp0j6mYtijzGMCOyCVuaTZebQGXrwsmyh
         04BIHSDJPEVqJsNtgYlnlAw0SQqlMzq37V7ebYdndp0JVdlRUolrb4IzKR81MmvVX0ss
         KwfgS+L1Q+vQqHxAmmLsuDOdGD56ei+saTnV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=kKUih8ej/KwQbpks4h1zckpdmmiNycdy5oS/H+DYd3Kx4oY1bLFeuhLmz+MHONxTVB
         OwcyFz+zb2auWhLfabi5UvRzDpypTbSdr6rNdAQ6NQwLSjZNi4YjYhdFiH7/3njGf/zh
         4EopI3/gJ77P9KXmCGY5Z3uc9EajGTdhNM13A=
Received: by 10.142.142.14 with SMTP id p14mr361160wfd.139.1223037681075;
        Fri, 03 Oct 2008 05:41:21 -0700 (PDT)
Received: by 10.142.237.16 with HTTP; Fri, 3 Oct 2008 05:41:21 -0700 (PDT)
In-Reply-To: <19796862.post@talk.nabble.com>
Content-Disposition: inline
X-Google-Sender-Auth: a48338ccf1c80ab1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97422>

This can be emulated to some extent by using git tag, and git describe
--tags. I can't remember specifics off the top of my head though, it's
a while since I set that up.

On Fri, Oct 3, 2008 at 1:37 PM, marceloribeiro <marcelo@sonnay.com> wrote:
>
> Hi,
>
> I am new to git, and my question may be stupid, but anyway...
> I am used to the numeric revision names on svn, and on Git
> all I get are hexadecimal names.
>
> Is there any way to configure it to start a projects revisions on
> lets say, revision 0, and keep incrementing it after each commit?
>
> I tried finding it on git doc but wasnt able to. Maybe I am missing
> something....
>
> Thanks in advance!
> --
> View this message in context: http://www.nabble.com/Numeric-Revision-Names--tp19796862p19796862.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
