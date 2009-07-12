From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git svn: allow uppercase UUIDs from SVN
Date: Sun, 12 Jul 2009 14:53:06 -0700
Message-ID: <7v7hydlgal.fsf@alter.siamese.dyndns.org>
References: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com>
 <20090710033133.GA23082@dcvr.yhbt.net>
 <5m5e55538tlnq40rup7rci61i2mg16q0dv@4ax.com>
 <20090710203322.GA18051@dcvr.yhbt.net> <20090712185821.GA26749@dcvr.yhbt.net>
 <7vtz1hli15.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Esben Skovenborg <esskov@oncable.dk>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 12 23:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ6z5-0006Rm-MP
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 23:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbZGLVxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbZGLVxN
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 17:53:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZGLVxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 17:53:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 078D927063;
	Sun, 12 Jul 2009 17:53:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2318F27060; Sun,
 12 Jul 2009 17:53:08 -0400 (EDT)
In-Reply-To: <7vtz1hli15.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 12 Jul 2009 14\:15\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64EDF94A-6F2E-11DE-B81C-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123163>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <normalperson@yhbt.net> writes:
>
>>   Junio: pushed out to git://git.bogomips.org/git-svn along with
>>          some patches I think I forgot to tell you about:
>
> Thanks, will pull.

Actually I think I got something different from what I thought I was
expecting.  Your message said:

    Eric Wong (1):
          git svn: allow uppercase UUIDs from SVN

    Mattias Nissler (2):
          git-svn: Always duplicate paths returned from get_log
          git-svn: Fix branch detection when repository root is inaccessible

but after merge:

    Junio C Hamano (1):
          Merge git://git.bogomips.org/git-svn

    Mattias Nissler (2):
          git-svn: Always duplicate paths returned from get_log
          git-svn: Fix branch detection when repository root is inaccessible

    Yann Dirson (4):
          git-svn.txt: stop using dash-form of commands.
          git-svn.txt: make formatting more consistent.
          git-svn.txt: fix fetch flags incorrectly documented as init flags.
          git-svn.txt: fix description of fetch flags accepted by clone.

For example, you have this:

    commit eb0d671e3b73f05106dca83b9cecd74d4acdb291
    Author: Yann Dirson <ydirson@altern.org>
    Date:   Mon Jul 6 00:03:15 2009 +0200

which is an old iteration of 

    commit 6c32a7a99495da3f49e2a142791bc10af3f6f059
    Author: Yann Dirson <ydirson@altern.org>
    Date:   Tue Jul 7 22:22:20 2009 +0200

that is already in 'master'.

Perhaps you forgot to push it out?  These are what I see:

    $ git fetch git://git.bogomips.org/git-svn HEAD
    $ git log --oneline ..FETCH_HEAD
    6bb8ed9 git-svn: Fix branch detection when repository root is inaccessible
    2d4b387 git-svn: Always duplicate paths returned from get_log
    bca5572 git-svn.txt: fix description of fetch flags accepted by clone.
    e594175 git-svn.txt: fix fetch flags incorrectly documented as init flags.
    eb0d671 git-svn.txt: make formatting more consistent.
    6478d74 git-svn.txt: stop using dash-form of commands.
