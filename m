From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git push failure with update hook success
Date: Thu, 8 Mar 2007 10:04:30 +0000
Message-ID: <200703081004.32666.andyparkins@gmail.com>
References: <17902.59497.831409.218529@lisa.zopyra.com> <200703080922.54978.andyparkins@gmail.com> <20070308092809.GE30289@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFUL-00087d-5W
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 11:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030630AbXCHKEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 05:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbXCHKEi
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 05:04:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:44129 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030630AbXCHKEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 05:04:37 -0500
Received: by nf-out-0910.google.com with SMTP id o25so575179nfa
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 02:04:36 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uQJGqG0PhvwHKZcoJfhizXz8Tpq+8PxWrl/xIqGrOlHvUZOImwL1N70e8wdMbYgKridRVbfG7dYotG/qIqR4Fzj8fmIVpNVBCZpdIMpVCkL9iIkGQazb+VPtekWR0Jd+tAon2odIBknfaJddNhSwc0nEc2w9S8F3fzFKLdhv+oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Guiz+ID/GRT+4nLtwMwhzr1JwBSuYE7HP7WJ9Bmr+Ft9ooMjZaEKaw74nBm9jRvAD4c/wk1fEVSfCAm+Uy2xbC3XHCSnYWxztMjx8YoEGICecRDqTDIZCTqIj5nDmVC6DJ7aatnPOwIpjaisZeJcYEMO62q5X+3f9fNGNskM4eI=
Received: by 10.82.107.15 with SMTP id f15mr348100buc.1173348276245;
        Thu, 08 Mar 2007 02:04:36 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id n22sm4556627nfc.2007.03.08.02.04.34;
        Thu, 08 Mar 2007 02:04:35 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070308092809.GE30289@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41731>

On Thursday 2007 March 08 09:28, Shawn O. Pearce wrote:
> Andy Parkins <andyparkins@gmail.com> wrote:
> > Without adding some nasty switches to git-rev-list
> > (like --all-except-this-branch), I can't see how the post-update hook
> > could ever send emails with the necessary amount of detail.
>
> Which is why `master` now has support for a post-receive hook,
> that has the magic three parameters.  ;-)

It still won't work - what about the 

 git-rev-list --not --all

Problem?

By the time that hook runs the master ref (for example) has changed, 
so "--not --all" includes the new revisions, and you get no output.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
