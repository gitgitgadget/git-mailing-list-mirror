From: John Tapsell <johnflux@gmail.com>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 09:35:37 +0000
Message-ID: <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 10:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKs8-0005yV-E7
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 10:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbZCKJfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 05:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZCKJfj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 05:35:39 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:19474 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZCKJfj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 05:35:39 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3122203wfa.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EQNteG1h0PzT2cUv8lrbSfRic3q5u2iEduZLFq4KpKY=;
        b=LXZ89Gg/UNm7VBU/6HXJK7Kks6phf/almyQv28kW8OZ4PMzpGBHO+peubdNfd5dghL
         GxdVfCvRDc8g7hErpaOx7WYm/LcqVeaIWLQdbpD/IMPxxCUg9waBDhT66ZPs0z9ch1ig
         1XWl9Ef1WAsEx90ktHI3aosa2YHCZT28QsqsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jDUi4z/8xiWYDj9gRbh1wjYUarBHtoCXHGVEgaeAOqKmUnDaB6PEkhA/m53Y5p4h3V
         +ZH+AAcmGmYfcMfzAfA9psrB2PoQq5R3GE0uPBzruckK12ux1FlkZQ/AXjhcYnI5VtU7
         P8vE096T/GkwFGZLT1uiRwQAdHrvLUZCLxWYg=
Received: by 10.142.113.19 with SMTP id l19mr3596993wfc.10.1236764137363; Wed, 
	11 Mar 2009 02:35:37 -0700 (PDT)
In-Reply-To: <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112899>

2009/3/11 Ealdwulf Wuffinga <ealdwulf@googlemail.com>:
> On Tue, Mar 10, 2009 at 7:08 AM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>
>> I will try to have a look at the end of this week.
>> But do you want it to be integrated with Git or do you want it to be=
 an
>> independant project that works with many different version control s=
ystem?
>
> Hmm. Whatever works, I guess. On the one hand the code does seem
> naturally generic. On the other hand, it's good if users don't
> have to separately obtain an extra package to use it. Supposing that
> the algorithm proves useful, would the git project =C2=A0be okay with=
 an
> extra dependency, or would you want to integrate it? Right now it's i=
n
> python, which I understand is an obstacle to integration.

There used to be a dependency on python.  git-merge-recursive for
example, before it was converted to C.

mpmath might be the more annoying dependency - what functions do you
use from it?  Could they trivially be reimplemented?

John Tapsell
