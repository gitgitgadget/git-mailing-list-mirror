From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Git SVN Rebranching Issue
Date: Tue, 4 Nov 2008 11:15:53 +0100
Message-ID: <bd6139dc0811040215r68cc8443y2b723d6018e2a17b@mail.gmail.com>
References: <20081103140746.GA5969@mars.cyantechnology.local>
	 <20081104084111.GB14405@untitled>
	 <20081104094224.GC24100@dpotapov.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Matt Kern" <matt.kern@undue.org>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 11:17:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxIyE-0007uo-Qb
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 11:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYKDKP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 05:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYKDKP4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 05:15:56 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:23694 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYKDKPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 05:15:55 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2625726fgg.17
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kcDYKpzmda5BObINOA+ePW7krS2HTACybi/RiS/uVVA=;
        b=OBpWzFI68yxB6MU8efyvR9mdhZFCUdokwoz7EJo6rn1H2mByt1Obmp6xa7tMt7IH8T
         xsBDdOlQEEPizlVutAyatsVVoN6yYlab0NcuQvYoBc0j/QE3qb5Zo3a0Ozfbs+33ndBf
         u5omGPiPWLjLPSz6bCCbEJBGk4YoHF3aNOORs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=PlYLWZXKw/E6ana/9GoyaP1Kr14aodpMupmAgoDt0DazipQr/pjyb3UZr5GmT5k/Fu
         cqCbQC2Dkehz6aKcgk/RrbKZQieGNp02siS2tBbi91I5PsOmNNwqXHpBVwzrcIXmRTaf
         rzWyMVU9+IEb/6v7uCfua58E+R/EWPlrbo/Ws=
Received: by 10.187.225.12 with SMTP id c12mr234334far.9.1225793753669;
        Tue, 04 Nov 2008 02:15:53 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Tue, 4 Nov 2008 02:15:53 -0800 (PST)
In-Reply-To: <20081104094224.GC24100@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100066>

On Tue, Nov 4, 2008 at 10:42, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Tue, Nov 04, 2008 at 12:41:11AM -0800, Eric Wong wrote:
>> Short answer: you can use grafts to remove parents.
>
> Using grafts requires some cautious, especially when it is used to make
> some commits unreachable, because git gc can remove unreachable commits.
> Also, a repository with grafts cannot be cloned.  So using grafts looks
> like more as workaround rather a real solution

I think what was meants is to use grafts and then make them permanent
with 'git filter-branch'.

-- 
Cheers,

Sverre Rabbelier
