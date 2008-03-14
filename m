From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: How about cherry-pick --squash?
Date: Fri, 14 Mar 2008 23:32:08 +0800
Message-ID: <46dff0320803140832x596047c0yb5c81f0f9b8d186d@mail.gmail.com>
References: <46dff0320803140815q5a342f5fjdde02c6b5fde4e5f@mail.gmail.com>
	 <BAYC1-PASMTP015BC6B5B35F790E097CBEAE0A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:33:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBtu-0004n3-TT
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbYCNPcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbYCNPcP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:32:15 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:3292 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbYCNPcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:32:14 -0400
Received: by gv-out-0910.google.com with SMTP id s4so811075gve.37
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=D75VgPIjrj0ktbWY6G+f1HWe2iJ0rt7ZJksk2V2hIzc=;
        b=NoDG7WgDlo/uPdwxGFJlzXSZxDN7/NJXS7L+xZ1VeGnFD9N8MI31OkOX4SEqdPc6LmvU8PLMZmv+//JWoOd/w8hNAtMP827qU0PocKwoXjAnTNiqQ1aAW/d8rE+pHpy4arOnpNf7+xULSmcRkYM6BTgPqStieTaMibR2bzIGceg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kj8NDyWblEGHoU/vv/7wCd8fTVg1cFqtbDU0nvxUF6u7vkm1f8jMWAZ7WT2YHvP+qRV5yqag8T4plmTpujOW/wUR/SAAQhI8N1MoTn7TxNcSmS9/eT2+3qsZkbSO0bemYIiM5BJPYWVoH6i7+VTx8uJCaW1XmWxqnLYH+x8l9V4=
Received: by 10.150.192.7 with SMTP id p7mr6410336ybf.21.1205508728741;
        Fri, 14 Mar 2008 08:32:08 -0700 (PDT)
Received: by 10.151.14.4 with HTTP; Fri, 14 Mar 2008 08:32:08 -0700 (PDT)
In-Reply-To: <BAYC1-PASMTP015BC6B5B35F790E097CBEAE0A0@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77246>

On Fri, Mar 14, 2008 at 11:25 PM, Sean <seanlkml@sympatico.ca> wrote:
> On Fri, 14 Mar 2008 23:15:32 +0800
>  "Ping Yin" <pkufranky@gmail.com> wrote:
>
>
>  There is an easier way:
>
>  $  git cherry-pick -n <sha1>
>  $  git commit -a --amend
>
Thanks, it's simpler.



-- 
Ping Yin
