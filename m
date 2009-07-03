From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Does CVS has a easy way to compare file with its previous version?
Date: Fri, 03 Jul 2009 08:39:33 +0200
Message-ID: <4A4DA7A5.7020303@gnu.org>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com> <m3hbxxx5jk.fsf@localhost.localdomain> <4A4A9FA5.7000009@gnu.org> <alpine.LFD.2.01.0906301813480.3605@localhost.localdomain> <loom.20090702T174843-784@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 08:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMcQy-000814-Vu
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 08:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbZGCGjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 02:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbZGCGjf
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 02:39:35 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33052 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZGCGje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 02:39:34 -0400
Received: by fxm18 with SMTP id 18so1947177fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 23:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=mMcG51dKrVjQNVjGfjgCTQoNAIuzo5wETHwpNv8zjjw=;
        b=JgsXcIMd5yjv0iAOqzt2AGmkROPaqbs7+98iKznKEZd+1i+NBejuTW8W++Azr8siiW
         3dBIgaovaGlJ29GygqNo9grFE4XPmms7zU+I4N0Ztp3n9AF/Fgq99FQvxUsag8RCn83j
         yJ87uvnrOd6t2gTmUsNgFxLKUFuXu6Ofx7K58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=B4jNWCTOZ0mYOLDT8bJZ128zfc662+0XtXOZkhlyzyWWdmDMz+cwpg0C3nXH1IP8Ku
         i2kdkcYz3qHktpUU7JZw3YCq/AvvA2egP1p5y3iCRaV+BgIjBBekP8PXRG1hh6estQMX
         dXBVY8KR57pWfdWDif4heuF70vnAhIZdw06Ao=
Received: by 10.102.219.8 with SMTP id r8mr545412mug.0.1246603176256;
        Thu, 02 Jul 2009 23:39:36 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id y2sm15578240mug.43.2009.07.02.23.39.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 23:39:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <loom.20090702T174843-784@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122686>

On 07/02/2009 08:04 PM, Eric Raible wrote:
> Isn't the first one incorrect because<file>  needs to be inside the backticks?
> git diff `git log -2 --pretty=format:%h<file>` --<file>
>
> And isn't the replacement incorrect also (the diffs are backwards)?
> git log --no-merges -p -R -1<file>

Yes and no.

Paolo
