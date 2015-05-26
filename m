From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 22:16:36 -0400
Message-ID: <CAJ80sauoB-quepDf2V=-WqewzJ_nN+ALA-z-vcL_4c8rObxpBg@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	<xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
	<xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com>
	<xmqqtwv09w84.fsf@gitster.dls.corp.google.com>
	<CAJ80sauXaaOjQhybxWVrHJpNQhHCKOd2Le1vFqEwBef6gYjqrQ@mail.gmail.com>
	<xmqq1ti49k1a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 04:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx4Q8-0003iS-8K
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 04:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbbEZCQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 22:16:38 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37513 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbEZCQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 22:16:37 -0400
Received: by wifw1 with SMTP id w1so13354611wif.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wgrtFwPn+zqpGGQDy3BTN3V/7EHAYFg/D7H+RwHcnvA=;
        b=1AcLYA/7O5/9cFzRPf2sna0vIqnG1W1uDAHmloJ5nqclQrNFkN2Ss6vqFHydhqAM9x
         HwaM4VyxHcewaMXzXSwpMPVA6cPbbwakCL0q59iNTlA8qLyoJtMu8ruU0ARvpW2yOHCg
         yr+JekqQoXV8QDyQsQ87yD+PiptDtFlpZ+F3rgSSVKNTgCwIRv2A9qIat3ZlVTtTrpqK
         +wfKNJcueLisrno5HLw8sb0eqvx4s8LM9xLxxreUd/aRWjqruzQL3amarhH6qYZNX3VR
         RzdBDcJInLleUc2lczd6r95hgEksxWI0ph53iowOIaIBOW2xruEqD+NSFouivCHUugUK
         ijPg==
X-Received: by 10.180.206.229 with SMTP id lr5mr36477397wic.86.1432606596459;
 Mon, 25 May 2015 19:16:36 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Mon, 25 May 2015 19:16:36 -0700 (PDT)
In-Reply-To: <xmqq1ti49k1a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269921>

On Mon, May 25, 2015 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Allen Hubbe <allenbh@gmail.com> writes:
>
>> Thanks for letting me know.  Are you still expecting v6 from me then?
>> The other thing you asked for was a change in the documentation: just
>> mention the email programs' documentation, and describe the
>> exceptions.
>
> Could you fetch from me and then run:
>
>  $ git log --reverse -3 -p 6b733ee4ba330e1187017895b8426dd9171c33b8
>
> to see if you agree with the result?  That is what I queued on 'pu'
> for now with my fixups.

It looks good to me.  How would you like me to proceed?  I assume you
would like your patch on top of mine will stay, to use HOME instead of
tilde.  Or, would you like me to use HOME in my v6, too?

Should I send you v6 like v5, but with the documentation fixed, or
would you now prefer a separate patch on top of that to fix the
documentation?  I can do either, and you would be welcome to
rebase/fixup the second patch into the earlier one with my sign off.

>
> We have not heard from Eric on this round yet, so he (and others)
> may have further input, but as far as I am concerned, that one
> looked more or less ready to be merged down to 'next', except for
> the documentation part, which I haven't had a chance to look at the
> results and may need further AsciiDoc mark-up fixes.
>
> Thanks.
