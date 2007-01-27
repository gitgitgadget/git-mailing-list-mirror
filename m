From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Allow the tag signing key to be specified in the config file
Date: Sat, 27 Jan 2007 16:24:48 +0000
Message-ID: <200701271624.50336.andyparkins@gmail.com>
References: <200701261413.46823.andyparkins@gmail.com> <7vodolnfes.fsf@assigned-by-dhcp.cox.net> <45BB55B4.5090303@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 17:27:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAqP3-0001Ij-Dm
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 17:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXA0Q1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbXA0Q1m
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 11:27:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:52531 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbXA0Q1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 11:27:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so932835uga
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 08:27:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WhM0yrJQZapmU3fD1E9CZraInP4IoCz7qO11ZbptLQO0Mir+Mw1DKTbPn4CiTDFbNo6gxIiPfXPrqDx+eNABQtt9/zQa0vS/0AXwWkdUQ75Ggp4PBqpXAHG+KhWD6+B0Erv4zXPXj7yjmhy+B/kXMKk8JQ/FjKA4uTUcXh7Agts=
Received: by 10.67.117.18 with SMTP id u18mr5987027ugm.1169915259967;
        Sat, 27 Jan 2007 08:27:39 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id m1sm6107786uge.2007.01.27.08.27.37;
        Sat, 27 Jan 2007 08:27:37 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45BB55B4.5090303@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37958>

On Saturday 2007, January 27 13:37, Simon 'corecode' Schubert wrote:

> is there a reason to use name + email as keyid and not just the email
> address?  that would also mitigate the need to specify user.sigingkey
> if only the names missmatch between gpg and git, but the email
> addresses are the same.

That was my original solution, but it was rejected.

http://www.gelato.unsw.edu.au/archives/git/0610/29733.html



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
