From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Extracting a single commit or object
Date: Thu, 1 Jan 2009 23:06:54 +0100
Message-ID: <81b0412b0901011406n13eb2fbarbed613785d9896f4@mail.gmail.com>
References: <21223948.post@talk.nabble.com>
	 <20081230222106.GE29071@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: yitzhakbg <yitzhakbg@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 23:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIViE-000507-7j
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 23:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbZAAWG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 17:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZAAWG5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 17:06:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:18940 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbZAAWG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 17:06:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3090790wah.21
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eVSjuydc2wt4FGIBnJXXp8800nQ/d7YipPIRFfA6fOs=;
        b=qyT46+wj7kGZKJWVKq2+D/TUMEWsSLsc+bNt5/G3m2b1reqG86AtnVQltMwZ+8a1qU
         +d2Yh+3ui36pftv9Ycyz533OX1aFdel5bd8joKhziuXGSlcfpHNFyY7/PgMRMxy5SkRM
         l2NCIRBIquJWioVR7f43h5+cBnPfyZcg9EJPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LfmGl26rKEWjKWZx6AbxBG3ySb8xCRChhhcfqG0jbXrFe+m5UuzoyvWRbfiOWruQd/
         4y4M3pUkxy+c+ohrURDe46F1wVx9InDYHxk3uPSp4qqJFb7/LFtuwbe6OF/2OYSoUUOU
         nDE6xZdUN/++y+wPqY5RYp6ggV+Th9nEqlPt8=
Received: by 10.114.175.16 with SMTP id x16mr11393262wae.134.1230847614552;
        Thu, 01 Jan 2009 14:06:54 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Thu, 1 Jan 2009 14:06:54 -0800 (PST)
In-Reply-To: <20081230222106.GE29071@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104333>

2008/12/30 Shawn O. Pearce <spearce@spearce.org>:
> yitzhakbg <yitzhakbg@gmail.com> wrote:
>>
>> How would I extract a single commit from a repository by it's SHA1 (or any
>> other treeish)?
>> For that matter, how is any one single object extracted? Examples please.
>
> git cat-file $type $sha1
>

git cat-file -p $sha1
