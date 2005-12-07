From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: type_size_sort
Date: Tue, 6 Dec 2005 19:51:44 -0500
Message-ID: <118833cc0512061651y57ddcdc7pd26996b40c08d225@mail.gmail.com>
References: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
	 <439604DF.5010603@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 01:52:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjnXA-00033M-62
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVLGAvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVLGAvp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:51:45 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:61804 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964841AbVLGAvo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 19:51:44 -0500
Received: by wproxy.gmail.com with SMTP id 67so583262wri
        for <git@vger.kernel.org>; Tue, 06 Dec 2005 16:51:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Isr29rOJ+IotZXkQKrRK09H9iS1/4MdsvtqTXRmlcF5y8YySIvezP4FJP70qzNMgR7MhM/+LTnnb/lIqxUW2pj0FWrnk7wIJQiYclwjqVF9E0qNQwS+W/BDyaLATKmfGjZLeti9L/OieE+mfQtLf8J+85qjsT7OYvmOwQyzSgOU=
Received: by 10.65.145.9 with SMTP id x9mr1230698qbn;
        Tue, 06 Dec 2005 16:51:44 -0800 (PST)
Received: by 10.65.151.1 with HTTP; Tue, 6 Dec 2005 16:51:44 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <439604DF.5010603@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13312>

> It's perfectly correct. If the same list was to be passed to
> create_sorted_list() twice it will come out exactly the same the second
> time as it did the first. The only thing to remark on is that the return
> above could be written as below instead:
>
>         return a - b;

That is not what the part  of the standard I quoted says.  It very
clearly forbids the sorting function from depending on the pointers'
values.  I can even see an implementation actually using this
requirement.

And it is well known that some qsort implementations will do nasty
things if the sorting order is not consistent.  I've seen Perl core
dumps on that account, although that is a while ago.

M.
