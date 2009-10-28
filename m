From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: possible usability issue in rebase -i?
Date: Wed, 28 Oct 2009 15:41:41 +0100
Message-ID: <40aa078e0910280741w1656757asbdfab417688f3e8c@mail.gmail.com>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
	 <2faad3050910270817l71394722nda55265ed96722df@mail.gmail.com>
	 <40aa078e0910270850u6ffec41cj372da11d9df533f@mail.gmail.com>
	 <2faad3050910271405k4a391184vb978b9b35484383b@mail.gmail.com>
	 <40aa078e0910280520t497f1289sf374a3a501856a23@mail.gmail.com>
	 <2faad3050910280734l7297c30erfb0a47b12b0bd07d@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N39if-0001DT-6u
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 15:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbZJ1Olj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 10:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbZJ1Olj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 10:41:39 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42163 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbZJ1Oli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 10:41:38 -0400
Received: by bwz27 with SMTP id 27so1075183bwz.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qek4uU7iSeEPv8C3vBimy4CuWPEegkwiZkBsYu4gdsQ=;
        b=oTFMFsSNUFlco//bUBej8QMvf5wI4Sz8sgccrQXEOcsNRX0mMCe8/NWhNsn0EXOJcM
         /WvPHdAXvEeqqDZcJUco/FatGz3RbZc2pZ+WigrEv9Xx2uO1P8xxHkmPkizHdcNIi9tc
         2cR+PIcukXOeV1TDw06xRNuDirBrKf8DQzAMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=g6yAksxSpkdOjl4FRxZA6gg4UavBx37/FqsceI0y24DrxdMvYWNkoF+jCXYk/uKv+R
         CRk/U5jlInB8RlWkwsKS/Wrmqi/OGbZUPqd276mJiOA4bnFG9h2iLaqqqKkXqrT3fHaz
         ofxRPoKgpIONEuyAmDh4bwtgh2c7X3Mqf0SzQ=
Received: by 10.204.34.83 with SMTP id k19mr5198763bkd.96.1256740902148; Wed, 
	28 Oct 2009 07:41:42 -0700 (PDT)
In-Reply-To: <2faad3050910280734l7297c30erfb0a47b12b0bd07d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131467>

On Wed, Oct 28, 2009 at 3:34 PM, Baz <brian.ewins@gmail.com> wrote:
> 2009/10/28 Erik Faye-Lund <kusmabite@googlemail.com>:
>> I'm not sure I follow - aren't dashless options, uhm, dashless? Do you
>> mean to use the long-form instead of the short-form? I'll assume
>> that's what you mean for now, since you changed "-i" to "--interactive
>> | -i".
>
> No, I just meant 'git rebase' not 'git-rebase'. Sorry, I changed a
> couple of things at once.

Ah, didn't notice that one. I completely agree with you on this.

> tend to emit one-liners. As for calling out 'interactive', at the
> other extreme its not clear to me why we mention '-i' separately from
> '[options]' at all. rebase is already pretty inconsistent here, giving
> short or long usage messages depending on whether you passed '-i'. But
> I'll take comments on this when I submit the patch, I've no strong
> feelings on it.

It's a simple reason why the output is different - this is the usage
for "git rebase -i" (hence it is in git-rebase--interactive.sh). I
guess this distinction would be slightly clearer if we removed the
brackets from the usage like this:

-git-rebase [-i] [whatever]
+git-rebase -i [whatever]


-- 
Erik "kusma" Faye-Lund
