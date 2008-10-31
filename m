From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 15:51:03 -0700
Message-ID: <7v3aic8jl4.fsf@gitster.siamese.dyndns.org>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp> <490B7FD3.8060003@op5.se>
 <20081031220133.GA14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:52:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2rH-0006tS-4n
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbYJaWvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbYJaWvX
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:51:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYJaWvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:51:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B909F7735A;
	Fri, 31 Oct 2008 18:51:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8313177359; Fri, 31 Oct 2008 18:51:10 -0400 (EDT)
In-Reply-To: <20081031220133.GA14786@spearce.org> (Shawn O. Pearce's message
 of "Fri, 31 Oct 2008 15:01:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 700ABE1A-A79E-11DD-A6A4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99668>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Andreas Ericsson <ae@op5.se> wrote:
>>>   * proper public "stuff" naming (I e.g. realy like types names -- not
>>>     struct or enum tags, that I don't really care -- ending with _t as
>>>     it helps navigating source.
>>
>> *_t types are reserved by POSIX for future implementations, so that's
>> a no-go (although I doubt POSIX will ever make types named git_*_t).
>
> Yikes.  Anyone know where a concise list of the reserved names are?

Essentially, anything that ends with "_t" ;-)

http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_02.html#tag_02_02_02

Look for "Any Header" in the table.

>> Apart from that, please consider reading Ulrich Drepper's musings on
>> library design at http://people.redhat.com/drepper/goodpractice.pdf
>
> I think I've read that before, but I'll skim over it again.
> Thanks for the link.
>
> -- 
> Shawn.
