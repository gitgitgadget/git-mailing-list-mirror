From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 13:14:52 +0000
Message-ID: <200701231314.53361.andyparkins@gmail.com>
References: <200701231259.27719.andyparkins@gmail.com> <45B6076F.5060503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jan 23 14:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9LUg-0005Zw-Ej
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbXAWNPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbXAWNPA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:15:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:55532 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965012AbXAWNO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 08:14:59 -0500
Received: by nf-out-0910.google.com with SMTP id o25so228083nfa
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 05:14:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ihAlbUtrlU9esr99TDgJwBQz9ZHTXSwyj10eXmSMJFI+8TnWuyXbMZeKv/IMlSKkyLCNIqg/P+EX75gy5sbPRF/3Nln+17sHILdWac+VYyI1RRu9mfgQEKs3ZGHBtC9OCGKO+/wmS/AV5GIziI3ecUecWgNTmdrg8d+TelZToBw=
Received: by 10.49.26.18 with SMTP id d18mr1080820nfj.1169558096980;
        Tue, 23 Jan 2007 05:14:56 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id o53sm2514405nfa.2007.01.23.05.14.55;
        Tue, 23 Jan 2007 05:14:55 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <45B6076F.5060503@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37512>

On Tuesday 2007 January 23 13:02, Andreas Ericsson wrote:

> > Why does the reflog directory .git/logs need to store the refs/
> > directory? Aren't /all/ the refs under "refs/" these days?
>
> No. HEAD isn't, nor is ORIG_HEAD, and possibly others.

They're all special cases aren't they?  They are symrefs.  I don't think they 
are reflogged at all (they certainly don't appear in my .git/logs directory.

Perhaps I should rephrase... aren't /all/ the logged refs under "refs/" these 
days?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
