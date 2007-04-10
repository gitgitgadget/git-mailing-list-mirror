From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 20:04:04 +0100
Message-ID: <200704102004.08329.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 21:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbLdb-0005Xw-IH
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 21:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbXDJTEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 15:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbXDJTEQ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 15:04:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:31653 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbXDJTEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 15:04:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so132522uga
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 12:04:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uOzbcXq98uwpqnHfHrapNMjf5jWvfzs7MeJ5WDxICovJR9ZkUWkjOD/cEallrOWtAHlQFcc50H6hcuh1JOhDMp5iOew6XUbkEXANVN4sjxlN8HzaL6Zu3Z/GfZPCUaB74GaDSKbCI9T4pwc4MCghhxSuMCWbljy08JLEhhlTJBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S+TPJ5Wyn6Z6IsGUED5RVVpFQEkSZ9RE1bpBQ9wVR1DYe5bNEtFRteWOWzqyaa4x/NwJlDXbsXA/nbYBqce6J3lR6Ox7nYLInJ1X1nEqk0TsHMyFJI9clZfTiHNOUjcE3NoX3TpkCJXFZXVANKwHY1lgIdWpgW3147qEDfK8cKM=
Received: by 10.66.252.18 with SMTP id z18mr468929ugh.1176231854182;
        Tue, 10 Apr 2007 12:04:14 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id e33sm1089445ugd.2007.04.10.12.04.12;
        Tue, 10 Apr 2007 12:04:12 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44138>

On Tuesday 2007, April 10, Linus Torvalds wrote:

> (But there's nothing that says that the ".gitmodules" file couldn't
> just use the same parser as the git config file, so I don't really
> strongly care either way. I just think it would be nice to be able to
> say
>
> 	[module "kdelibs"]
> 		dir = kdelibs
> 		url = git://git.kde.org/kdelibs
> 		description = "Basic KDE libraries module"
>
> 	[module "base"]
> 		alias = "kdelibs", "kdebase", "kdenetwork"
>
> or whatever. You get the idea..)

Would it be nicer if .gitmodules were line-based to aid in merging?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
