From: David <wizzardx@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 11:37:01 +0200
Message-ID: <18c1e6480806040237m1f85c3f2s98ddb35ee1598ab2@mail.gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	 <m3r6bdzm22.fsf@localhost.localdomain>
	 <18c1e6480806040111s606701dfwc8a2ae5f742307b5@mail.gmail.com>
	 <200806041050.09701.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 11:38:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3pS3-0005io-PA
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 11:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbYFDJha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 05:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbYFDJh3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 05:37:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:52367 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332AbYFDJhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 05:37:03 -0400
Received: by rv-out-0506.google.com with SMTP id l9so15205rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 02:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cGhBsply9BG0Te1C5UXmtpGUaYeuAcU6AWwwUCaq774=;
        b=cXJ81omeLmXcNObDWcAsHpED0ySMIuYxz+297yLvfzocw28UKeFvNwwc/8dncpHquf
         HPefhhUBLtBk8l+2DCz29EADtg4M4qLjkR5yYRwxgnfEbp95cYTBxQfam+m2tnSlJ7fF
         yBa3/w2hcTyXcRc3Ol/Guftx+TOUmeufexVBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aA1a5KjlCXSrbPhg37HZSVfocvo3oQ/ztdmkFqzBT617nfkOBd7ZOGJuyST7jEZW92
         NBMhSlo1sKd2Kkk4WFuNSrtsZ0eh9o9qpE+7lo3p/61Sq36euvGlt+D3nuL2Zn1iq4T+
         Kslfr9U/djWor7wrvq9/LaDFXAmkO5OXpZNYM=
Received: by 10.141.33.21 with SMTP id l21mr6496835rvj.140.1212572222020;
        Wed, 04 Jun 2008 02:37:02 -0700 (PDT)
Received: by 10.140.194.15 with HTTP; Wed, 4 Jun 2008 02:37:01 -0700 (PDT)
In-Reply-To: <200806041050.09701.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83765>

On Wed, Jun 4, 2008 at 10:50 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 4 June 2008, David wrote:
>>
>> Thanks, but this doesn't quite solve the problem. I'm on the verge of
>> figuring it out, and would appreciate any further tips :-)
>>

[snip]

> I think the simplest solution would be to mark old master, change it
> to topic (merge or branch -f), and use interactive rebase.
>

Thanks for the idea, but doesn't this make your 'master' branch very volatile?

My understanding is that it's better to keep master as stable & "main
line" as possible, and only merge into it when the bits being merged
are relatively safe.

In your example, you still have a TMP "rollback" point if you need to
rewind master in the event that the merge into master goes badly.

Maybe jumping master around like that works better when you're more
experienced with git and can fix problems with master quickly.

In my case I make rsync backups of my git repos before I do anything
that looks remotely dangerous ;-)

David.
