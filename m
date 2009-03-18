From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Wed, 18 Mar 2009 17:11:25 -0400
Message-ID: <76718490903181411p743382f1qb053363f28a800b1@mail.gmail.com>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
	 <20090318005413.GC25454@coredump.intra.peff.net>
	 <49C0C769.8020401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Tom Preston-Werner <tom@github.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk34N-0006zw-TS
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbZCRVL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbZCRVL2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:11:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:3400 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbZCRVL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:11:27 -0400
Received: by rv-out-0506.google.com with SMTP id f9so189915rvb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JoB3QBYhbSMKd01kM/3Myb1p6jAWyUa1QsNOMbaHcfc=;
        b=e+qMOvhwp29Ls00Vu4irLlSi0QJ37UMGNMeLFyQwI6Bcm+zTVZElCU3z+uU/gK2EVx
         AlDRefNkltc4nU6GS7lVxj+Gn7bX5UOp0BU02ggl6pqUpheioW/bJ81JuroZS+NRptpM
         07vC3mDvsu+nNQf1OA0kpsy9buIsyc0nMqEUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BDahPTT8cO0GWJP3CMNZe85z0WxYlGPgStc25Knvodj/OtGYi9E+mem+92Amb8UzD/
         OMEFlfKxmJhvaQQWqPHiR9Q2tPxYmxX6fCea9UEuLnx+cME1YUo86gz86jx2EhjzQHo1
         UEnVQT01y57TAvq+ns2E69eGjwHml6ZBE/3qU=
Received: by 10.141.114.19 with SMTP id r19mr369885rvm.135.1237410685849; Wed, 
	18 Mar 2009 14:11:25 -0700 (PDT)
In-Reply-To: <49C0C769.8020401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113668>

On Wed, Mar 18, 2009 at 6:05 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> One might even argue that in case of ambiguities, checking out a
> detached head would be most appropriate. Really, why impose creation of
> certain local branches on a user at all, unless asked for? Detached
> heads are natural in git! But I don't really expect positive consensus
> on that one...

Shirley, you must be joking. :-)

I think there are two reasonable paths forward:

1) Address Jeff's concerns above so that the symref can be sent.
2) In lieu of (1), have clone at least warn that multiple branches
match and that it just picked one.

j.
