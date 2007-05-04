From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Support ent:relative_path
Date: Fri, 4 May 2007 13:43:34 -0700
Message-ID: <56b7f5510705041343uc167f6djc6c60881fc4048b7@mail.gmail.com>
References: <463AE404.9060906@gmail.com> <20070504202613.GC4033@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 22:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk4cu-0001GB-B6
	for gcvg-git@gmane.org; Fri, 04 May 2007 22:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031554AbXEDUnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031556AbXEDUnh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 16:43:37 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:62009 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031554AbXEDUnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 16:43:35 -0400
Received: by nz-out-0506.google.com with SMTP id o1so987094nzf
        for <git@vger.kernel.org>; Fri, 04 May 2007 13:43:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tO2Onh2WtoPxoYmisnW8NmBcabU9xAPA8R5X62jMLY6MHhCfPLQ1To+bS42CxnH/0b4DF/yFbL01SHCVQOtfwlaNSJC5NaIIAeHvsaKsOpLhRSUkpM5IpAPxCn2vYRpmEU9Hk5QfmAvL1WT057jumO4u1+Q34yC1xl+piGYaHZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lG51z30giCr5Fs88ZtcDvh6g6QCpseiuLK0qSYpTOdikBH/X65RCttpxPJ/BeTX//YkgtpV2OIXc/owL8aa1hMkQxf9OU5ATq+0dGCOFxxH28w5MSmMYIaTN2PVsXJyMyWjYDMcapUgnSIkiZfdSA/8JoOx32dFSB41x9dwQOQg=
Received: by 10.114.36.1 with SMTP id j1mr1260184waj.1178311414691;
        Fri, 04 May 2007 13:43:34 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 13:43:34 -0700 (PDT)
In-Reply-To: <20070504202613.GC4033@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46214>

On 5/4/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Dana How, Fri, May 04, 2007 09:43:00 +0200:
> > +     if (!strcmp(var, "core.relativepaths")) {
> > +             assume_relative_paths = git_config_bool(var, value);
> > +             return 0;
> > +     }
> Still don't like it. What good is a syntax you cannot depend upon?

No worry.
Junio already squashed this,  and I agreed.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
