From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 01/12] git-grep: read config
Date: Thu, 24 Jul 2008 21:12:26 +0200
Message-ID: <bd6139dc0807241212x4904b7a6x5dc8fa84cca32e18@mail.gmail.com>
References: <20080723145535.GA29053@laptop>
	 <20080724171519.GA21043@sigill.intra.peff.net>
	 <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
	 <bd6139dc0807241153v5055e922p69a176b5b706f98e@mail.gmail.com>
	 <fcaeb9bf0807241203yd57e675j964594c501ce59a2@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM6Fk-0007kd-0A
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbYGXTM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYGXTM1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:12:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:28921 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbYGXTM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:12:26 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3607058wfd.4
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7qYQSq7zM/tSQCHy9SdKnuGGTsSfFzZBDAsyChkknrM=;
        b=dYOU9L6+VhfZdwwmuAhIWr4GLxbv6kI8rr6fsC1F0MHgrWUGFzsEM294LoK5yX8hhW
         LfikZC3c3Vfoo9G7pplycPFpgMHfb7qQ4abZCUJvVTmCKCYMH0eDj7yi5t0CB55MOQLS
         FTZ7uhNFzsX3bDx3S7dK7GpsgPtjPf9dEnnAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=FfkevfR4CKwBxNLsKannysWNtSPo/nerxkrN/ydq5j1v0Oby+3amyapWJmcmi3lHSz
         ukB8zB3NoOQ8WfAi9I9knKYHi/0SNH8719yxSbSX7XQ1W2qP/kaFqZeH9O4u5O2L9yXq
         WLeOopwg1GC5Vx9OjHVqRcm1AM42CibhZp3Jc=
Received: by 10.142.216.9 with SMTP id o9mr230518wfg.0.1216926746316;
        Thu, 24 Jul 2008 12:12:26 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Thu, 24 Jul 2008 12:12:26 -0700 (PDT)
In-Reply-To: <fcaeb9bf0807241203yd57e675j964594c501ce59a2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89946>

On Thu, Jul 24, 2008 at 9:03 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 7/25/08, Sverre Rabbelier <alturin@gmail.com> wrote:
>> On Thu, Jul 24, 2008 at 8:45 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>  >
>>
>>  Something went wrong replying here possibly? Or is it just me who is
>>  receiving empty messages? (At least the 3rd empty mail I see.)
>
> I blame gmail MTA or my name's having non-ascii chars in it. Combining
> those two, it produces base64-encoded messages, which are usually
> refused by vger.

Curiously enough, in the first mail there -are- non-asci characters in
your name, in the 'empty' mail there are non, instead the 'letter
decorations' were removed.

-- 
Cheers,

Sverre Rabbelier
