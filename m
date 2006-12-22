From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 08:41:44 +0000
Message-ID: <200612220841.46016.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 09:41:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfyS-0000EL-Ss
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945967AbWLVIlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945987AbWLVIlu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:41:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:30073 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945967AbWLVIlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:41:49 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3363371nfa
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 00:41:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fwKNv/IWAADIktq4BpEZ5QMpuA+yE1b1rhQOtGK4n+hxWrhekciOWDDDiUhYGRc/xwXmJqXDf2EFfdEr8iw51i7BbUxz8vO7wvMhNcn5igq6KGvhNcI040gMwcGKM3pMEUmRci7FFG68MGfgGxODQo0ZQimjUXjrqnaUqzN9deQ=
Received: by 10.49.49.4 with SMTP id b4mr11703278nfk.1166776908242;
        Fri, 22 Dec 2006 00:41:48 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id l22sm43275419nfc.2006.12.22.00.41.47;
        Fri, 22 Dec 2006 00:41:47 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35149>

On Thursday 2006 December 21 22:17, Nicolas Pitre wrote:

Sorry Alan; I thought it was your bug - it wasn't...

> $ git branch -r
> * master
>   origin/HEAD
>   origin/html
>   origin/maint
>   origin/man
>   origin/master
>   origin/next
>   origin/pu
>   origin/todo

I'm trying to track down why "master" is being shown in this case"; would it 
be possible to show me the output of

$ tree .git/refs/heads .git/refs/remotes

As I am having trouble reproducing this error.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
