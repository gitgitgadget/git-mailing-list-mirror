From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] Threaded grep
Date: Tue, 19 Jan 2010 08:03:16 +0100
Message-ID: <4B555934.9060106@viscovery.net>
References: <20100118103334.GA17361@fredrik-laptop>	 <7vmy0bhxn1.fsf@alter.siamese.dyndns.org> <4c8ef71001181612l72ec73ecmae709fbb475752b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 08:03:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX87a-0001pt-HC
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 08:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab0ASHDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 02:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218Ab0ASHDW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 02:03:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17641 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab0ASHDV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 02:03:21 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NX87Q-0001Nc-Rj; Tue, 19 Jan 2010 08:03:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 90F3D1660F;
	Tue, 19 Jan 2010 08:03:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4c8ef71001181612l72ec73ecmae709fbb475752b0@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137436>

Fredrik Kuivinen schrieb:
> On Mon, Jan 18, 2010 at 23:10, Junio C Hamano <gitster@pobox.com> wrote:
>> Fredrik Kuivinen <frekui@gmail.com> writes:
>>> +/* This lock protects all the variables above. */
>>> +static pthread_mutex_t grep_lock = PTHREAD_MUTEX_INITIALIZER;
>> J6t had comments on these initializers; do they also apply to
>> builtin-pack-objects.c?
> 
> I believe so, but I do not know. Johannes?

44626dc (MSVC: Windows-native implementation for subset of Pthreads API)
that is currently queued in pu makes the necessary adjustments to
builtin-pack-objects.c.

-- Hannes
