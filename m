From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff/log --check exitcode and PAGER environment variable
Date: Fri, 08 Aug 2008 02:44:37 -0700
Message-ID: <7vfxpfet8a.fsf@gitster.siamese.dyndns.org>
References: <489C145B.5090400@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 11:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KROXa-0005U7-Td
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 11:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbYHHJop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 05:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbYHHJop
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 05:44:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYHHJoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 05:44:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C47A7508C5;
	Fri,  8 Aug 2008 05:44:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 10223508C3; Fri,  8 Aug 2008 05:44:40 -0400 (EDT)
In-Reply-To: <489C145B.5090400@sneakemail.com> (Peter Valdemar =?utf-8?Q?M?=
 =?utf-8?Q?=C3=B8rch's?= message of "Fri, 08 Aug 2008 11:39:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A12CC8A6-652E-11DD-8BAF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91645>

"Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> writes:

> There is this old thread:
> "[PATCH 1/5] "diff --check" should affect exit status"
> http://thread.gmane.org/gmane.comp.version-control.git/68145/focus=3D=
68148
> which seemed not to reach a conclusion.

Conclusion was (1) if you really care about the exit code, do not use
pager; (2) after 1.6.0 we will swap the child/parent between git and pa=
ger
to expose exit code from us, but not before.

Or am I mistaken?
