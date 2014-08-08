From: Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH 3/7] Documentation: git-init: template directory: reword
Date: Fri, 8 Aug 2014 09:36:54 -0700
Message-ID: <20140808163652.GA791@k0>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407002817-29221-4-git-send-email-linusarver@gmail.com>
 <xmqqmwbioaeh.fsf@gitster.dls.corp.google.com>
 <20140806051517.GB12559@k0>
 <xmqqwqalmt42.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:37:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnA7-0005Qg-6n
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbaHHQg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:36:59 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:55325 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbaHHQg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:36:58 -0400
Received: by mail-yh0-f47.google.com with SMTP id f10so4302010yha.20
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dgF6mibox28Jitz7o1ONKKDYuUPdOPG0TBcZoAvXE+g=;
        b=kdjlM9FnKzqRxWIej5yT+SJq29QFtUl6DvE5gKfD9VNO98EcvVJfZBUXoEUekyk672
         Ms58uPmXAIDK3A65/frY6Uw4FZwMeg8VybVM6+u9v2SaeLgbDaz8xpFqet6iTVCiU017
         iMVinNKUveXK5Qc4r27Sa2GMyKSfAF87AFj+bJlck5fu2nRoy0Wfh1jMC5VpgLkVfFaX
         +d0IRTYJerkmVTBGfE8+M/Pd1BfIeUrG6I5zvPgDMj+lrhrN3RrGr+PAlTmCmWmhy3nV
         bl3Ec2WKSTA9JoY9+NLTaZEmFlVjWKe+zxZFgY+Mjzpf+yU/0h2uSTaIsbE0uYgLh0WD
         tM4Q==
X-Received: by 10.236.10.66 with SMTP id 42mr15998251yhu.68.1407515818126;
        Fri, 08 Aug 2014 09:36:58 -0700 (PDT)
Received: from k0 (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id q44sm6549371yhg.15.2014.08.08.09.36.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 09:36:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqwqalmt42.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255023>

On Wed, Aug 06, 2014 at 10:21:33AM -0700, Junio C Hamano wrote:
> Linus Arver <linusarver@gmail.com> writes:
> 
> > No, the unindenting/removal of blank lines is a non-grammar change and
> > is not necessary, as it doesn't have any effect on the actual output
> > (html/txt/manpage).
> >
> > I can either keep the same coding style with the rewording, or chop this
> > into two commits, one for the rewording and another for reformatting.
> > Which one do you suggest?
> 
> If I were doing this change, I wouldn't touch the formatting,
> because I did not find that the reformatted version would be any
> easier to read or maintain compared to the original.
> 
> But I suspect that you must have thought the reformatting was a good
> thing to do for a reason, and I suspected I might have been missing
> something obvious to you, and that was why I asked.  If there is a
> good reason to reformat, then lets hear it in the commit log message
> of one of the two patches.  Otherwise we can drop the reformatting
> part.

And well, considering that the rewording makes the separate items into a
single sentence, I thought it would help readability to delete all the
whitespace.

In retrospect, I don't think this is a good enough reason to reformat.
It was more of a personal writing style judgment call. I am dropping the
reformatting part.
