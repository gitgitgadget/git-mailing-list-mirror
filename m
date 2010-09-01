From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] merge: Make '--log' an integer option for number
 of shortlog entries
Date: Wed, 1 Sep 2010 09:52:50 +0530
Message-ID: <20100901042247.GB26496@kytes>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
 <1283226800-28980-1-git-send-email-artagnon@gmail.com>
 <20100831143236.GC2315@burratino>
 <7vzkw2abpz.fsf@alter.siamese.dyndns.org>
 <20100831191324.GA27381@kytes>
 <7vfwxua79a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 06:25:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqesk-0006nD-Md
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 06:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199Ab0IAEY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 00:24:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60699 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab0IAEYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 00:24:55 -0400
Received: by iwn5 with SMTP id 5so6450099iwn.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=89PmsfubYpp1VAMurjuNpvpAFeMiyCsgZ5BgDJITNig=;
        b=XXFnVpyczD7k6NmXo4rtr7/ghO95O4sCsQJI94tWlLgiuVKyA1K7Y6LFW3IRnYTi2v
         GhnPtZlClRtiXhnnZsRNNfP91cis0HDgyqGqFHNkypf1RmiUbZwnCzcqUfqSPS6p/QQt
         VrXtIycK49G7FGt/i3HnYYJQD6z3b2jisfiCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oPUUNeUDFz/6eSSEJKi8NNJUYoi/rSXNUHt4Cthw2HlSdeqRh3jCFEGxAiQ/UzPDZl
         aNAqsgToKw80bsuh77WuWr7ygG8R4/aUqaYS3JlbG2qL/hPuKXMc/8CN4SXBcwPewyIV
         BdTa+8e5dBWDrG2jgwZ8heOOIorrZbCC9kvYc=
Received: by 10.231.150.7 with SMTP id w7mr8462950ibv.14.1283315094805;
        Tue, 31 Aug 2010 21:24:54 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n20sm9577130ibe.5.2010.08.31.21.24.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 21:24:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwxua79a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155015>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > It's a little asymmetric- the program won't error out when 'merge.log'
> > is set to -1.
> 
> And what is the reason you do not want to diagnose that as an error?

Oh, I'm just saying I'm not sure what the behavior should be. Okay- if
erroring out is the desired result, I'll fixup and re-roll in a bit.

-- Ram
