From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 13:43:00 -0700
Message-ID: <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>
 <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>
 <47E81037.5030808@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdtWU-0006Iz-Ds
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 21:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYCXUnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 16:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYCXUnT
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 16:43:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbYCXUnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 16:43:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C77481309;
	Mon, 24 Mar 2008 16:43:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C5AFC1308; Mon, 24 Mar 2008 16:43:05 -0400 (EDT)
In-Reply-To: <47E81037.5030808@keyaccess.nl> (Rene Herman's message of "Mon,
 24 Mar 2008 21:33:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78096>

Rene Herman <rene.herman@keyaccess.nl> writes:

> On 24-03-08 21:15, Jan Engelhardt wrote:
>
>> On Monday 2008-03-24 20:59, Catalin Marinas wrote:
>>
>>> Stacked GIT 0.14.2 release is available from
>>> http://www.procode.org/stgit/.
>>>
>>> StGIT is a Python application providing similar functionality to Quilt
>>> (i.e. pushing/popping patches to/from a stack) on top of GIT.
>>
>> I always wondered what the difference between stgit and guilt is.
>> Does anyone have a comparison up?
>
> And I remember some mumblings about git growing quilt-like
> functionality itself. Anything on that?

Not my mumbling, but I am quite open to slurp in guilt as a subdirectory
in git.git at some point in the future just like we bundle git-gui and
gitk if asked by the maintainer.

The same applies to StGIT for that matter, although I somehow feel that is
much less likely to happen, because it lived long enough as a standalone
project with enough following to achieve sustainable momentum by itself.
