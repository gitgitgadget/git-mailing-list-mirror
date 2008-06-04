From: "Marvin Fraeman" <marvin.fraeman@gmail.com>
Subject: Re: How do I control the automated commit message on a merge?
Date: Tue, 3 Jun 2008 17:05:43 -0700
Message-ID: <bd2cb52a0806031705x7cc153bsc00e1a0198d6e7b5@mail.gmail.com>
References: <bd2cb52a0806031455r151303achf0424b5320bf2f07@mail.gmail.com>
	 <alpine.DEB.1.00.0806032350170.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 02:06:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3gWU-0008Ed-1R
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 02:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbYFDAFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 20:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYFDAFp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 20:05:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:24835 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbYFDAFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 20:05:45 -0400
Received: by ug-out-1314.google.com with SMTP id h2so197773ugf.16
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 17:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cz751r/7f9Hm+MrF8WghjgHvN/3tFYCkPgGtyvqEM3s=;
        b=GKKUR4HB/jbBCg6kXxrLq/HJxEdWSIndzVe52UbG8sTwVi5YV3XAYw/AIo/PmEmnth
         ZKb55hjR3lh43UKrUE1RdejR03caTYam8xgY6qQNWeL1zggH0cdAd+R/rslVflkoRdaY
         e2VaDaF5uDwLmIeP4rvhyda0xHNtXgEF2kUmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Yn03qE3Gl3Her8tOk9+G0X0XnDaHRGkAn+82JZ+sKPPqQdx6tAv3eq9maFXWUR19Bk
         h0wsatHiZV85lZ/8DghVwAJujfkRGiyV7hExqt2dHeZE1c0QMoXpbbOEwi8yA3XUPco0
         LiBMiuJklNP+Wa0Hl8cPTnOUiR4nvz3xjILlM=
Received: by 10.103.201.5 with SMTP id d5mr2162628muq.18.1212537943529;
        Tue, 03 Jun 2008 17:05:43 -0700 (PDT)
Received: by 10.103.214.18 with HTTP; Tue, 3 Jun 2008 17:05:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806032350170.13507@racer.site.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83733>

On Tue, Jun 3, 2008 at 3:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 3 Jun 2008, Marvin Fraeman wrote:
>
>> when Git does a merge (no conflicts), it auto-generates a commit message
>> like:
>>
>>         Merge branch 'master' of  /path/to/other/repo
>>
>> How can I change this so my required string gets written at the
>> beginning of the commit message.
>
> s/./?/

Where do I do the substitution in this case? I don't know where this
default commit message is coming from and where to intercept it. Are
you saying this is part of the post-merge hook or is that an
alternative solution?

Thank you
