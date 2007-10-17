From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 12:32:13 +0100
Message-ID: <200710171232.13062.andyparkins@gmail.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <20071016230952.GA18099@machine.or.cz> <402731c90710162041q457c7dd3tf906ba0c6faf29ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: David <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 13:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii78W-0002SP-8U
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 13:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758701AbXJQLcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 07:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758618AbXJQLcS
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 07:32:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:61616 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbXJQLcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 07:32:17 -0400
Received: by ug-out-1314.google.com with SMTP id z38so237663ugc
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=Bq+u9yLwlt7O3KZpsTvCY6hPd4xkj7uPS7fMl68aY4k=;
        b=Kv5bpEOK6DhRaPj6pThp+2xqpZt8i2DOroH5bKbzeWgqyTyvrOKa+iJeKxaHpnAmp9BLdxq+4eAJsZ3sJN7Kz/pVjMwDoWuePqwycO8t7dt6fq3jzrhFXGS6gSUIkWVqt/vdwPyN+om3AKOyiUmfVYIjpYdKUt5/hKBrZklDhxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=eTHY0VIuFYnK91K1ckEuGfOye60zAKDswKM1jenlINrKRSme0uY6ExBbComHZTtXaSkMu2pVtdSLTFAMVqKLHHx7QDcrWRKzZBoDIyrlIhS20zPygERQJHya7UQb8unh7hqwrUgPu0KwDPmCrIcEPsWYDJyQ4MLldd2Yvw6TFps=
Received: by 10.67.116.15 with SMTP id t15mr527917ugm.1192620736032;
        Wed, 17 Oct 2007 04:32:16 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b33sm1783533ika.2007.10.17.04.32.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2007 04:32:14 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <402731c90710162041q457c7dd3tf906ba0c6faf29ca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61370>

On Wednesday 2007 October 17, David wrote:

> The last two are extremely useful, especially if you're hacking on
> python.  That's
> listchars=(less-than)tab(greater-than)(colon)(dot)(backslash)(space)
> (don't forget the space!).

On the subject of high-ascii chars.  Here's my favourite for your .vimrc

 execute 'set listchars+=tab:'.nr2char(187).nr2char(183)

187 is the "significantly greater than" symbol and 183 is a central dot.  i.e. 
every character of a tab is non-space.  The actual characters used aren't 
actually the point I wanted to make; the thing here is that two non-space 
characters are used, so every column occupied by the tab is visible - this 
makes it very easy to see where tabs end and spaces begin.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
