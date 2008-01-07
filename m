From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn doesn't like !! in the url
Date: Mon, 07 Jan 2008 15:22:43 -0800
Message-ID: <7vr6gtxlto.fsf@gitster.siamese.dyndns.org>
References: <EA596F68-D87B-49AD-9DEF-2C2E07127BDE@gmail.com>
	<20080107103040.GA28557@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J. Cohen" <michael.joseph.cohen@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 00:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC1Ja-0002kk-7y
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 00:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbYAGXXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 18:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbYAGXXA
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 18:23:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbYAGXXA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 18:23:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 884ADB284;
	Mon,  7 Jan 2008 18:22:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 15700B281;
	Mon,  7 Jan 2008 18:22:54 -0500 (EST)
In-Reply-To: <20080107103040.GA28557@soma> (Eric Wong's message of "Mon, 7 Jan
	2008 02:30:40 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69826>

Eric Wong <normalperson@yhbt.net> writes:

> I just dug up cfbe7ab333d68790eb37341e30f040f99cef6af7 and that
> should've escaped everything that needs to be urlencoded for HTTP(S).
> (you were also the one that noticed the need for that one, too :).
>
> I also just noticed that changeset didn't make it into 1.5.3.7 nor
> maint, however...
>
> Junio: if there are plans for 1.5.3.8, could you please add
> cfbe7ab333d68790eb37341e30f040f99cef6af7 to it?  Thanks.

Surely I can cherry pick that commit.  Are you sure the test in
it (t9118) does not depend on any other new features that appear
on 'master'?
