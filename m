From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: git branch diagram
Date: Fri, 18 Apr 2008 07:08:46 +0530
Message-ID: <2e24e5b90804171838w6809cb17sded64367d5ebc222@mail.gmail.com>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Fri Apr 18 03:39:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmfZe-0003NG-Am
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 03:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYDRBit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 21:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbYDRBis
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 21:38:48 -0400
Received: from ti-out-0910.google.com ([209.85.142.184]:34149 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbYDRBis (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 21:38:48 -0400
Received: by ti-out-0910.google.com with SMTP id 28so44733tif.23
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 18:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pMqj9qwsOwRZfu4dvFzGzRu7eiI+6TA9m/NV348Vlas=;
        b=x5i68r5tDQG5wJHjsATA8yBBidvYgAr+fS7Ztk8b/sZAvA6bvwsSG0Vlho24MP2yNOrnEN0OXtKNsexEk/p9QqnqoYnuX65fgO0FsCiy8AKeqUbAFul/Vj5bpBIK5WcVujIS+tgzise0mMVofjtFMFUsbkhJbVuEL+Wby9/YAes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tURMBd1TsHPXqVZsQkUYBR4xM1oN1Ge48SFEbFYlg+f267Vuy6cFfyuex1RiNrFrt+i6weLN2vYOIURrgSifD01PlEBA+954wGyq5RaNdj1//UrqGrfU/ZYCOrpyLKQBYRCGv3mnGcjWcGZbA0d0s+R/2TmbdDJO1dcsp92qpW4=
Received: by 10.110.52.5 with SMTP id z5mr203843tiz.17.1208482726797;
        Thu, 17 Apr 2008 18:38:46 -0700 (PDT)
Received: by 10.110.52.10 with HTTP; Thu, 17 Apr 2008 18:38:46 -0700 (PDT)
In-Reply-To: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79859>

[Patrick: apologies if you get this twice; the first time I did
"reply" instead of "reply all" and it only went to you, not the list.]

On Thu, Apr 17, 2008 at 10:30 PM,  <Patrick.Higgins@cexp.com> wrote:
>  Does my diagram make sense? Are there any suggestions or corrections?

Looks ok to me, but I'm still learning git myself... so beware of what I say :-)

Some quick comments:

The Project repo (the big one in the middle) need not, I think,
maintain long-lived tracking branches for every developer.  Rather,
that repo would pull based on outside-git inputs (analogous to emails
saying "please pull from ...") and there might be a temp tree created
to test stuff out but once the merge or cherry-pick into the local
master is done that temp tree would disappear

However, if you don't have too many devs then your method is fine too.

The problem with devs working on the same branch that the project repo
pulls is that the commits may have some cruft, even though you said
they'd make branches for experimental things.  The way I'm working
now, my "master" is clean as a whistle and anyone pulling from it and
merging gets exactly what is needed.

Again, this is not a rule, but personal preference and if your style
of working is very clean then this may not be needed.

Regards,

Sitaram
