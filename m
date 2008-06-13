From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 10:47:44 -0400
Message-ID: <6dbd4d000806130747r403cf637t66d59b58b9489e33@mail.gmail.com>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
	 <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
	 <alpine.DEB.1.10.0806130946060.8043@alchemy.localdomain>
	 <6dbd4d000806130659r2a8bc57ev6db4ef058ee97440@mail.gmail.com>
	 <48527FEC.8080909@isode.com>
	 <alpine.DEB.1.10.0806131016120.8043@alchemy.localdomain>
	 <48528769.2000007@isode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Chris Ridd" <chris.ridd@isode.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Aa4-0008FL-Vg
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbYFMOrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755022AbYFMOrv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:47:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:51357 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbYFMOru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:47:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2781682fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=acLGyRWc5jHmckoyQw/6FpJnlFT9QDPqmCMH0Jmlrlk=;
        b=uEQdjZha2K4RkQtupvUhdMmGzFPGfVT9J71ALNKt1U5QlfOVpmIbERRRh3CCn5y/qn
         G+JGRzDqQX+MYFw0RClvka4/sfrYKLbJZc8Vo+/8P/RqMgDJidqBOycowrDwBAOCyOSl
         8BHF7cVoKUcRZZ2+9/NxFtLtcxqvGHflDnzzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=baj86I0pXieX3ad5wy6m7kYwD08oIIn0Vh2nhyVZHdIxHqvRglhZcLyMpM1MdTkmot
         zfvktuLplxM4J53zk0h5UsaTvFsoZYVtUsUd1bqjb40VQ7oS9vHMQYR6chNuDgh+9XEm
         Mx7ow92KESYItcG93ZOcqWWFKt/SwjQmXi7Bo=
Received: by 10.86.87.13 with SMTP id k13mr4105677fgb.38.1213368464580;
        Fri, 13 Jun 2008 07:47:44 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 13 Jun 2008 07:47:44 -0700 (PDT)
In-Reply-To: <48528769.2000007@isode.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84886>

On Fri, Jun 13, 2008 at 10:42, Chris Ridd <chris.ridd@isode.com> wrote:
> Asheesh Laroia wrote:
>>
>> On Fri, 13 Jun 2008, Chris Ridd wrote:
>>
>>> Denis Bueno wrote:
>>>>
>>>> On Fri, Jun 13, 2008 at 09:46, Asheesh Laroia <asheesh@asheesh.org>
>>>> wrote:
>>>>>
>>>>> Does OS X ship /usr/bin/env?
>>>>>
>>>>> If you type "/usr/bin/env perl" in a Terminal window, do you get Perl?
>>>>
>>>> Sorry, I should have made that clear earlier: yes.
>>>>
>>>> funsat[122] > /usr/bin/env perl --version
>>>>
>>>> This is perl, v5.8.8 built for darwin-2level
>>>
>>> MacPorts /tends/ to make ports use stuff from other ports instead of
>>> using Apple-installed bits. In this case, maybe git from MacPorts is using
>>> perl from MacPorts?
>>
>> FWIW, the problem seems to be that it's not finding *any* Perl.
>
> That's odd, because the Portfile for git-core (1.5.5.3_0) does the build,
> test and destroot install setting:
>
> PERL_PATH="/usr/bin/env perl" NO_FINK=1 NO_DARWIN_PORTS=1
>
> (and some other stuff). Have you pinged the port maintainer
> (bryan@larsen.st)?

The issue seems to be one of the way bash is treating quotes.  It
apparently is trying to find the *command* "/usr/bin/env perl" and not
executing the command "/usr/bin/env" with a first argument of "perl".

See my message to Luciano moments ago.

-- 
 Denis
