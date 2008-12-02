From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: more merge strategies : feature request
Date: Mon, 1 Dec 2008 21:49:08 -0500
Message-ID: <ee2a733e0812011849l1b319c96u9abbb4e8dd4f53ce@mail.gmail.com>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
	 <4933AC03.6050300@op5.se>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Caleb Cushing" <xenoterracide@gmail.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:50:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7LLM-0008SG-Sj
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbYLBCtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbYLBCtM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:49:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:34322 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbYLBCtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:49:10 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1990997fgg.17
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PIP7Nexhp6QCaDr9Fd3CS8FONVR2r6DW0pkbk0H3/ew=;
        b=AOerNDHtBS/5WLQWj5njSWegjXyAdBeOW+dqfC6xtrFCr/PKXitQHeJdUBZNXpV0q+
         EartUM/ub/oICjEOGUlkvtTu07FPoNTY15lSFNe2UBCI78LsoO5dHlk1ZAuHuLL8XWU+
         Oxyp2d+CzD+oHAzRM+Us5rEF1InNnpM+Za/fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=nhLrzCgx/nLdu7zhZiaJGDsxJUMVrFCE1r38yTqB8bvY5Rg7sCPIY7ix+WQA5LoBtG
         1j76Gj10jGF7sgcZL59Mg+9kQrG6faQDdNK2tFhhsjPIWtRqNO6nM9S6PqhjcTL0BNwg
         Okp7pk8vfK9kcOMXEscc2PdBbnZxWVh2tlRRc=
Received: by 10.181.159.17 with SMTP id l17mr4135042bko.14.1228186149031;
        Mon, 01 Dec 2008 18:49:09 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Mon, 1 Dec 2008 18:49:08 -0800 (PST)
In-Reply-To: <4933AC03.6050300@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102115>

On 12/1/08, Andreas Ericsson <ae@op5.se> wrote:
> Caleb Cushing wrote:
>
> > conflict: this strategy would always resolve in a merge conflict
> > allowing you to use git mergetool to piece the files back together.
> >
> > no-overwrite: if a change from the branch being merged in would
> > overwrite something in the current branch don't merge it. (I think it
> > needs a better name)
> >

I guess that "no-overwrite" can be achieved by

git merge -s ours --no-commit

--Leo--
