From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] diffstat generation in hooks--update was passing "^baserev" to git-diff-tree
Date: Tue, 13 Feb 2007 18:34:34 +0000
Message-ID: <200702131834.36001.andyparkins@gmail.com>
References: <200702131424.21665.andyparkins@gmail.com> <Pine.LNX.4.64.0702130856580.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 19:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2X1-0006nO-Gn
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbXBMShc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbXBMShc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:37:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:46282 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbXBMShb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:37:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so392976nfa
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 10:37:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tSjjQ4t3XpD2fm9TcElH2Ix/MDOkvpCAT34tAcgAHickIt3UIGiQhisEVkpQmemVgtZiupvAMzHr/o//5v3o5Pr0iY0nVXmO8d9EH7PosokDsuAfsaRRUtApcNCmeQaNejM8E6c/D4rPonxqia2pqZij0A/lFsnCxx/Ag5EZMds=
Received: by 10.82.113.6 with SMTP id l6mr11765720buc.1171391850292;
        Tue, 13 Feb 2007 10:37:30 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 30sm12335361ugf.2007.02.13.10.37.27;
        Tue, 13 Feb 2007 10:37:27 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0702130856580.8424@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39577>

On Tuesday 2007, February 13, Linus Torvalds wrote:

> This is wrong.
>
> 	newrev ^baserev
>
> is right. The "not baserev" tells diff-tree that the baserev is the

Right.  It's all come back to me now you've explained it; I obviously 
understood it when I wrote it, but it leaked out in the interim :-).  I 
was surprised because I've been using the hook for ages and the output 
seemed right. :-)

Junio - please ignore this patch.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
