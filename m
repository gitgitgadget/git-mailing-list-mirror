From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-send-email.perl: Really add angle brackets to  In-Reply-To if necessary
Date: Sun, 09 Dec 2007 20:46:37 +0100
Message-ID: <85lk83r6qq.fsf@lola.goethe.zz>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197220648-20433-1-git-send-email-mh@glandium.org>
	<7v63z7rb87.fsf@gitster.siamese.dyndns.org>
	<851w9vsp8o.fsf@lola.goethe.zz> <86aboju2bp.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sun Dec 09 20:46:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1S6z-0000hR-H6
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 20:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbXLITq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 14:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXLITq2
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 14:46:28 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:44026 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXLITq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 14:46:28 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1J1S6a-0005LA-4A; Sun, 09 Dec 2007 14:46:24 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4E7BA1C4CE33; Sun,  9 Dec 2007 20:46:36 +0100 (CET)
In-Reply-To: <86aboju2bp.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Sun, 09 Dec 2007 10:53:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67655>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> I think what you were trying to do would work with:
>
>   for ($initial_reply_to) {
>       s/^\s*<?/</;
>       s/>?\s*$/>/;
>   }
>
> Untested, but I get this stuff right most of the time. :)

How is that supposed to differ from Mike's patch?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
