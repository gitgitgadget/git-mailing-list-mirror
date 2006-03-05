From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: any problems with new branch of gitk?
Date: Sun, 05 Mar 2006 15:16:06 -0800
Message-ID: <440B7136.2000809@gmail.com>
References: <17419.24973.402408.237865@cargo.ozlabs.ibm.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 00:16:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG2Sp-0004cA-Tn
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 00:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWCEXQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 18:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWCEXQd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 18:16:33 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:49181 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751918AbWCEXQc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 18:16:32 -0500
Received: by pproxy.gmail.com with SMTP id i75so656614pye
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 15:16:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rXOhj9jgCDRZ2K23ujA7LDSnE/R8YIjlNZxELA9rjcm0tM15mKjkulk41klYzBmQ0zDJHFxSZMb5L11RFbIolVAhx4YgiezU8zvhx75vv3q9Fpy3tscMwMGjzDTIMcpEirIuKxuMkwlkjDnBLHsqB462WIGY2jnh5Z+KtXsb0tM=
Received: by 10.35.50.9 with SMTP id c9mr201966pyk;
        Sun, 05 Mar 2006 15:16:31 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.71.142])
        by mx.gmail.com with ESMTP id 60sm1000576pyg.2006.03.05.15.16.30;
        Sun, 05 Mar 2006 15:16:31 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17419.24973.402408.237865@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17249>

Paul Mackerras wrote:
> I'm planning to pull the `new' branch of the gitk repository into the
> master branch, making the new version of gitk the standard version
> that will go into the git.git repository.  As far as I know the new
> version does everything the old version does.  Does anyone know of any
> problems with the new gitk that weren't in the old one?

I don't know if the old version has this problem but the new version 
does not have a "busy" pointer while it's waiting for a merge diff. Take 
a look at the ACPI mega(octo)pus merge that happened in January.
