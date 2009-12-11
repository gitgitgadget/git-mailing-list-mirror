From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: git svn fetch loses data
Date: Fri, 11 Dec 2009 09:32:26 +0100
Message-ID: <7d4f41f50912110032kd1990f9y9bb856576fc0437a@mail.gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com>
	 <200911151433.54797.trast@student.ethz.ch>
	 <4B005C14.8090607@gmail.com>
	 <200911152152.01513.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Johan 't Hart" <johanthart@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 11 09:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ0vY-0001KL-QO
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 09:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934914AbZLKIcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 03:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934907AbZLKIcW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 03:32:22 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:52513 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934869AbZLKIcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 03:32:20 -0500
Received: by gxk4 with SMTP id 4so844730gxk.8
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SuE18eQNEa+nTLn8eLqwM9z24r2XpvoJGmyOYOl+cg0=;
        b=f3S8X0u/FLXQEYqxgqmunOaCGllShkBPAayyrrLYP7QLPBZag9Oo/swdDSx/Nr7Mk9
         97mt8L4P+n7cQyWqPhdO4zyX8oiSElTAd8epZa1FxzribeWH7iEBVbUIJodCm7sg2fpF
         dycD2fmpkceJXeTovoMtxb6+xPNZZYBzxvw04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wLRrMnTO1+N87AwrYjntZ284ZeFCJthA+QSnimrQ+CQYX2YF0nTNEUqC8eYhSaDtWU
         l6u6nX4CNbBBU6jM1P3+Sr2snue5ynHwefXRnuUqe5rIBroPJXZpZK1LxAiL3afiUjpQ
         S1aPWVNlSHvCpKo57+Ty1LC2CY1AC3TrP2YbA=
Received: by 10.91.161.31 with SMTP id n31mr1355653ago.29.1260520346436; Fri, 
	11 Dec 2009 00:32:26 -0800 (PST)
In-Reply-To: <200911152152.01513.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135074>

On Sun, Nov 15, 2009 at 9:52 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Johan 't Hart wrote:
>> I didn't even know you could also do
>> $ git rebase git-svn
>> Unless git-svn is a ref...
>
> You can't, but in git-svn's default configuration (without
> --stdlayout) the cloned SVN history is called refs/remotes/git-svn.

Thanks all; now it all works a lot more smoothly.

-- 
Victor Engmark
