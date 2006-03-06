From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport woes
Date: Mon, 6 Mar 2006 22:24:03 +1300
Message-ID: <46a038f90603060124h4ea1c3c6gaa5d8b52ed311230@mail.gmail.com>
References: <44094618.6070404@asianetindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 10:24:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGBwx-0004ZP-5w
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 10:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbWCFJYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 04:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbWCFJYG
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 04:24:06 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:17345 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752339AbWCFJYE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 04:24:04 -0500
Received: by wproxy.gmail.com with SMTP id 50so1098818wri
        for <git@vger.kernel.org>; Mon, 06 Mar 2006 01:24:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uYWyJBDAq7L3gcaZc2s7t8DMfNJYEkCGg+NFSxJWhqcRPkbp6NLFWhQfJSRN6MD9dB2eWV9N8+WdLrLDg2NzObd5dpP5b6O/OCgfQxWjZuTZPCkQED3PHLuN6nSZGl2FvQepp3e0dZmQdtBmLok/KdHqxdF22L4WpTZVjZgf/+A=
Received: by 10.54.66.18 with SMTP id o18mr4947761wra;
        Mon, 06 Mar 2006 01:24:03 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 6 Mar 2006 01:24:03 -0800 (PST)
To: "Rajkumar S" <rajkumars@asianetindia.com>
In-Reply-To: <44094618.6070404@asianetindia.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17291>

Hi Raj,

you don't seem to be making any silly mistake. Make sure you are using
a recent git, and a recent cvsps. Actually you want the _latest_ cvsps
(2.1 I think).

A good thing to check is what cvsps is telling cvsimport.


Now, here you are not showing us your cvsimport commandline:
> cvs_direct initialized to CVSROOT /home/raj/cvsroot
> cvs rlog: Logging src
> skip patchset 1: 1141457879 before 1141457879
> skip patchset 2: 1141457879 before 1141457879

Ahhh... ok, you are doing it all very fast. Is this a script you are
running? add sleep 1 before you call cvsimport.

cheers,


martin
