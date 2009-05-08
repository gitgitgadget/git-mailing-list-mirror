From: Dan Fairs <dan.fairs@gmail.com>
Subject: Re: Problem with local branches and git svn rebase
Date: Fri, 8 May 2009 15:41:48 +0100
Message-ID: <BE627AFF-29EA-48E7-A91F-40B29FF36AF5@gmail.com>
References: <08FCF5E0-A2AA-4F23-9C23-E8F823AF2546@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 16:45:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2RH1-0006GQ-Lk
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 16:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZEHOlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 10:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbZEHOlx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 10:41:53 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:45488 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbZEHOlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 10:41:52 -0400
Received: by ewy24 with SMTP id 24so1865855ewy.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=J2Auo3L5pg1MdBEMCr14cXyM90KbeisrRXzH1x/qKCs=;
        b=raMUQCdJvQ7fVaea/OqyqgQXsaW2TDRWxPMZG/jyHvqDRBCaqDIg6KaeMxGNSkgGGk
         fygE0bi6fbCq1YbkM0Xy/DDtyFaEZNhUuhBRHqvK4XDdEps0+8kKaSdYW4VXIocJqPFL
         ONSTnqOv6S5F79wchOuDRjOzzLoMPdjbyZxaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=W8cY/Avmt/3CLgmUVoqltEv2gCnUSCx+GUj2SG5S7CwgoF4ZwnBrtiqluejTWUMOny
         ry9QKJ/EhR6/BPF2zt4FclwfLvj5ozxgBVY8SPyQDzj5XoUabVkaIab7Oja69bhD2B+M
         q6w4CG5aUBfc/Qbry2hq+tCZgZiT4XLfVyQBQ=
Received: by 10.216.17.212 with SMTP id j62mr1576235wej.132.1241793712071;
        Fri, 08 May 2009 07:41:52 -0700 (PDT)
Received: from ?192.168.87.36? (bristol.offices.netsight.co.uk [213.133.64.253])
        by mx.google.com with ESMTPS id p10sm2511512gvf.4.2009.05.08.07.41.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 07:41:51 -0700 (PDT)
In-Reply-To: <08FCF5E0-A2AA-4F23-9C23-E8F823AF2546@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118609>

> I'm experiencing a problem with local branches and the git svn  
> rebase command. I'm using git 1.5.5.1. Basically, I can no longer  
> 'git svn rebase'.


For the benefit of the archive, a git rebase --abort on the 'work'  
branch fixed the issue, despite giving a 'No rebase in progress?'  
message. Thanks to tvakah on #git.

Thanks
Dan

--
Dan Fairs <dan.fairs@gmail.com> | http://www.fezconsulting.com/
