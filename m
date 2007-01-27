From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Allow the tag signing key to be specified in the config file
Date: Sat, 27 Jan 2007 11:55:51 +0000
Message-ID: <200701271155.53519.andyparkins@gmail.com>
References: <200701261413.46823.andyparkins@gmail.com> <7vodolnfes.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 12:58:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAmCo-0003hk-Gy
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 12:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXA0L6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 06:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbXA0L6p
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 06:58:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:44417 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbXA0L6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 06:58:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so897650uga
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 03:58:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XZ3rh8qQgvW1SHla9dnXfSee48O1SKJ5rAVw3D0egGNRIHrPdHDsq+RoLsHhW7xkvUz3823UfexdBtXH135hXdKaFo8Lu06KogFg3SDDIR7HytkqFWSk4FfBmDkHH92IKPV6UOutEY60KwF/KqtGchkzz1A5dZ+eJmuGQfHFfz0=
Received: by 10.67.22.14 with SMTP id z14mr5711031ugi.1169899123495;
        Sat, 27 Jan 2007 03:58:43 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 59sm5706101ugf.2007.01.27.03.58.42;
        Sat, 27 Jan 2007 03:58:43 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vodolnfes.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37948>

On Saturday 2007, January 27 06:37, Junio C Hamano wrote:

> Why do you use ": ${parameter:=word}" substitution after having
> already checked that keyid is empty, I wonder...  Am I missing
> something subtle?

Nope.  Just that I didn't know what the ":"-notation on a bash line 
before and couldn't find documentation covering it, so I played safe 
and left it untouched.

Feel free to drop the enclosing "if".


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
