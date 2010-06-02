From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Wed, 2 Jun 2010 09:33:27 +0000
Message-ID: <AANLkTilMBZ_m71dPoH8mU6e9wfYybljV9bE2p_Bl9C0g@mail.gmail.com>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
	<Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil>
	<AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:33:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkKO-0004E6-BY
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab0FBJdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 05:33:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57631 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab0FBJda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 05:33:30 -0400
Received: by iwn6 with SMTP id 6so1228920iwn.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=4wJKn5ooAdPycwJatwaYCCwTXCeZNXi3VS5oyTDdBF8=;
        b=SfsEtnDH40hHpP18+0sJ/HFRF2Yrvnix0NpivGw+cn8X8MumL1iCtsoD9iiRUdJhxv
         ECJDira6vOtBzRzqb6wnI4FA0Zii2cS0bfSCskpWu9McnAZGkE0IDnexEkac+eh/+paJ
         pbVuh5YO9MT8F/n0ZvcRVG48XXe3ZUBRylz9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KAamD+zsnuj5FY4T4ZkRuLXcVXZMfb0QPuirNNZuahWLxqKTkLYn0XTLREoA/sRCDw
         wekUvMYE6+eNtrkoJCcuoeiN0AeWrUuRSHZ2TyLE9Izk5loUZAQbfK8/ag4gix4tkdQS
         aG5kaCGFL3ODzFAWOE//9OnEP15Ap8oKMwYHk=
Received: by 10.231.187.29 with SMTP id cu29mr9403724ibb.70.1275471208228; 
	Wed, 02 Jun 2010 02:33:28 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 2 Jun 2010 02:33:27 -0700 (PDT)
In-Reply-To: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148234>

On Wed, Jun 2, 2010 at 06:21, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Otoh, python 2.5 has been out for a while (and is in fact only
> downloadable as a source-only release these days). To be exact, it was
> released on September 19, 2006.

As a trivia: most of our Perl code is still 5.6 compatible. That'd be
like supporting Python 1.6 (or actually, 1.5.2, 1.6 came out half a
year after Perl 5.6).

Anyway, dying in the program as you suggest seems like a better idea.
