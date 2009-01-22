From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Thu, 22 Jan 2009 09:14:13 -0800
Message-ID: <7v1vuv8dqy.fsf@gitster.siamese.dyndns.org>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
 <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
 <831vuvfh7t.fsf@kalahari.s2.org>
 <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ39f-0000Y9-AD
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbZAVROV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 12:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbZAVROV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:14:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbZAVROV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 12:14:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B856E92AD2;
	Thu, 22 Jan 2009 12:14:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5AA3392ABD; Thu,
 22 Jan 2009 12:14:15 -0500 (EST)
In-Reply-To: <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
 (Felipe Contreras's message of "Thu, 22 Jan 2009 18:57:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B13EF3A-E8A8-11DD-95C0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106772>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Jan 22, 2009 at 6:17 PM, Hannu Koivisto <azure@iki.fi> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> This brings back my previous question: where is the home directory in
>>> a Windows system?
>>
>> It's where %HOMEDRIVE%%HOMEPATH% points to.
>
> I thought it was something like that. Do we want something like that
> in the manual, or should we assume Windows users know that?

Funny; while I was test driving Msysgit (I wrote the report in my blog
pages some time ago), I got curious about this exact issue.  I thought the
choice of $HOME at that path was quite natural even for me who does not
usually use Windows.
