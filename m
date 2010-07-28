From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Possible feature request for merge and pull
Date: Wed, 28 Jul 2010 16:49:11 -0400
Message-ID: <AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com> 
	<AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bradley Wagner <bradley.wagner@hannonhill.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 22:49:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeDZK-0001SN-D4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 22:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab0G1Utd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 16:49:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57891 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0G1Utc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 16:49:32 -0400
Received: by wyf19 with SMTP id 19so4546041wyf.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0lAxkrYhsGu1FeusXd4E9vauqcCFIZrJOUybVqCJpUQ=;
        b=bKEEyXl0aDiGiTFdL9kY1q93Qw+ZdKxzIyIBGBZR18qmFAWhXygqlwPzvX0VfzSMkl
         6CJkLJyg03QscwWZWzhkmT7pbOC15XLG0c49Xk+IpoW6TUSe0bJMqrXZTYnVOC7830wl
         QoaUCLYmgAtwKEnZYPcRzKH6yT/LhDLIMgJ1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WCXZYc551lydx/MKF0ijI8kiPYMc7NAnTGo8xuzpHPXSU/MUiHRF72/an65QeseDFe
         ESVhVcqry5w1RIw+y+en1ByPRu1niTrQlJ8/9xKI5jrLrttz6OR8RlplZhha+URD4/wl
         E8G2+mJX0Naa9OSUWNS+jhADpaOs2qFA7iJls=
Received: by 10.216.169.80 with SMTP id m58mr11152479wel.79.1280350171256; 
	Wed, 28 Jul 2010 13:49:31 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 28 Jul 2010 13:49:11 -0700 (PDT)
In-Reply-To: <AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152119>

On Wed, Jul 28, 2010 at 3:34 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jul 28, 2010 at 01:24, Bradley Wagner
> <bradley.wagner@hannonhill.com> wrote:
>> I would love to be able to use the -m flag and --log together with g=
it
>> merge and pull to be able to create a custom commit message but also
>> include one-line summaries of each of the commits being merged/pulle=
d.
>
> This sort of thing has vaguely come up before, and it was mentioned
> that you can just use a small script that calls git-filter-branch or
> git-rebase -i.
>
> It's easy to rewrite the commits you just pulled, having some feature
> that e.g. adds a custom message to the beginning of each of them woul=
d
> just impose an artificial limitation and overlap with existing (and
> more powerful) functionality.

If I understand correctly, the request is not to rewrite the pulled
commits, but just to produce a nice message in the newly-created merge
commit.

It sounds like --log and -m are currently incompatible, in that -m
overrides --log, and that's not the desired behaviour.  Bradley: this
is probably a relatively easy fix to make, in case you're looking to
get into some git hacking. :)

Have fun,

Avery
