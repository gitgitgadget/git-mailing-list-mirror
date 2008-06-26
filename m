From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 12:51:58 +0200
Message-ID: <46d6db660806260351w6082b5f9q6db3ef62552fafc4@mail.gmail.com>
References: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com>
	 <20080626094522.GA29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 12:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBp5z-0005ic-MK
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 12:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbYFZKv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 06:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754494AbYFZKv7
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 06:51:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:37997 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbYFZKv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 06:51:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1361577waf.23
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zBlw4ITEpjqg3Dii0bHQKHHN1NU8cgHem/ydhZLhtHg=;
        b=K15lNSDCcQ3MEGISlMNtj/CIU4Dzb/J90haOTNDs4eBI52KZpUG1syatm+3xYcORJ6
         a6HCQWfu4WKRLieD/7VlHDbMMQ2X94N5BgPKv1JtzGeQLSHZCtHG3kYU5PHK/E9YPUPs
         9/ESVR711MQBbUbz4Wjg66W8SOoyckMlqH+EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ur3SJCdM1Ln470EQFDyb3gLBvEmyonZvqxuMCrXBk80MFr7kqk8BTkTTOpwZlYb2cj
         /hCb5AkOCb2NXw8Nts8c9bSKl3jUGxo6lE3MsTid4VvGmg530BUKQgvMCQlHoxqTwcWa
         HmcQpwqUxbgMQilzvuUdOBgrDJqOAS4p4ggKc=
Received: by 10.114.184.7 with SMTP id h7mr6955225waf.183.1214477518177;
        Thu, 26 Jun 2008 03:51:58 -0700 (PDT)
Received: by 10.115.16.17 with HTTP; Thu, 26 Jun 2008 03:51:58 -0700 (PDT)
In-Reply-To: <20080626094522.GA29404@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86428>

On Thu, Jun 26, 2008 at 11:45 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, Jun 26, 2008 at 11:39:37AM +0200, Christian MICHON <christian.michon@gmail.com> wrote:
>> How would you do it, since merge will not merge if it cannot find a
>> common ancestor ?
>
> Did you try so?

yes I did. it was failing.

>
> If there are no conflicting paths then a simple
>
> git pull /path/to/other/repo.git master

pull = fetch + merge

maybe I was not fetching the objects properly.

>
> or similar should work.
>

your hint works fine. thanks!

I was starting considering rebasing the 2 repos on a common empty
commit (that would have been desperate)...

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
