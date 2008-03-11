From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can it
 be done in Git?
Date: Tue, 11 Mar 2008 02:48:48 -0700
Message-ID: <7vtzjdbngf.fsf@gitster.siamese.dyndns.org>
References: <200803091459.21354.jnareb@gmail.com>
 <200803101938.09300.jnareb@gmail.com> <47D6541F.8000503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:49:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ173-0002CW-Oa
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbYCKJs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbYCKJs6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:48:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYCKJs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:48:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 936812AC6;
	Tue, 11 Mar 2008 05:48:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CEA642AC5; Tue, 11 Mar 2008 05:48:50 -0400 (EDT)
In-Reply-To: <47D6541F.8000503@op5.se> (Andreas Ericsson's message of "Tue,
 11 Mar 2008 10:42:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76825>

Andreas Ericsson <ae@op5.se> writes:

> Jakub Narebski wrote:
>>
>> Mercurial extension | git equivalent (or proposal)
>> --------------------+------------------------------------
>> bisect              | git-bisect
>>
>> Footnotes:
>> ==========
>> (*) Directly inspired by git feature
>> (!) No direct equivalent, would be quite a work to add
>> (!!!) No equivalent, don't know if possible
>>
>
> IIRC, bisect should have a star here (or five, as it's a killer feature).

Heh, why do we even care?  It is a norm that good features cross pollinate
across systems and who borrows ideas from whom does not really matter
much.
