From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 16:06:23 -0700
Message-ID: <7v7inkcz2o.fsf@gitster.siamese.dyndns.org>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
	<20070823203246.GB3516@steel.home>
	<6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
	<7v8x81s7d1.fsf@gitster.siamese.dyndns.org>
	<fann62$f5q$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOiEz-0001pt-6s
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 01:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922AbXHXXG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 19:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbXHXXG1
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 19:06:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbXHXXG0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 19:06:26 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D7E5F127C53;
	Fri, 24 Aug 2007 19:06:46 -0400 (EDT)
In-Reply-To: <fann62$f5q$2@sea.gmane.org> (Jakub Narebski's message of "Sat,
	25 Aug 2007 00:47:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56611>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> I think the latter is more important point. =C2=A0If you train a
>> naive user to use --only-tracked to ignore "Untracked" list, you
>> are doing him or her a great disservice. =C2=A0Mistake to forget "gi=
t
>> add" a new file before commiting will bound to happen.
>
> If it won't acquire short version, nor tab completion, mosts users wh=
en
> confronted with such a mothful of option-name wouldn't use it unless
> necessary, I think...

Yeah, but if we accept that --only-tracked patch, I know from
the past experience that people would send a "shorter synonym"
patch, arguing that the capability is already there.

I really think we should resist temptation to add misfeatures
that would encourage bad workflows and new user mistakes.
