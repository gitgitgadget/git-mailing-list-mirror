From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc4
Date: Wed, 21 May 2014 06:25:24 +0200
Message-ID: <87tx8jahcb.fsf@fencepost.gnu.org>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
	<537bf50f27417_353e13c330846@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Wed May 21 06:25:37 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Wmy5x-0000fe-Dm
	for glk-linux-kernel-3@plane.gmane.org; Wed, 21 May 2014 06:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbaEUEZ2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 21 May 2014 00:25:28 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:44748 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaEUEZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2014 00:25:26 -0400
Received: from localhost ([127.0.0.1]:43789 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wmy5k-0002WO-Lh; Wed, 21 May 2014 00:25:24 -0400
Received: by lola (Postfix, from userid 1000)
	id 4E286E054B; Wed, 21 May 2014 06:25:24 +0200 (CEST)
In-Reply-To: <537bf50f27417_353e13c330846@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 20 May 2014 19:36:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249775>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>
>>  * The remote-helper interface to fast-import/fast-export via the
>>    transport-helper has been tightened to avoid leaving the import
>>    marks file from a failed/crashed run, as such a file that is out-of-
>>    sync with reality confuses a later invocation of itself.
>
> Really? Where are the patches for that?

The following seems related:

commit 10e1feebb454d99eb6644cc53b94255f40e6fe9c
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed May 14 12:06:35 2014 -0700

    Revert "Merge branch 'fc/transport-helper-sync-error-fix'"
    
    This reverts commit d508e4a8e2391ae2596403b6478d01cf3d5f928f,
    reversing changes made to e42552135a2a396f37053a89f44952ea907870b2.
    
    The author of the original topic says he broke the upcoming 2.0
    release with something that relates to "synchronization crash
    regression" while refusing to give further specifics, so this would
    unfortunately be the safest option for the upcoming release.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


-- 
David Kastrup
