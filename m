From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Thu, 5 Jun 2008 09:33:48 +0600
Message-ID: <7bfdc29a0806042033m430ee521geec7723f8f686ec4@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Jun 05 05:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K46Fe-0005LF-VK
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 05:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYFEDeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 23:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYFEDeA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 23:34:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:41846 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbYFEDeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 23:34:00 -0400
Received: by yw-out-2324.google.com with SMTP id 9so248996ywe.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gwWe2WWani4M/wFpzp6V4H8TIytWxA/YlTsLpqpL+Ko=;
        b=wVyssDk5O2rGhxv9ksNT5mPw5IXxWXkfuvlzinF3HnFba/76Gkk/fAQFpdIzm79WdE
         5dyVrYtpx+dvQp+wTndeQnS6pBV06VgYoCPIjj0gqxXr8vuOf/fh6L1AP6DcQaLzIJS7
         CBboO5Qz5nUrY+DxI8yL/liIuYVHEsww6MPw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KgC3uKwWGhfh0+Og8jNn/xxguQ2LMl8qvGKG6Bz3gmhSkF1o1lfR+55fbSViWnvhr5
         ifY0EVYCZ15NpdzA4mezXNkgEDb97OTYrwRIplDCCO5yqkwhLCBPz0uSo2IR0a6Uf+sw
         oZu5epR80eQkrtLpj4e5aq3Aujf2Gy901YXl0=
Received: by 10.151.105.13 with SMTP id h13mr1117169ybm.71.1212636828376;
        Wed, 04 Jun 2008 20:33:48 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Wed, 4 Jun 2008 20:33:48 -0700 (PDT)
In-Reply-To: <48475C14.3000505@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83849>

On Thu, Jun 5, 2008 at 9:23 AM, Ittay Dror <ittayd@tikalk.com> wrote:
>
>
> Imran M Yousuf wrote:
>>
>> I am sorry for my ignorance, I thought that maven was the most widely
>> accepted java build tool, but what you said is a possibility.
>>
>
> For what it's worth, Ant is the most popular build tool. Ant + Ivy (a
> dependency manager) is a great choice. My Next Best Thing (TM) is Gradle
> (www.gradle.org). I wouldn't choose Maven because it makes creating custom
> logic harder and some functionality (like assembly) is no mature. I can
> elaborate on the subject, if people are interested.
>

Ah, thanks for shedding some light on it.

Best regards,

Imran

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
