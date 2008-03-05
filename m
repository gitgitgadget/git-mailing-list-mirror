From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Wed, 5 Mar 2008 15:16:23 +0800
Message-ID: <46dff0320803042316m1921f657wacf63a63491bbda0@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <7bfdc29a0803041917j16112e80uc0b21707bdfd3fe@mail.gmail.com>
	 <46dff0320803042315t2d89eb6fl325b4b2ef8ddbc44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 08:17:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWnsB-0005cs-MV
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 08:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYCEHQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 02:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbYCEHQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 02:16:28 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:46880 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbYCEHQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 02:16:27 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1693757tif.23
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 23:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bDPy1qW26mM+VtKOiVGpYfJtTm6d8mpV7IXB272c9RE=;
        b=db4jcqYbnIRUmAi2bPb9mlp6FlLKxgHsqPZwSMxhOAO9odRBNAItXyKOMJGv+j0rwZd74nzssVRqurUW76no57RHkhvVrh3ChieCNpJZghxaqWXJnIK6ryA3FigC3OQGxxAT6x5jMotLvXYbZxIuduBnYYD90vwiBf69Rcz25eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HPsBGOlmswcAqNoY7a/ggTIZYXEEUVJPqDi00Ll0bUuHujlTK9OP9HWxPt919RKZFg9BmUoE5RkpzPoZSivsGaBmKEJqLDvR05xUcescDA80cAnPofgAT+gcscWlEpSYoVoAE+a75ZfNSot3E8mTvRsXJzgzzMesPIcn8WHV51Q=
Received: by 10.150.154.6 with SMTP id b6mr983753ybe.64.1204701383280;
        Tue, 04 Mar 2008 23:16:23 -0800 (PST)
Received: by 10.150.218.21 with HTTP; Tue, 4 Mar 2008 23:16:23 -0800 (PST)
In-Reply-To: <46dff0320803042315t2d89eb6fl325b4b2ef8ddbc44@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76180>

On Wed, Mar 5, 2008 at 11:17 AM, Imran M Yousuf <imyousuf@gmail.com> wrote:
 > On Tue, Mar 4, 2008 at 10:04 PM, Ping Yin <pkufranky@gmail.com> wrote:

>  >  .gitmodules with with multiple level of indirection
 >  >  ------------------------------------------------------
 >  >  [submodule "service"]
 >  >    submodule = crawler
 >  >    submodule = search
 >  >  [submodule "crawler"]
 >  >    submodule = util
 >  >    submodule = imcrawter
 >  >  [submodule "search"]
 >  >    submodule = util
 >  >    submodule = imsearch

 >

>  At this point I have few questions - Will Service have its own tree
 >  besides its submodules?
 Now, service itself is not a submodule, and service is just a logical
 name for a group of moduels.


 >
 >  For your above example of .gitmodules hierarchy if I issue "git
 >  submodule init -m util", can you please explain what will be the
 >  outcome, i.e. which modules will be initialized.
 >
 Only the util module will be initialized using the path and url in
 submodule.util.{path,url}

 >
 >  --

>  Imran M Yousuf
 >  Entrepreneur & Software Engineer
 >  Smart IT Engineering
 >  Dhaka, Bangladesh
 >  Email: imran@smartitengineering.com
 >  Mobile: +880-1711402557
 >


-- 
Ping Yin
