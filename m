From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Fetch via http and proxy which requires authentication
Date: Tue, 4 Nov 2008 12:13:33 +0100
Message-ID: <4d8e3fd30811040313x44290557yecfedb2fbc8cad0b@mail.gmail.com>
References: <4d8e3fd30808272300g58d92dd8pd877d72805bc29c0@mail.gmail.com>
	 <4d8e3fd30808280313i70f572cfh9c14fbc2adbf5cea@mail.gmail.com>
	 <c94f8e120811030602p57007278p5a2c48ce7663282d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Dilip M" <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 12:14:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxJs1-0007bT-Jl
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 12:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbYKDLNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 06:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbYKDLNf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 06:13:35 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:40934 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbYKDLNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 06:13:34 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3208018rvb.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RRdFq1NJlEy4adxC+PKsSDjJBuwEU2XZy8q5Nctg9CY=;
        b=OYpQRzgy4eH1YHdwUbR/yZ59oG03dcm24a4W+74Lq2izkC6aSDmaD3rLjb3Oa1avVl
         W+ViMZy4XlEd8deYgW6SwKNhVsk+PUNM/2MvGRNmfM+WH61hoaYydoskYeJVGejntqTr
         xJ8wxII4xCQmq9YTWTKW05i2qWqNI7+hDGC4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=thoxxeXDBpbzFzqtD0isiy8A3xm8HmQBot+fYfKH3PYxxnoRih/tdNQFRlijPnov6l
         MKeer5uQISi8B2O9zNmtF+tZL9oP7TX4+euU5Yn1uDO/sGWt6MBqrW6u7AuOcl5hLdxy
         JFncJfIxLCIVLWsLZB3TZhCQefL6qzQGZsQ1w=
Received: by 10.142.237.19 with SMTP id k19mr704890wfh.235.1225797213487;
        Tue, 04 Nov 2008 03:13:33 -0800 (PST)
Received: by 10.142.240.8 with HTTP; Tue, 4 Nov 2008 03:13:33 -0800 (PST)
In-Reply-To: <c94f8e120811030602p57007278p5a2c48ce7663282d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100068>

On Mon, Nov 3, 2008 at 3:02 PM, Dilip M <dilipm79@gmail.com> wrote:
> On Thu, Aug 28, 2008 at 3:43 PM, Paolo Ciarrocchi
> <paolo.ciarrocchi@gmail.com> wrote:
>>> Hi all,
>>> i'm looking for a way to use git behind a corporate proxy which
>>> requires authentication.
>>> i just need to be able to fetch/pull via http.
>>> i'm using git on a win xp box.
>>> Any hint?
>>
>> Yes, google for  http_proxy ;-)
>>
>> export http_proxy=http://host:port
>> git clone http://username:password@giturl
>
> I tried setting, export http_proxy=http://<user>:<password>@host:port
>
> But git clone failed!
>
> $git clone http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git git
> clone http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Initialized empty Git repository in /home/dilipm/bin/linux-2.6/.git/
> fatal:
> http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/info/refs
> download error - The requested file was not found
>
> What may the problem?  How can debug....

Works for me:
$ git version
git version 1.6.0.2.1172.ga5ed0

I set in the Environment Variables panel:

Variable          Value
http_proxy      http://ip_of_my_proxy

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
