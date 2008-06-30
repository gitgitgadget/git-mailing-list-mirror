From: "Adr3nal D0S" <adr3nald0s@gmail.com>
Subject: Re: Multiple remote.<...>.fetch and .push patterns
Date: Mon, 30 Jun 2008 14:52:19 -0500
Message-ID: <308083c30806301252l25f072anafbc457f48c6b19e@mail.gmail.com>
References: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>
	 <48693434.4090402@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 21:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDPRH-00085L-Tr
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 21:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbYF3TwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755784AbYF3TwX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 15:52:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:64699 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbYF3TwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 15:52:22 -0400
Received: by yw-out-2324.google.com with SMTP id 9so826821ywe.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wEDq3JeuGqI/GmteHK9ZDAW424O3RK7+pZlguTGhWL0=;
        b=TypKSatVTMKfxclE8JBcOFSE00TWe7gR63/sL58XqHzaOK5+WU16dDnlpoZLA4BIkS
         ZXpcH1jUMLEehFn3cZQVEgfw6pPKqK9mvw5FiujuWzDE5pHJHJdwLqfjWxEvcugYuo1d
         pziXEcuZMSSeHgX5YTUX36NLgKtoceZmBlwFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EP+P4N///R6PhPPjk4u2Y6BGxLdFdQWlg9aKIiIHezNgOUsZNIBaxd0VLM1vgunOFd
         ZrRYhCWHPPwHTCubrkLIyth+GxLD9iOGqY4z1hvDjn0l1+yveA2UVoW4QELsI1xh6xji
         5Fyt/NxNP69U7gyzjeKy4+b1lPx2Esaqs8nJ0=
Received: by 10.151.108.15 with SMTP id k15mr9033110ybm.88.1214855539270;
        Mon, 30 Jun 2008 12:52:19 -0700 (PDT)
Received: by 10.151.15.1 with HTTP; Mon, 30 Jun 2008 12:52:19 -0700 (PDT)
In-Reply-To: <48693434.4090402@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86934>

In reference to my question about .git/remotes/ko, Jon Loeliger
<jdl@freescale.com> wrote:

> You can have both Push: and Pull: lines for a remote there.
>
> Or have I misunderstood your question here?

I know that I can create files in .git/remotes that look like Linus'
ko sample.  But I was wondering if this could be done with git-config.
 I have some developers that are new to SCMs in general and git in
particular. They are a little nervous playing in the git directory.

Also, I was uncertain how settings in .git/remotes files interact with
git-config ...fetch and ...push settings, if at all.
