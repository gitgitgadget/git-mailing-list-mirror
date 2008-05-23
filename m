From: Thomas Harning <harningt@gmail.com>
Subject: Re: git-svn: commit all changes as one svn revision?
Date: Fri, 23 May 2008 12:22:12 -0400
Message-ID: <E99FAF46-DD7F-4A3F-B238-E428D129AF50@gmail.com>
References: <9af502e50805230908t76c9b26exd36cfb6d0f1a9bcf@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 18:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jza2v-000514-MU
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 18:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbYEWQWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 12:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYEWQWR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 12:22:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:4412 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYEWQWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 12:22:17 -0400
Received: by wx-out-0506.google.com with SMTP id h29so560332wxd.4
        for <git@vger.kernel.org>; Fri, 23 May 2008 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=dIOioAw60zl2hyz/4Z2wU2fJuCQXGDLcPfQSyeU9OFw=;
        b=ufpwBeF2zL+0KEkBDyxZEf86ktaR5bk2IpOJY9YTbWLTt86fVopn34oWXf9OtF10ffv1/92TezRhGOi6Cfe4vyUdtDVtKYzaum3zKJIlgrfN2R7H12GIcMIcUdePUSFe0wcbTHmg3QYjEkwCu4tI2AK6IlFd+++nij778tX2WoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=p+ccx5rIPuErA9QhBXVOlw/o4W6FfSqdANiHNWPvNX1FvQWfGFSuHOGsvo1dOg/l0o5vL+jioGjpbimpJAUppX4lZ/mjEJmFAW1OQp8ckEGDN3Z0no8t8aGqSyhRiKcqcZieRDZn1GMypsXYK9PtUI0xhC9Ps4bhHvjcl+hGCEg=
Received: by 10.115.60.1 with SMTP id n1mr1964120wak.181.1211559735510;
        Fri, 23 May 2008 09:22:15 -0700 (PDT)
Received: from ?10.0.0.2? ( [149.164.193.61])
        by mx.google.com with ESMTPS id 4sm8526170yxq.8.2008.05.23.09.22.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 09:22:14 -0700 (PDT)
In-Reply-To: <9af502e50805230908t76c9b26exd36cfb6d0f1a9bcf@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82720>

On May 23, 2008, at 12:08 PM, Robert Anderson wrote:
> I make a bunch of git commits developing something that was checked
> out from a svn repo using git-svn.  I want to commit all the changes
> since my last dcommit as one revision, rather than having each git
> commit checked in separately, as dcommit behaves.
>
> Is there a way to do this?
git-svn dcommit -m
  (IIRR)
