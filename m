From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 11:46:25 +0200
Message-ID: <81b0412b0808290246j299371b0k7895308368266a01@mail.gmail.com>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
	 <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
	 <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0a9-0005nq-Ep
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYH2Jq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbYH2Jq1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:46:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:16898 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbYH2Jq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:46:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so804796rvb.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=z75pRiK227gMR4JMRqhk7anUtVxlyOPQyt4Wz5TrP+w=;
        b=RpxDKnWgXlb80xp11b25CDQqtkMgX8N5tjo8XT1kcWpajXljmg/QK5yA8aPOgjMUVV
         wv5sEcUltk1TARq0VQHwvTaZYkVCueuhneCcxKyWofe4eFzhfaDp7/+AHcGvo7uz23JC
         Wl0CaF+w8jd3jEmJ0LeyoRvMOAA6DHyMHzDEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JcZJVXJCb2BWHOHX9WghGiUU4TkTKzLz4zDT28OMXKTVbF828Kh8EX7AJUU1bMRNII
         rCsWVTXGgP3DAlMUZ5TITEUygTjC7yeX+oxUWegDLBLUNE1Ferp8VSJgsMDlLTDipcfN
         oLojTOtDe2Nr/TPUoL36QmM2C+6/MkcNsPg9k=
Received: by 10.115.50.5 with SMTP id c5mr2441114wak.60.1220003185604;
        Fri, 29 Aug 2008 02:46:25 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Fri, 29 Aug 2008 02:46:25 -0700 (PDT)
In-Reply-To: <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2008/8/29 Francis Moreau <francis.moro@gmail.com>:
> On Fri, Aug 29, 2008 at 11:27 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>>
>> $ rm .git/HEAD
>> $ echo ref: refs/heads/NEW-BRANCH-NAME > .git/HEAD
>> $ git commit
>>
>
> well, it looks pretty git internal hack thing to me.
>
> Shouldn't we add a new option to git-branch to do that, like:
>
>    $ git branch --detach <new-branch>
>

Dunno. I never needed that explicitly. What do you want to do with it?
