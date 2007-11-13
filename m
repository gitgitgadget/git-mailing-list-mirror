From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Tue, 13 Nov 2007 13:10:24 -0800
Message-ID: <7vlk91svgf.fsf@gitster.siamese.dyndns.org>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
	<200711132110.29136.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is31z-0001GL-VF
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759905AbXKMVKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759796AbXKMVKb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:10:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51346 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759316AbXKMVKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:10:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id ED2692F2;
	Tue, 13 Nov 2007 16:10:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 839A59540E;
	Tue, 13 Nov 2007 16:10:48 -0500 (EST)
In-Reply-To: <200711132110.29136.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Tue, 13 Nov 2007 21:10:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64866>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Tuesday 13 November 2007 21:04, Johannes Sixt wrote:
>> [PATCH 09/11] Allow a relative builtin template directory.
>> [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
>> 	of ETC_GITCONFIG.
>> [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
>>
>> These need probably some discussion. They avoid that $(prefix) is
>> hardcoded and so allows that an arbitrary installation directory.
>
> ... and so allow that the compiled binaries are installed in any directory 
> that the user chooses.

If you can do that without breaking the tests (specifically, the
test script should pick up the version of git you just built,
not from /usr/bin nor /usr/local/stow/git/bin) that would be
great.
