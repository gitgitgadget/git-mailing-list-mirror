From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules
Date: Fri, 18 Apr 2008 09:48:24 +0800
Message-ID: <46dff0320804171848v1f48735dt9930dc023bdb0946@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
	 <1207970038.10408.8.camel@ginkgo>
	 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
	 <1208202740.25663.69.camel@work.sfbay.sun.com>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <1208461808.26863.129.camel@goose.sun.com>
	 <alpine.LFD.1.00.0804171530460.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Roman V. Shaposhnik" <rvs@sun.com>,
	"Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 18 03:49:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmfiy-00066c-7d
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 03:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYDRBs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 21:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYDRBs0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 21:48:26 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:49015 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbYDRBs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 21:48:26 -0400
Received: by an-out-0708.google.com with SMTP id d31so83538and.103
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 18:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tfUmn+1MctzFupmsrFAT0+wJlzp1DEfnxhcL8inqTHA=;
        b=sQmg+UNx0KHTeNm4D8H7D2DaNITuuyOT7PqbDQUfRIywYKoDp3cvvt8xpPlVt1KNtcARPBaweOf7nJIyaspmxpuZ5uRU54X9fMzvbmcPOzZs0J+zWAxRSCCKdyET92lQ0bJQaBd/RxhC5g7p4nRYG88yek4X0uaP/4lhlQgPicg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xONmq7mVd2EjfSIyWWjXjZgTPqO8qTdVhhSQmS0kWm2j7nxGoW4RMHqJWjdnZzU1GmXUCaLXmrqppFrgJVXuJB14S47/QzHMz3VeE1gqxmvMrMrgRsvAZ+7xQmweYKTYJbFyzLuF7Hpc27huomJfQv9nw0uY+p6xYJXUxMRoDBg=
Received: by 10.100.194.5 with SMTP id r5mr3868287anf.146.1208483304812;
        Thu, 17 Apr 2008 18:48:24 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Thu, 17 Apr 2008 18:48:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.00.0804171530460.2879@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79861>

On Fri, Apr 18, 2008 at 6:32 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>  On Thu, 17 Apr 2008, Roman V. Shaposhnik wrote:
>  >
>  > Are you saying that a *remote* in-tree .gitconfig would be capable of
>  > affecting *local* system before the end of the clone operation?
>
>  No. But what do you do after a "git clone".
>
>  Do you, for example, do something like "git log -p" to actually see the
>  commits?
>
>  And what happens if that runs an external diff viewer script that just
>  happens to do a "rm -rf $HOME"?
>
Good point. This is the best example (maybe the only one till now) i
have seen that demostrates the bad thing of in-tree .gitconfig. So i
vote for the limited in-tree .gitconfig point of Linus.



-- 
Ping Yin
