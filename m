From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 13:05:51 -0700
Message-ID: <7vfxmc8r8g.fsf@gitster.siamese.dyndns.org>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:07:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0HL-0001PH-Mq
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbYJaUGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYJaUGS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:06:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYJaUGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:06:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4625773A4;
	Fri, 31 Oct 2008 16:06:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7EC957738C; Fri, 31 Oct 2008 16:05:58 -0400 (EDT)
In-Reply-To: <20081031184154.GV14786@spearce.org> (Shawn O. Pearce's message
 of "Fri, 31 Oct 2008 11:41:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 603B5010-A787-11DD-87CA-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99632>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>>   * proper public "stuff" naming (I e.g. realy like types names -- not
>>     struct or enum tags, that I don't really care -- ending with _t as
>>     it helps navigating source.
>
> Fixed, types now end in _t.

Ugh.

You could talk me into it if you promise never typedef structures (or
pointer to structures) with such symbols, I guess.
