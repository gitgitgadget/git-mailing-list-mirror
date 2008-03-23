From: "alturin marlinon" <alturin@gmail.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Sun, 23 Mar 2008 16:41:20 +0100
Message-ID: <bd6139dc0803230841l93cdd0do39bf6c35a5d732fa@mail.gmail.com>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
	 <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
	 <7v3aqik0nz.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>
	 <alpine.LSU.1.00.0803231523110.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 16:42:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdSKq-0007rE-Q6
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 16:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbYCWPlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 11:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbYCWPlc
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 11:41:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:45222 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYCWPlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 11:41:21 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2539446wff.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Py8P+xg0asDG70/171s0ptaV+zVZvWZywgt0nmsJRFU=;
        b=X6cEk3a9B41lEvkT9rAUykdJqYCm3BNlqxmTQrzocax3nPBXerO3DVu8J0fuIFkvAtA9FOVyMOfbCn48pB33jlc7fcXbHWgMnSLBbG1TboUjAMf/HJ2RttQ9+Shy6cDFE/Yiw92Z96gFSZhdZjubh+AS8AElBoGwAEscFAvV+Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yh3iErNLHMkGW5AiNKRUFQ+bRPbBUMz+xPDn3/Cp812DiIGAumz77MRTh9UV+6GGnIoGTYZTErce7B1kZKzTSqpGYIfNPUUbO2VikM6GEtyw15r9/Za+Uir47we2kg5gx292nb0HRKONOtJ4NmI25ucSTfooEOkxJyggpaTsUyI=
Received: by 10.142.44.11 with SMTP id r11mr3796600wfr.22.1206286880976;
        Sun, 23 Mar 2008 08:41:20 -0700 (PDT)
Received: by 10.142.77.6 with HTTP; Sun, 23 Mar 2008 08:41:20 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803231523110.4353@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77918>

On Sun, Mar 23, 2008 at 3:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  I think you will have to go to the line level to achieve what Junio
>  suggested.

I'm not sure what you mean with "go to the line level"?
Do you mean that using a Graph is not possible?

>  Timezones are recorded as epoch (seconds since Jan 1, 1970) and timezone.
>  So yes, you have that, _provided_ you trust the users to set up that thing
>  correctly.

Yeah, I'll trust the user on this ;).
If the timezone is stored as well this should be easy to do, sweet.


>  > >  * Identify "buggy commits" from history, without testing.  Zeroth order
>  >
>  > A feature like this would fit well with the other "buggy
>  > commit/maintainer detection" but would require a lot of customization.
>  > However, considering git already comes with a good customization
>  > system it should still be feasible.
>
>  Yes.  And it would be really interesting for me.  Until it shows that I am
>  the biggest offender, of course.

Maybe we can put in an if-check for user "Johannes Schindelin"? ;)

>  I think the bigger problem is not visualising it, but finding what is
>  buggy, and what not.

Yes, ofcourse, I think I'll be busy mostly following lines across
commits and after that determining if a commit is buggy or not.

>  I think it can be vague about the order in which things will be
>  implemented.  And the features which you think might be too complicated
>  should be marked as such: "possible extension (which might not be finished
>  within this project): <blabla>".

Cool, I think I can start on a RC for my application then! (Maybe I
should'of tracked it with git, then I could tag it...)

Thanks for the feedback, I really want to come up with a superb application!

Sverre
