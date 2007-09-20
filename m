From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] the return of the strbuf
Date: Thu, 20 Sep 2007 14:41:19 -0700
Message-ID: <7v1wctkoao.fsf@gitster.siamese.dyndns.org>
References: <20070917125211.GA18176@artemis.corp>
	<20070917133522.GD18176@artemis.corp>
	<20070918035721.GL3099@spearce.org>
	<Pine.LNX.4.64.0709201248400.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:41:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTm7-0002n1-PX
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbXITVl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbXITVl0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:41:26 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbXITVl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:41:26 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id ACD4E138DC1;
	Thu, 20 Sep 2007 17:41:42 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709201248400.28395@racer.site> (Johannes
	Schindelin's message of "Thu, 20 Sep 2007 12:49:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58807>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 17 Sep 2007, Shawn O. Pearce wrote:
>
>>  $ git log --pretty=format:%an --since=6.months.ago -- fast-import.c \
>>       | sort | uniq -c | sort -nr
>>   14 Shawn O. Pearce
>>    3 Pierre Habouzit
>>    3 Junio C Hamano
>>    2 Simon Hausmann
>>    2 Alex Riesen
>>    1 Theodore Ts'o
>>    1 Sven Verdoolaege
>>    1 Sami Farin
>>    1 Nicolas Pitre
>>    1 Luiz Fernando N. Capitulino
>>    1 Dana L. How
>
> FWIW I'd do
>
> git shortlog -n --since=6.months.ago HEAD -- fast-import.c|grep "^[A-Z]"
>
> instead...

I am sure you certainly meant a single command without grep, like:

	$ git shortlog -n -s --since=6.months.ago HEAD -- fast-import.c
