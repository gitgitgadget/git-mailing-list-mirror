From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] apply, entry: speak of submodules instead of subprojects
Date: Tue, 16 Jul 2013 22:07:55 +0200
Message-ID: <8738res1yc.fsf@hexa.v.cablecom.net>
References: <87bo631odi.fsf@hexa.v.cablecom.net>
	<8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
	<20130716180739.GK14690@google.com> <51E5997E.2090607@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	"Ralf Thielow" <ralf.thielow@gmail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 16 22:08:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzBXX-0003pj-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 22:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933773Ab3GPUH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 16:07:59 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34245 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133Ab3GPUH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 16:07:58 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 22:07:53 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 22:07:55 +0200
In-Reply-To: <51E5997E.2090607@web.de> (Jens Lehmann's message of "Tue, 16 Jul
	2013 21:05:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230580>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 16.07.2013 20:07, schrieb Jonathan Nieder:
>> Thomas Rast wrote:
>> 
>>> There are only four (with some generous rounding) instances in the
>>> current source code where we speak of "subproject" instead of
>>> "submodule".  They are as follows:
>> [...]
>>> Let's at least change the error messages to consistently call them
>>> "submodule".
>>>
>>> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
>>> ---
>>> This and the next one are message changes for things I found during my
>>> review.
>> 
>> Thanks.  It's nice when translation results in the messages in English
>> being improved, too.
>
> Obviously I like this change too. ;-)
>
> But a 'git grep "corrupt patch for sub"' shows some files in the po
> directory still containing that string on current master. Shouldn't
> they be changed too or is this just a sign of me not understanding
> the translation process?

I haven't checked any guides, but I imagine that the resulting manual
translation update is what prompts the translators to also check if they
need to adapt the message.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
