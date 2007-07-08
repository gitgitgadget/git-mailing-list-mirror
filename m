From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG in 'git log --parents'
Date: Sun, 8 Jul 2007 11:32:01 +0200
Message-ID: <e5bfff550707080232q3e27581t45c0e4c5a1ea3b0f@mail.gmail.com>
References: <e5bfff550707070249i6f3f7288uce1f922686f6e14d@mail.gmail.com>
	 <7vps348qzi.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707070314q3b78ac65p9a8ff3130a7bfaef@mail.gmail.com>
	 <e5bfff550707071517o776db380v9f3a68c3e46d9d3c@mail.gmail.com>
	 <7vodin2unr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 11:32:21 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7T7t-0004UM-Ji
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 11:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbXGHJcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 05:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbXGHJcE
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 05:32:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:44335 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbXGHJcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 05:32:02 -0400
Received: by wa-out-1112.google.com with SMTP id v27so962937wah
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 02:32:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mv1f4+iAXSExFs7wlQJP/aDY0bsBwJsvQHkNWl7e2hOyHtJuLV/CZDjp5reuI4tBixMA7SI6SvtpUQvWuduleFYqy23M8IOIATgpgkiAlrkTBUKPrGprHqyRj0wuZwtNqEfl90RuJ/pAPETeQVCFdlv1upHHoVdXRP9UfH3+EC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VxVCpUjMKG7v3//NyP9drtweCfjVDknVntu3Bo8W/dFEp0OYxrzTT/YUuMzMhz8cf93DYTmtGz6VY/4kVVkG6XsisfYrnQoQtSFWxqwrTlR4F/B/r/jUEwAINZGDA5s818hPN35Qcf28ldduSxyuvQ0BTDeU0pt/wO7ZNnTnwHw=
Received: by 10.114.15.1 with SMTP id 1mr2147509wao.1183887121042;
        Sun, 08 Jul 2007 02:32:01 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 8 Jul 2007 02:32:01 -0700 (PDT)
In-Reply-To: <7vodin2unr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51871>

On 7/8/07, Junio C Hamano <gitster@pobox.com> wrote:
> Match "log --parent" output to "rev-list --parent" output.
>

Thanks. It works for me.
