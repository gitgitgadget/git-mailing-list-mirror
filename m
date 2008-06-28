From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 09:30:47 -0700
Message-ID: <9af502e50806280930u788f81e2j77adf147a0e4d135@mail.gmail.com>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
	 <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	 <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
	 <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
	 <9b3e2dc20806280734i6ca17cc8i447c2e2db67e8051@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 18:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCdL0-0007BP-Gr
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 18:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYF1Qat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 12:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYF1Qat
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 12:30:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:22012 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbYF1Qat (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 12:30:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so461821fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=B6QxUqTFv5hfby4nAJPoqugUSbvH4jzUbP2IOjUWkF8=;
        b=veTx23nynmSO14e/RvHIxoAD46VLELzPwyCq2b9nkVWp1eBxXnzIVG8eUUVYol4iMw
         AI2kELId5y9CtX2sMfReJPL8shrSq3imM1J7g161ELwYGb+V7IsZY/NULa5hcz2ItR7v
         VHUibHJfFqe58BgCC7L7KPdm5esYmXVPIDmJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cNohviwlr+i5A+Ut1O9JR9xyCG1HY0pPkpz+KSoQloFKq4jTMEZ82ws5R0EnIxNEwN
         vzHtZ4VOanSFTH9URgYrLfcXU1Y7lj4LQZwI+vVz9MgFuXTh+0IQcFrPHoh+IoxDB61Z
         RHJVa9FP4Re9tcw8o4DtDQZZUxlJH9775RZKw=
Received: by 10.86.9.8 with SMTP id 8mr3680627fgi.41.1214670647621;
        Sat, 28 Jun 2008 09:30:47 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Sat, 28 Jun 2008 09:30:47 -0700 (PDT)
In-Reply-To: <9b3e2dc20806280734i6ca17cc8i447c2e2db67e8051@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86726>

On Sat, Jun 28, 2008 at 7:34 AM, Stephen Sinclair <radarsat1@gmail.com> wrote:
> The answer is simple: you should not be making partial commits to a
> repo that has been cloned.  You should instead be working somewhere
> else and then pushing to it.  So this whole sentence is just a moot
> point itself.

Let me amplify my objection to this.

Who has 100% foresight that what they are doing is going to end up in
a state where they'd like to make partial commits?  To take a quote
from a blog post, 'Git means never having to say, "you should have"'.
And mostly it doesn't, and that's big improvement over other systems.
But, that is what you are saying here.  I "should have" realized that
I should have pulled and fiddled with my changes there, and then
pushed.

Well, Dmitri and others will now say, why not just always pull and
work somewhere else?  And the reason is that because this creates
extra, unnecessary steps the vast majority of the time when I do
create a commit that I like and want to keep as-is in the first try.
Why should I have to pull, commit, hack, and push, when hack and
commit is all I need to do the vast majority of the time?  It is
redundant, unnecessary work and complexity that I should not have to
pay for when I don't need it.

Thanks,
Bob
