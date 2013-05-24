From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 24 May 2013 10:58:29 -0400
Message-ID: <CABURp0qCOMJnQ=+p81eXLtj6+zujO=MsYODx8zR_cXjVXwV=HA@mail.gmail.com>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
 <1368793403-4642-3-git-send-email-artagnon@gmail.com> <7vfvxlw055.fsf@alter.siamese.dyndns.org>
 <7vsj1jzao7.fsf@alter.siamese.dyndns.org> <CALkWK0n+NTnO0_4jNuR3Z5qmA_=-Dux+gq8kNzAT4YLC12Z8uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 16:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UftSV-0006H8-OU
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 16:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500Ab3EXO6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 10:58:51 -0400
Received: from mail-vb0-f42.google.com ([209.85.212.42]:38002 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab3EXO6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 10:58:50 -0400
Received: by mail-vb0-f42.google.com with SMTP id w15so2784770vbf.1
        for <git@vger.kernel.org>; Fri, 24 May 2013 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aZzoduo2ZaNXRbUjrcCSn2zj8HhVbM6U0VJWJe+atts=;
        b=z1aNozcXqTvdBHF+tiy4Twec/VLJ3d4jQtgGRlGyiOcFNZItH9oA74fdVpL/WOBdeK
         aTa2cbK8sSNWawS9rUJbPrkYjnHY23W6OW0hA+2pY2ruW7RDCx9H0oTB9j5HwzOgM1t5
         QrgXyabbNZ9TgKrrQHtwbBH50NysGQ8HwGjLvdpOmNeoevwZEBdMZqloHFbhaPTpbFo/
         pr9SCk523Ufjiy3f9VOT39aTx3a3kxuDGwLSPEK/iRijylgo7hfkdcs14TWFmHZima5t
         U0ny7+qNe526c03vVqCL9DThrMWsqvI7CUEH8caA0/MQoCqMWTYh4ZY0dQ6NTgvJacbT
         czqA==
X-Received: by 10.52.90.202 with SMTP id by10mr7621980vdb.26.1369407529755;
 Fri, 24 May 2013 07:58:49 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Fri, 24 May 2013 07:58:29 -0700 (PDT)
In-Reply-To: <CALkWK0n+NTnO0_4jNuR3Z5qmA_=-Dux+gq8kNzAT4YLC12Z8uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225359>

On Fri, May 24, 2013 at 5:37 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>> [...]
>
> I agree with the other comments, and have made suitable changes.
> Let's review your block now.
>
>>         This transformation is used to find filepairs that represent
>>         two kinds of changes, and is controlled by the -S, -G and
>>         --pickaxe-all options.
>
> Why do you call this a "transformation"?  Is git log --author="foo" a
> transformation on the git-log output?  Then how is git log -Sfoo a
> transformation?
>
> Two kinds of changes controlled by three different options?  Isn't the
> original much clearer?

They are all three filters.  They transform the output by limiting it
to commits which meet specific conditions.  Transformation is used in
the network-graphs sense of the word.  It fits the beginning of the
document where it says this:

  The diffcore mechanism is fed a list of such comparison results
  (each of which is called "filepair", although at this point each
  of them talks about a single file), and transforms such a list
  into another list.  There are currently 5 such transformations:

  - diffcore-break
  - diffcore-rename
  - diffcore-merge-broken
  - diffcore-pickaxe
  - diffcore-order
