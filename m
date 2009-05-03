From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: specialize diff options for emerge and
	ecmerge
Date: Sun, 3 May 2009 13:34:27 -0700
Message-ID: <20090503203427.GA22440@gmail.com>
References: <1241254641-54338-1-git-send-email-davvid@gmail.com> <200905030827.56932.markus.heidelberg@web.de> <20090503182137.GC50640@gmail.com> <200905032112.31156.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, marcin.zalewski@gmail.com,
	charles@hashpling.org, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun May 03 22:34:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0iOe-0007Q2-PP
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 22:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862AbZECUel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbZECUel
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 16:34:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:24951 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbZECUek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 16:34:40 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1879379wah.21
        for <git@vger.kernel.org>; Sun, 03 May 2009 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ATEwPfXJS4ayV8ZUpbPQSBVGPejQM7XNX3i7TxZoitM=;
        b=uPt6nfNQeGrDuVv1NP+X6Mv2ia3JuIMBAlM0Az+8mgdfhmE03tXIOA5FWoFZzUH+be
         LpXhv5PYx+2yDSI9I4duRpcQ3NiMGIsFFumcsmnkJdpxIoSpyzlAGHSIihKc9LMqXjih
         +6hyjbEd/wBMEqRqe8TKSEoCFs372a4TpASLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bnRUTfGmIof9as/QWL2NQFGwvlGzSm3LG4ftTfW1wwg8TxtfHjVJ+ghSwXy/5gjHYo
         T6j0mWgmv4n27HuafvjoM5HQo0rT9iDx8sfguRjP2X1KqXf8bxQ6FlajwtZzEjnTy4e2
         6sqn92RTsaAzHpfJV/aYlveUic9okjA+iCB1c=
Received: by 10.114.67.17 with SMTP id p17mr3764292waa.49.1241382880415;
        Sun, 03 May 2009 13:34:40 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k14sm1432035waf.65.2009.05.03.13.34.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 13:34:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905032112.31156.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118191>

Markus Heidelberg <markus.heidelberg@web.de> wrote:
> > 
> > On Linux, ecmerge is "ecmerge".
> > Macs are weird.  Windows--even worse.
> 
> And the ecmerge developers are even more worse or is there a reason to
> have different names for the binaries?

But of course :)


> > The user-friendly thing is actually
> > "/Applications/...lots.of.stuff.../guimerge", and that's a lot more
> > platform-specific than just "guimerge".
> 
> Why is the whole path more user friendly, because of guimerge not being
> in PATH? Is the /Applications/... directory always the same for ecmerge

Yup.


> for each Mac user? But we don't care in other diff/merge tools about the
> exact location and I think we shouldn't begin it here.

Ditto.


> > What do you think?
> 
> Not sure, leaving it as is is still an option.

I agree.  So the original patch for ecmerge + emerge should be
good then. I still need to reroll the araxis patch after my bike
ride later.

-- 

	David
