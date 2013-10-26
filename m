From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Sat, 26 Oct 2013 10:00:35 +0100
Message-ID: <20131026090034.GH10779@serenity.lan>
References: <1382641884-14756-1-git-send-email-gitster@pobox.com>
 <1382641884-14756-3-git-send-email-gitster@pobox.com>
 <CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
 <xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
 <CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
 <xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
 <xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
 <526A19CA.9020609@viscovery.net>
 <xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
 <xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 11:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZzjt-0000qT-5D
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 11:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab3JZJAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 05:00:49 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48851 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab3JZJAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 05:00:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4E34CCDA5DD;
	Sat, 26 Oct 2013 10:00:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L+33FSg+fHcE; Sat, 26 Oct 2013 10:00:47 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 2773BCDA5DB;
	Sat, 26 Oct 2013 10:00:47 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 18651161E460;
	Sat, 26 Oct 2013 10:00:47 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGPX0MfTTiVF; Sat, 26 Oct 2013 10:00:46 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 53998161E4F0;
	Sat, 26 Oct 2013 10:00:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236744>

On Fri, Oct 25, 2013 at 02:38:08PM -0700, Junio C Hamano wrote:
>  It also comes with a documentation update. The option is not called
>  --reflog but --fork-point; naming a feature after what it does
>  (i.e. it finds the fork point) is a lot more sensible than naming
>  it after how it happens to do what it does (i.e. it does so by
>  peeking into the reflog).

I think the new name is likely to confuse normal users - when talking
about a branch, you can talk about where it forked from and in that case
it normally means the merge-base of that branch and master.

The --reflog name has the advantage that it makes clear that this is
looking at something more than the commit graph and I don't think
--fork-point does imply that.
