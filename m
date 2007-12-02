From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: make test failure with latest master
Date: Sun, 02 Dec 2007 04:52:51 -0800 (PST)
Message-ID: <m3fxylw95y.fsf@roke.D-201>
References: <4752A53E.4030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 13:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyoK0-0001IA-Pr
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 13:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbXLBMw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 07:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbXLBMw4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 07:52:56 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:14165 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbXLBMwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 07:52:55 -0500
Received: by mu-out-0910.google.com with SMTP id i10so126521mue
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 04:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=G2qW8JSFWrtbifMuxAPVGdHMHN/UcODPf6LfcJJDEOU=;
        b=JmqmBaxN0O2eu6eMAw6Kz3G+bM/ELQFBzaDRchoEZTJ90GfrZ43po47fJg1Em1eyOS77JuKvpTcdphrHMpBi/8f+Z1lx7IhxRxOtnKDJyx55wi28HlJ7DJPZPBm64+1wjyCWVko3f8gRGg0+x/BMlUOzHFiNNdwIOteX/Kf6/XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=T6BSFG6M3E40iEgh6rwo+HSPjlskddtdAa9V4c/gv+YoEjqKrC4O89+9iDYKbHxFWm2IH2skvNBlH4+Jj3KcmgNI4rsTBaxWsiDLMqII+cOSlapburb/kWYNWl5kJ9KnnMvhBypHdkBsnr93prdYBE4QFNrpOrIJL2zsyDi82oM=
Received: by 10.86.84.5 with SMTP id h5mr9472771fgb.1196599972873;
        Sun, 02 Dec 2007 04:52:52 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.146])
        by mx.google.com with ESMTPS id l12sm3602258fgb.2007.12.02.04.52.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 04:52:51 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB2Cqhgf028228;
	Sun, 2 Dec 2007 13:52:43 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB2Cqfhk028225;
	Sun, 2 Dec 2007 13:52:41 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <4752A53E.4030000@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66776>

A Large Angry SCM <gitzilla@gmail.com> writes:

> [Resent due to incorrect list address.]
> 
> With the latest master, 2221a6757161af1905925c405aded9ff470f70d5,
> "make test" now fails; last successful "make test" was mid-week
> sometime with master d25430. This is on a laptop running Suse 9.3.
> 
> 
> *** t9600-cvsimport.sh ***

Trivial question: have you got cvs and cvsps installed?

-- 
Jakub Narebski
