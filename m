From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Wrong code on master
Date: Sat, 24 Dec 2011 06:49:29 +0100
Message-ID: <op.v6zbsrvi0aolir@keputer>
References: <36BFCDA4-8249-4965-877F-FFC9EA65C7EE@memoryties.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Jonathan Duncan" <jonathan@memoryties.com>
X-From: git-owner@vger.kernel.org Sat Dec 24 06:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReKUE-0007Rg-Nv
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 06:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab1LXFte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 00:49:34 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61433 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab1LXFtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 00:49:33 -0500
Received: by eekc4 with SMTP id c4so9879080eek.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 21:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=XbtxE9vEPrR9IU0eygbhj7HQCIrmwupTeNP+crsXYtk=;
        b=GSc/1GZaSYoAmkeQtNPTh1AiWAlrL01dLgByQUn1QthluzxVaMu4nPXgb5tpGGL6XG
         jYRCU7VjkJXxMA9+Q9BGTYTFRX6jnKbUyYPLD/HSJtgTM76fnc2MYnUeZ/wLJjvSEBDu
         beLUdNtFGsnh1u74IYLR8KtjQyib+rpBP8jDw=
Received: by 10.213.19.73 with SMTP id z9mr4810076eba.41.1324705772265;
        Fri, 23 Dec 2011 21:49:32 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id a60sm58113821eeb.4.2011.12.23.21.49.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Dec 2011 21:49:31 -0800 (PST)
In-Reply-To: <36BFCDA4-8249-4965-877F-FFC9EA65C7EE@memoryties.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187654>

On Sat, 24 Dec 2011 06:09:06 +0100, Jonathan Duncan  
<jonathan@memoryties.com> wrote:

> I have a developer that committed code that should have been on a  
> branch.  I have created a branch now and locally my master branch is  
> good to go.  However, when I try to push it conflicts, of course,  
> because the repo still wants me to pull the changes and merge them to my  
> master.
>
> The new code from the other developer will eventually be used, but we  
> were not ready for it to be on "master" yet.  I need to push my own code  
> out before that other code gets used.
>
> Will I really have to pull and merge the code to master and then  
> revert?  I have been googling all day, trying to figure out the best way  
> to do this and in the process I fear I have made a mess of my repo.  I  
> have been using git long enough to be dangerous to myself.

Well, the proper way is to revert the commits. That won't result in all  
other developers having to deal with a force-updated branch. If you can  
deal with it you can always

$ git push origin +branch

but I wouldn't consider that a nice thing to do.
