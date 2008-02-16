From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: Wishlist: Please add --author to git-tag
Date: Sat, 16 Feb 2008 14:49:58 -0500
Message-ID: <420D37FF-C808-47CA-A3C8-38E1F8578FAC@gmail.com>
References: <47A20503.2000603@debian.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 20:51:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQT3s-0001V6-OK
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354AbYBPTuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbYBPTuG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:50:06 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:38692 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863AbYBPTuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:50:04 -0500
Received: by an-out-0708.google.com with SMTP id d31so250143and.103
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 11:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=5RkBiHmTe2OexX/ECqKBOk5vSp5YwBYjIV8hHEdP7g4=;
        b=ed7y7jmyyfLOg5NABBQ0TlIMnxo8UP2dYpwj2XiiIxQRjCzZIfkFI+ZYpqBZtEvy8FD7aYiOR0uk6KibAwtyRb1w0YyaEHp41BVfIC8jxEsxFtrNOMfpww6JJB3PeXbNtpo+Xv030MudYToY9heQwa6I+XASIZRs43WwTvTU4/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=e3Er+3VFIkmVL+Wjyt33iRYuJz3bAabfLogjvXF+jYsLxsVAANxwCGFqbqFTMDtAgW0YFRss/fcGxGIi+uhuvAtv+ygptRxvjI0QQI9ZhumdHVzKbkZgQicvGilR9nxnrsuBvONYuUFGDsJLtHWrmsNR3aTJiOz24fI5p18CLcw=
Received: by 10.100.254.18 with SMTP id b18mr6968950ani.98.1203191402588;
        Sat, 16 Feb 2008 11:50:02 -0800 (PST)
Received: from ?192.168.1.103? ( [71.126.230.85])
        by mx.google.com with ESMTPS id b45sm9180812hsa.7.2008.02.16.11.50.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 11:50:00 -0800 (PST)
In-Reply-To: <47A20503.2000603@debian.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74070>


On Jan 31, 2008, at 12:27 PM, Daniel Baumann wrote:

> git commit supports --author to overwrite the author information on a
> particular commit; it would be nice if git tag would offer the same.

What are the implications of this on the GPG signature aspect of git- 
tag (desired or otherwise)?

If you were committing someone else's tag wouldn't you want to sign  
not only the commit, but their signature on the commit?

Ignoring the GPG issue, I'm just not seeing the benefit to having an  
author AND a committer on a tag. I mean... it's a *tag*. The only  
value I see in having any name associated with a tag is knowing who to  
point the finger at when the wrong thing gets tagged. But, I don't see  
any authorship aspect to the concept of a tag. To me it's more: "Bob"  
set it and it points to this. The end.

What you're proposing sounds more like: "Bob" said to set it and then  
"Mary" did, because Bob said to.

P.S.  When the right thing is tagged there's generally no need to know  
who did it. I don't care if Linus tags the latest kernel release or  
one of his lieutenants. All I care is that everyone's in agreement  
that whatever that tag points to is the next release. Who tags  
something doesn't change the value of what was tagged.

-masukomi
