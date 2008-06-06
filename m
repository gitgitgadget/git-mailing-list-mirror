From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Fri, 6 Jun 2008 11:31:24 +0600
Message-ID: <7bfdc29a0806052231w3f87bf04td44d2275d1bf457b@mail.gmail.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
	 <200806031856.11060.robin.rosenberg.lists@dewire.com>
	 <20080603225418.GP12896@spearce.org>
	 <200806040130.41654.robin.rosenberg.lists@dewire.com>
	 <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
	 <20080604042703.GQ12896@spearce.org>
	 <7bfdc29a0806032345o98eb21dhb8714c8e04218a53@mail.gmail.com>
	 <48475C14.3000505@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ittay Dror" <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 07:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4UYn-0008DZ-0S
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 07:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbYFFFb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 01:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbYFFFb1
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 01:31:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:22436 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbYFFFb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 01:31:26 -0400
Received: by yw-out-2324.google.com with SMTP id 9so602999ywe.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=evtdpFbIIJFJ4KP3wvi3koX9v92g5wxLYhisAxOcdR8=;
        b=xd7jZKQRj9mCv1JNV4KxZytZ1TEQ5bADGDqxUNhYgEYBh639+xGrtW+PflEoneNosO
         jKyJMLaRs+65xxaMhJTP0ToKF/qf1RuKaLlnDpNXwZ2DqEb22jWqGcDkCFPIcyw1dj2I
         EtMHCHC+Yd7zGkKdny6a2tegddCkOCyDMVVSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YgI4Giu6fhJ5QGMu65UAum57Bqv92xCkt4hlbeAjueggHIkLjS7hkgC4p3NZ3pmB5C
         wBneD9+W53ybySUjUidiBSvBzdKSZKYv+hXMEInszgzvAZ8s5msVOrRmf3kAqdrF3OeD
         zVeLj9yty3TyYxqT8rAO/8Ljm2O3HVMNbwKsw=
Received: by 10.151.42.6 with SMTP id u6mr2804964ybj.213.1212730284727;
        Thu, 05 Jun 2008 22:31:24 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Thu, 5 Jun 2008 22:31:24 -0700 (PDT)
In-Reply-To: <48475C14.3000505@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84025>

On Thu, Jun 5, 2008 at 9:23 AM, Ittay Dror <ittayd@tikalk.com> wrote:
>
> For what it's worth, Ant is the most popular build tool. Ant + Ivy (a
> dependency manager) is a great choice. My Next Best Thing (TM) is Gradle
> (www.gradle.org). I wouldn't choose Maven because it makes creating custom
> logic harder and some functionality (like assembly) is no mature. I can
> elaborate on the subject, if people are interested.

I have heard of Ant + Ivy but never got the chance to use it. And what
I do for the messy-maven stuffs is I use Ant from maven. But there are
few features of maven (which IMHO is not the discussion topic of this
list) I like. Will checkout Gradle as well.
Thanks for the hints :).

Best regards,

Imran

>
> Ittay
>
> --
> Ittay Dror <ittayd@tikalk.com>
> Tikal <http://www.tikalk.com>
> Tikal Project <http://tikal.sourceforge.net>
>
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
