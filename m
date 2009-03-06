From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git push bash completion
Date: Thu, 5 Mar 2009 20:57:39 -0500
Message-ID: <76718490903051757j37511e2eq7f2bae26c1576f76@mail.gmail.com>
References: <fabb9a1e0903051430k5628fe26v4749360e026ac7d2@mail.gmail.com>
	 <200903060015.39834.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Mar 06 02:59:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfPLC-0004iB-5A
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 02:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbZCFB5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 20:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbZCFB5l
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 20:57:41 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:3311 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbZCFB5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 20:57:41 -0500
Received: by rv-out-0506.google.com with SMTP id g37so236380rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 17:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2GcOt3ppOzJ8czF+565xbj4iCg+Zd4X+pClh58zFS/g=;
        b=v/l5lF7e+KetiPwE2UYR4OopghEDLaXrVYUQUVpO8zUGuYS1cJalge2Ey5PPbl7lWU
         IFoO2HF/4lBpbOYdeihodnBuQS6WouLwQNNndXuNQDJgCEUWcwOGHZTQpQW8+jqPTtVf
         gFGb/NdNgirBzF042KMaK/J4YII4/hIgbdTMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VDnHYP4DPTz69NTJWEqftBHs6H26u2UVAHYjBUK+2nLvLeQ7OMN+JeL/DYW8hIa7V+
         IQi4ZCjtbndxW4bv0QJxnS3ghxcGJPp6DQrnJaah0YVrzEF4lrvncQIKMeq7Imhwfr8B
         ZLe57ikNmSlPDqsX1/RG3In6QcZDojbBEIqwM=
Received: by 10.141.100.15 with SMTP id c15mr963724rvm.222.1236304659572; Thu, 
	05 Mar 2009 17:57:39 -0800 (PST)
In-Reply-To: <200903060015.39834.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112368>

On Thu, Mar 5, 2009 at 6:15 PM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:

> Something similar happens with fetch and pull. They only complete the
> remote name, when exactly 2 words are existing on the command line
> ("git" and the subcommand) by: if [ "$COMP_CWORD" = 2 ]
>
> Doesn't seem right.

I'm working on a fix. I hope to have it out tonight for review.

j.
