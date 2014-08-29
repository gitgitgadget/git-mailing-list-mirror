From: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>
Subject: Re: [PATCH 1/9] git-compat-util.h: Add missing semicolon after struct
 itimerval
Date: Fri, 29 Aug 2014 21:43:33 +0200
Message-ID: <5400D7E5.8090606@Maxsi.org>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>	<1409330916.18778.17.camel@jekeller-desk1.amr.corp.intel.com>	<5400CC7C.4010706@Maxsi.org> <xmqqlhq75d2y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Keller\, Jacob E" <jacob.e.keller@intel.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:43:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNS5D-00056X-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 21:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbaH2Tnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 15:43:35 -0400
Received: from csmtp6.one.com ([195.47.247.106]:43748 "EHLO csmtp6.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116AbaH2Tnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 15:43:35 -0400
Received: from [192.168.1.2] (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp6.one.com (Postfix) with ESMTPA id E2E4840001453;
	Fri, 29 Aug 2014 19:43:32 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqlhq75d2y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256185>

On 08/29/2014 09:07 PM, Junio C Hamano wrote:
> Jonas 'Sortie' Termansen <Sortie@Maxsi.org> writes:
> That is easy to fix, isn't it?
> 
> Where you said "If you have timer_settimer(), set this makefile
> variable", you start the sentence with "If you have a working
> timer_settimer()" instead.

That's mostly right. I care about cross-compilation, so that is also
something to keep in mind. It would be best if this could be
automatically and robustly determined (even when cross-compiling),
rather than relying on the user setting magic make variables.

Jonas
