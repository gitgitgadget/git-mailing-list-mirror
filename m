From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Post-update hook problems
Date: Fri, 5 Oct 2007 13:27:17 +0100
Message-ID: <e2b179460710050527w185fd4b1kfbe278cf7055de4c@mail.gmail.com>
References: <930d91430710050427o79395023nffe3bd842a87cddb@mail.gmail.com>
	 <20071005120850.GM31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Geoffrey Ferrari" <geoffrey.ferrari@googlemail.com>,
	git@vger.kernel.org
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:27:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdmH9-0003fA-Rj
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbXJEM1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755766AbXJEM1S
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:27:18 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:52481 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbXJEM1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:27:18 -0400
Received: by an-out-0708.google.com with SMTP id d31so91884and
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=85n+GMcEDzmejYqY0OahVPZSXnzZhD7SiKMStIcUzkI=;
        b=oYCccc5MqBauqQOgnBh9nO4EGvlVuL4NuhzWMP+h4vwwvz9fjBGTF8cY5vq1sZdCOkdA1KwO045obfDsP0ZjeOReqo8BIVCzdwQkexYrXxg6wNoBetoczN33ZEzJLq2FTUr04pZRFNGobseaFLmPfntPtFC56uUaUy0PMcFbOak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bXzNcdcusIh6ZOrQNzHQrvjvvtU7PWweI72MBAiuIpWi1qYMvLKvLivQlKSGG9ZmfXCEXin6vlGRlJI0NkM9zOCyqCu+1XjJO/8sR4VkatQuGiOiizNJ5neXMbXBpGphmQgyi4E3NyJtF4kUW7uC79v6drmTc9pkOfwvBMjZGpU=
Received: by 10.150.195.17 with SMTP id s17mr512907ybf.1191587237194;
        Fri, 05 Oct 2007 05:27:17 -0700 (PDT)
Received: by 10.90.51.10 with HTTP; Fri, 5 Oct 2007 05:27:17 -0700 (PDT)
In-Reply-To: <20071005120850.GM31659@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60076>

On 10/5/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Fri, Oct 05, 2007 at 12:27:22PM +0100, Geoffrey Ferrari wrote:
> > --
> > fatal: Not a git repository: '.'
> > Failed to find a valid git directory.
> > --
> >
> > Can anyone explain why this happens? And how can I make the script
> > work properly?
>
> I'm no hook expert, but it may have something to do with some
> environment variables that are set in hooks, you might need to change
> variables like GIT_DIR.

Ack.

The hooks seem to assume repositories pushed into are bare, so the
GIT_DIR isn't set to a .git subdirectory (even if it exists).

Mike
