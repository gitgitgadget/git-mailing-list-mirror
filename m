From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 18:46:28 +0200
Message-ID: <bd6139dc0807150946j709d9776xf61828d132aa34ad@mail.gmail.com>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
	 <20080714085555.GJ32184@machine.or.cz>
	 <alpine.DEB.1.00.0807141256310.8950@racer>
	 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
	 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
	 <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
	 <20080715092023.GO10151@machine.or.cz>
	 <20080715150626.GA2925@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.0807151623120.8950@racer>
	 <alpine.LFD.1.10.0807151213000.12484@xanadu.home>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIngZ-0003RX-3R
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 18:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbYGOQqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 12:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbYGOQqc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 12:46:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:25936 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbYGOQqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 12:46:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5404359wfd.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JfzLbfk8kpOwIJGpEAfmfDdYcvFB+AUEadbjKJ3HFtg=;
        b=x3z8tj195b5Jfhmw5kHcV3LLx1U5mvYkDW710cd/eNBVocJdp95mOkOkqZ0F9Um7Nd
         yb5WOsrhRFFXTKFX9zXSLxO5ezRIz0yceIr4yproC9T2iAIPPBO7T/GNvSpxdWS1hCGw
         B62iRxViBZ6Qmxr59uCTrCkj5xQmEkQutIEhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=BJWISK0kEvZAWacJXqt5DqiDKDoxL4MaSVyjqCRs319FTyDCyk36N5rhgwtWXwt+qJ
         wVGLjPrEduOWVONEGC2iQz1p+/ASut/+ykHUtdoZY/tT+k7qlfjm8/0O98Jrn1H7wdIM
         9q5W4gK9QVwtafztI6xfRyx16YvzT80JqM4HM=
Received: by 10.142.48.14 with SMTP id v14mr4743617wfv.133.1216140389052;
        Tue, 15 Jul 2008 09:46:29 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 15 Jul 2008 09:46:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0807151213000.12484@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88578>

On Tue, Jul 15, 2008 at 6:26 PM, Nicolas Pitre <nico@cam.org> wrote:
> Anyway this is all hand waving until someone can come with some evidence
> that git 1.4.4 is actually used by a significant amount of people, and
> that those people depend on dumb transfer protocols.

Can't we add a msg to 1.4.4.x when it finds pack version 2 to upgrade
to 1.5.x? Gets rid of the problem all together while still giving the
user a reasonable message when it finds a repo version 2.
Hey, here's an idea, can't we have 1.4.4.x just give that msg for everything?

$cat git
#!/bin/sh

echo "Please upgrade to 1.5.x, version 1.4.x is no longer supported
nor should you even want to use it </cluebat>"

-- 
Cheers,

Sverre Rabbelier
