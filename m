From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Tue, 30 Oct 2007 16:51:45 +0800
Message-ID: <46dff0320710300151k56cdf8a9o77e163e3167e73e@mail.gmail.com>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
	 <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
	 <20071028111443.GA29183@xp.machine.xx>
	 <46dff0320710282345r2922ac7dj9c7a4eb3e20fd011@mail.gmail.com>
	 <20071030005217.GT14735@spearce.org>
	 <7vmyu1s1qt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Peter Baumann" <waste.manager@gmx.de>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Immpc-0006Ao-HC
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbXJ3Ivs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbXJ3Ivs
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:51:48 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:42813 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbXJ3Ivr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:51:47 -0400
Received: by py-out-1112.google.com with SMTP id u77so3401286pyb
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SWHPXggbzSvDuQ2VUcD2M1t+G14yDD4QyJ7u1/gyGGc=;
        b=DmgY7LmBlH5SB2dzDcmWIQm4WmNxf0FqLdTmKMJvpzqiVOqvl2z/srtOnRrKw3zcjCWYBbgJjUVeccVPYLmIWXf2ycREevNRZV+/hgsJVw/RfscvWwai1ReD+2TVS9GnWmCnDlVK2Pzhfq0kx+XSmxErvrF9IQZOLsCXPPF6ZV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sz5tfXgg36XaSc3BwZmLkULcRBVQLD62gF3LeBELbKHaeUvm2T25VkrC+SEAXWXibl+MhXMPs9DBLO/oYYhDfV2hcEMM8DfyEmXguXEByiojmuarI5KY0BJ0EaFjGhhNR6DetFxw0cNwwbxyUITfP39jFifX1k6wHpEAhaPYQZk=
Received: by 10.35.117.5 with SMTP id u5mr8548848pym.1193734305524;
        Tue, 30 Oct 2007 01:51:45 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Tue, 30 Oct 2007 01:51:45 -0700 (PDT)
In-Reply-To: <7vmyu1s1qt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>
> Actually, subtree strategy was designed to allow merging back
> and forth.  But the result, as it _is_ a merge, will not omit
> any commit from the history from both branches.
>
>
Can git-log be more clever so that it can recognize a subtree merge
and show only logs related to the subtree?

Another suggestion is that the commit msg for subtree merge should be
more accurate such as " Merge branch master of <repos> into direcotry
<dir> of branch <branch>"


-- 
franky
