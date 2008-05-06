From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Add tests for git cat-file
Date: Mon, 05 May 2008 23:41:40 -0700
Message-ID: <7v63tshr2z.fsf@gitster.siamese.dyndns.org>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <7vve25q0ao.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue May 06 08:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtGso-0004FN-Rw
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 08:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbYEFGlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 02:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbYEFGlu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 02:41:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYEFGlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 02:41:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DE363CB5;
	Tue,  6 May 2008 02:41:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5C3DE3CB3; Tue,  6 May 2008 02:41:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FBB1D8A-1B37-11DD-B480-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81337>

Junio C Hamano <gitster@pobox.com> writes:

> Adam Roben <aroben@apple.com> writes:
>
>> Signed-off-by: Adam Roben <aroben@apple.com>
>> ---
>>  t/t1006-cat-file.sh |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++

I generally do not fix other people's mess, but every once in a while I
try to be nice, so I've fixed up various portability glitches in this test
script file and queued the early part to 'pu'.

However the t1007 test that is added later in the series have the same
kind of breakage.  I'll discard the rest of the series for now, but
hopefully the interdiff between the submitted and committed t1006 would
serve as a template to fix t1007.
