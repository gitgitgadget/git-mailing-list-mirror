From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Mon, 29 Apr 2013 19:32:05 +0100
Message-ID: <20130429183205.GO472@serenity.lan>
References: <7va9ong9oa.fsf@alter.siamese.dyndns.org>
 <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org>
 <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org>
 <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org>
 <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
 <7vhaipl2ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:32:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWss9-0003iN-6u
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795Ab3D2ScP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:32:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:54495 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758372Ab3D2ScN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:32:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 241D46064E8;
	Mon, 29 Apr 2013 19:32:13 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vYVQ8vvvKdTq; Mon, 29 Apr 2013 19:32:12 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id B28946064E1;
	Mon, 29 Apr 2013 19:32:12 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A92A5161E458;
	Mon, 29 Apr 2013 19:32:12 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSdi0K6BZaiq; Mon, 29 Apr 2013 19:32:12 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 20CCE161E44B;
	Mon, 29 Apr 2013 19:32:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vhaipl2ks.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222843>

On Mon, Apr 29, 2013 at 09:32:51AM -0700, Junio C Hamano wrote:
> *1* Instead, you have a separate integration branch for testing that
> merges other's work and your topic.

<shameless-plug>

I wrote a script to help manage this [1].  It doesn't do everything I
want it to yet but I'm using it on a daily basis to maintain a Git
version consisting of pu plus a few changes that I'm working on which
aren't ready for submission yet as well as for maintaining integration
branches in a couple of other projects.

You can create an integration branch on top of pu quickly with:

    git integration --create my-integration-branch pu \
        --add my-feature-branch --rebuild

And then whenever you want to rebuild with your latest changes (or on
top of the latest pu):

    git integration --rebuild my-integration-branch

[1] http://johnkeeping.github.io/git-integration/
