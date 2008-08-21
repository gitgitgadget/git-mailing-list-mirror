From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [JGIT PATCH] Allow make_jgit.sh compilation under Cygwin or Mingw (MsysGit) with Windows JDK
Date: Thu, 21 Aug 2008 10:48:10 +0100
Message-ID: <e2b179460808210248v3bf00031v23476d45d59b7e6d@mail.gmail.com>
References: <1219311191-10984-1-git-send-email-mike@abacus.co.uk>
	 <7bfdc29a0808210235r53976f9ai4ddb42e19fd318be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 11:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW6n6-00082r-Mr
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 11:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbYHUJsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 05:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYHUJsM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 05:48:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:3741 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbYHUJsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 05:48:11 -0400
Received: by wx-out-0506.google.com with SMTP id h29so802092wxd.4
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QHLMimu3HyOhOkmhT0o9JHlX+UucneteDMTWa97WYOg=;
        b=SCFL+WoN54o3Q5Cb0U0KqzwTROMcl5T3QtIrWjTaS4zjd78ZvP16kbEjvldkPNW15q
         KB74m+EhnNimJiV0KhTlpTmpyGAmldlWAlFmIeUwnA0ukTpLpwJODDRbqVRNJYO/D/X0
         h721cyhiFt+3sYxYBQgFWFzcyUvy9e51B1mRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Cejn2t/wusXu7DEAj5Si4kYzUKOgeu68h/SqYDIDaaAPNmVHRf3/hD7VwRvxsClgwN
         Grxhm6ktrtttga//4BzRvURL2Us4qrQ+qC1lrqX2dgODZK34www5Tli6d1H4XQ+NepY/
         TDKFv6pww6RJmY4go6iGFtEBR1xjFuBAzd7/U=
Received: by 10.70.77.19 with SMTP id z19mr1424737wxa.83.1219312090330;
        Thu, 21 Aug 2008 02:48:10 -0700 (PDT)
Received: by 10.70.20.13 with HTTP; Thu, 21 Aug 2008 02:48:10 -0700 (PDT)
In-Reply-To: <7bfdc29a0808210235r53976f9ai4ddb42e19fd318be@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93131>

2008/8/21 Imran M Yousuf <imyousuf@gmail.com>:
> On Thu, Aug 21, 2008 at 3:33 PM, Mike Ralphson <mike@abacus.co.uk> wrote:
>> Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
>
> You can also have a look at the Maven project for JGit (will have
> JGit-pgm mavenized once JGit's process is accepted). It should build
> JGit uniformly on Windows and Linux.
>
> http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/mavenize-jgit

A bit heavyweight for me, as I don't use Maven for anything else, but
a good pointer for others.

Thanks,

Mike
