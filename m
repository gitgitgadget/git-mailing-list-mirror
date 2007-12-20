From: Thomas Harning <harningt@gmail.com>
Subject: Re: Git-to-svn convert
Date: Thu, 20 Dec 2007 10:12:05 -0500
Message-ID: <476A8645.7080007@gmail.com>
References: <476997C1.2080506@gmail.com>	 <46a038f90712191554t2c1adc79s7948c7002c145143@mail.gmail.com> <1198128721.24580.78.camel@hippy.mcmillan.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew McMillan <andrew@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5N7I-0002Pr-6v
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 16:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849AbXLTPO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 10:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbXLTPO4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 10:14:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:60570 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbXLTPOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 10:14:54 -0500
Received: by wx-out-0506.google.com with SMTP id h31so12913wxd.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 07:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=hHtkq1uzhUnXYzHhCZVhpFV++H23WaHXIHBhyBkjfqQ=;
        b=wL2kaKwEbjhE+WnZLbzEjj/MezpsQ9aQAbCW//DtR6XVslvWIn+6mKSHvJONgDABPSx9JHhIM27QxGqDpOU4amaNN0U7ddMwfLcYt64LGZnKJ3B6gnIRrGMAlogEZth5VQ8DBk+dk0kX8fMAUdM3fEV7UX+dhgbtUFrc4kOy7mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fX1+5xMQSB1PFT7Aa7FnBQvR+82JHb/1kvr6/zfQ7GT5QNC5wKoiu0bzX7SXmMYcTcQqI/vHHr8QWPjyn+EpqaCYhyVtgNvaXyyju1JuYUGJsowmT/GWAb/ynP1tRvBmtbxO8mPIsVwV293g6bnFYcoICQqhPAFL6kd47G1rBDA=
Received: by 10.70.40.5 with SMTP id n5mr21016wxn.55.1198163693370;
        Thu, 20 Dec 2007 07:14:53 -0800 (PST)
Received: from ?192.168.24.40? ( [149.164.193.61])
        by mx.google.com with ESMTPS id i17sm27737813wxd.2007.12.20.07.14.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Dec 2007 07:14:52 -0800 (PST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
In-Reply-To: <1198128721.24580.78.camel@hippy.mcmillan.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69007>

Andrew McMillan wrote:
> My code is an embarrasingly ugly, gruesome hack, but it (sort of)
> works...
>
> I use it to keep the SVN and CVS trees up to date on Sourceforge for
> DAViCal ( http://rscds.sf.net/ ) from the Git tree.
>
> Cheers,
> 					Andrew
Where might I find the code?  I checked out git.catalyst.net.nz ... but 
I couldn't find anything that seemed to be a sync tool...  I figure I'd 
give it a try before manually rebasing or progressively cherry-picking a 
new tree...
