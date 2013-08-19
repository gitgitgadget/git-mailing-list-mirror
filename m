From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:20:59 +0200
Message-ID: <21189B7B-5413-447C-955B-784F51110B13@zib.de>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de> <1376894300-28929-1-git-send-email-prohaska@zib.de> <20130819075408.GT2337@serenity.lan>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Aug 19 10:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKiL-0006i1-T1
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950Ab3HSIVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 04:21:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:44591 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab3HSIVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Aug 2013 04:21:21 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7J8L3PX005313;
	Mon, 19 Aug 2013 10:21:08 +0200 (CEST)
Received: from kodkod.zib.de (kodkod.zib.de [130.73.68.88])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7J8L2vO004604
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 19 Aug 2013 10:21:02 +0200 (MEST)
In-Reply-To: <20130819075408.GT2337@serenity.lan>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232535>


On Aug 19, 2013, at 9:54 AM, John Keeping <john@keeping.me.uk> wrote:

> You've created compat/clipped-read.c, but...
> 
>> Makefile              |  8 ++++++++
>> builtin/var.c         |  1 +
>> config.mak.uname      |  1 +
>> git-compat-util.h     |  5 +++++
>> streaming.c           |  1 +
>> t/t0021-conversion.sh | 14 ++++++++++++++
>> 6 files changed, 30 insertions(+)
> 
> ... it's not included here.  Did you forget to "git add"?

Indeed.  How embarrassing.  Thanks for spotting this.  I'll send v3 in a minute.

	Stefffen