From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 18:31:27 +0000
Message-ID: <200703011831.29321.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <20070301120042.GD63606@codelabs.ru> <Pine.LNX.4.63.0703011802130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 19:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMq6e-0000Tc-FH
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 19:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965474AbXCASeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 13:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965488AbXCASeT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 13:34:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:19676 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965474AbXCASeT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 13:34:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so440002uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 10:34:17 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GXYsgXqYV1KfyuglnJjT6rups/3DblQgDpc0npZe3JJWMg1rJIipPC3ymmv9M0VU3kb8Z5oV9CVqI7u+nqlXXqWUReCgiOdkOMGhzvYgg7pIMneKcFfkT3XRU2OxzF1GAXMl2zI9C5OWPT6DgvC0KKQPoFD8cIwA8jdyTrKwtjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UlPl34YQG7RV+bl+tXae419FfL6NFzj0t4kuk6Cyuto1uqJaD5nAk6y7xQ1bpdmqImxRFws6yA7syGvk6HQdO9qUmJoLoJwP8fTnXN5jYiK9FHP0zozWWdy9mke9Q5G4tafhbmpvPkylmOzDxxZQHlurHfXe05h6oZcYpjo7KRU=
Received: by 10.67.29.12 with SMTP id g12mr2531099ugj.1172774057419;
        Thu, 01 Mar 2007 10:34:17 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 54sm2121442ugp.2007.03.01.10.34.14;
        Thu, 01 Mar 2007 10:34:15 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.63.0703011802130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41113>

On Thursday 2007, March 01, Johannes Schindelin wrote:

> The problem is: Git does not track files, but rather trees. So, there
> is no sane way to add an Id.

> If the file is too big, your colleague can run it herself and send
> you the object name (it is a 40 character hex string, but the first 8
> or so should really be sufficient).

So when you say "there is no sane way to add an Id", you meant "here is 
a perfect string that would act as an Id"?  ;-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
