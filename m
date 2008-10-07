From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: files missing after converting a cvs repository to git
Date: Tue, 7 Oct 2008 10:58:22 -0500
Message-ID: <799406d60810070858peb97434p9c9fb0c1128dc8e9@mail.gmail.com>
References: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com>
	 <48EAFCEF.8030907@op5.se> <gcfcrg$ubc$1@ger.gmane.org>
	 <48EB3E06.70100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnEyE-0002hf-Sv
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbYJGP6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbYJGP6Y
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:58:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:5358 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbYJGP6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 11:58:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3634429rvb.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0F/7e8jWrTHv998OnDFXtwCnvBmhGGBMlfGmnE9IAGU=;
        b=VHBGenWg4KzIaZaviCFG9GrpWar9epNW5fFVx3/alQt2FBFDsbPFhUyUQuckeQHtoG
         5FMnuquXLKwqcgTzkFMSbySVKnPMb1iPFeYkaEo/rR7ON8OOUt9pxviBH+XEiqi1va1+
         BJGmOaWzVUyMoz0eEAJ4r3w80n/QhKu33uvwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h27isJvY0Zjfwi/rxmirRP7/SM7fu9Mb6uZbv4hhxeZmRgWxA8KtIuvHV7Skyf+85k
         EKpYZZSW+7izgw7l7HOccr/hWaxEemxVhMarlS/8OddkmkGQ8lXfdv70UyEeCfUsx48y
         m7+fffcnciNhwjY/43Vz0UKcirRKelbSyljT4=
Received: by 10.141.75.17 with SMTP id c17mr4013551rvl.212.1223395102523;
        Tue, 07 Oct 2008 08:58:22 -0700 (PDT)
Received: by 10.141.28.18 with HTTP; Tue, 7 Oct 2008 08:58:22 -0700 (PDT)
In-Reply-To: <48EB3E06.70100@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97722>

On Tue, Oct 7, 2008 at 05:46, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Jakub Narebski wrote:

>>> cvs2svn is apparently quite good at getting even the weirdest history
>>> right. Perhaps you can try that and then running "git svn" on the
>>> resulting svn repo?
>>
>> cvs2svn has git output now (I think it is actually fast-import output)
>
> Correct.  See http://cvs2svn.tigris.org/cvs2git.html for more info.  I
> suggest using the trunk version of cvs2svn for conversions to git.
>
> Please note, however, that cvs2svn can only handle one-time conversions
> (i.e., not tracking a live CVS repository incrementally).

Thanks, I'll look into this for creating the final git repos.

Cheers

Adam
