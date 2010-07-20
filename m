From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 13:19:14 -0500
Message-ID: <gSJqoMSCdnNZVG9-DiMIs9GCIi5KJ7c0V35BPIQOHLVdP1L6ZeO3iA@cipher.nrlssc.navy.mil>
References: <20100720163822.GA8492@localhost.localdomain> <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil> <7veieym3sh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jaredhance@gmail.com, git@vger.kernel.org, avarab@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:19:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHPp-0007jL-6e
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201Ab0GTSTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 14:19:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37669 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab0GTSTe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:19:34 -0400
Received: by mail.nrlssc.navy.mil id o6KIJFJ4029402; Tue, 20 Jul 2010 13:19:15 -0500
In-Reply-To: <7veieym3sh.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 20 Jul 2010 18:19:15.0262 (UTC) FILETIME=[0F724DE0:01CB2838]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151342>

On 07/20/2010 01:00 PM, Junio C Hamano wrote:

> How about being more explicit?
> 
>     Run a git command and ensure it fails in a controlled way.  Use
>     this instead of "! <git-command>".  When git-command dies due to a
>     segfault, test_must_fail diagnoses it as an error; "! <git-command>"
>     treats it as just another expected failure. letting such a bug go
>     unnoticed.

Much better.  If you want the last sentence to be grammatically correct,
you could rephrase it like this:

   ...just another expected failure, which would let such a bug go unnoticed.

-brandon
