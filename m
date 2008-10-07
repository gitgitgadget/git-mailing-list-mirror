From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Files with colons under Cygwin
Date: Mon, 6 Oct 2008 19:05:58 -0700
Message-ID: <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 04:07:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn1yo-000170-NH
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 04:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbYJGCGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 22:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbYJGCGH
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 22:06:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:27787 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbYJGCGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 22:06:04 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3121896wfd.4
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 19:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references
         :mime-version:content-type:message-id:cc:content-transfer-encoding
         :from:subject:date:to:x-mailer;
        bh=QeGSe2LEerDBEx7uWdGRdB4Z+bzdJ++AE3Ya5ZSso7w=;
        b=g+IOg9xNLzPyznqq6UYTZ5Ol38THbXRzP0za5dAAVRfs/eJvbKT2LyAgXBBi4cp9As
         3m6yeCnKDjMzcaAKUgZyPeAq2hZN7/vNHGemlPnwpxuzCPrNCAA5FYub5AzbrliXA5jD
         cV0KPlomKu2GCONtlx0EW1UPPYQ3oEcVqskCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc
         :content-transfer-encoding:from:subject:date:to:x-mailer;
        b=H7SF79IL52r8IaGMtrWuehGw234mSBj2ZtQ2Eppv/oSpklDlbUbDW2nFzVUkw2u2Wd
         JwZL+LIgdOsp4S/IOU+tC5ij5bM9GemBd0GKjM9mNFxBkUb+diVpeuRbUARtuEFP8XC5
         dtdA7+KXR7vOij+URwvDxuDRHFI0XK8hEUX4o=
Received: by 10.142.156.19 with SMTP id d19mr2308721wfe.261.1223345162105;
        Mon, 06 Oct 2008 19:06:02 -0700 (PDT)
Received: from ?192.168.1.24? (c-71-227-190-72.hsd1.wa.comcast.net [71.227.190.72])
        by mx.google.com with ESMTPS id 22sm15156210wfi.14.2008.10.06.19.05.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 19:06:00 -0700 (PDT)
In-Reply-To: <20081004233945.GM21650@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97654>

On Oct 4, 2008, at 4:39 PM, Dmitry Potapov wrote:

> On Thu, Oct 02, 2008 at 04:02:23PM +0200, Giovanni Funchal wrote:
>>
>> Cygwin does not allow files with colons, I think this is Windows  
>> stuff
>> one just can't avoid.
>
> I wonder if the problem exists on Mac OS X too. From what I heard, it
> does not treat ':' as a normal symbol.

The short answer is that Mac OS X's POSIX implementation works as  
expected (internally replacing ':' with '/') without issue.

Furthermore, my POSIX-like environment Lamp (Lamp ain't Mac POSIX)  
that runs on classic Mac OS (much in the manner of Cygwin) provides  
the same Unix filing behavior, so Mac filing syntax isn't an issue in  
running git on Mac OS 9.  (I'm sure everybody's breathing a HUGE sigh  
of relief at this news...)

Josh
