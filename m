From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 10:37:55 -0800
Message-ID: <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJEh-0005SC-JN
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBVSiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZBVSiD
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:38:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbZBVSiB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:38:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A1E69C052;
	Sun, 22 Feb 2009 13:38:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6267A9C051; Sun,
 22 Feb 2009 13:37:57 -0500 (EST)
In-Reply-To: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
 (Felipe Contreras's message of "Sun, 22 Feb 2009 20:14:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE657B90-010F-11DE-8E13-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111046>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I understand the option should be kept for people that are used to it,

It is not just that.  New people should learn existing lingo, as that is
the word used in the existing documentation and various random web pages,
so that they can use the same language when they teach people who are
newer than themselves.

If the existing word was not pretty (that came from "pretty-formatting")
but something unpronouncible like '--gzxfw=short", then your argument
might make some sense, but there is no such "breakage we need to fix"
here.
