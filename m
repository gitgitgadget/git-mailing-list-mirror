From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 11:40:33 -0800
Message-ID: <7v63jgep8u.fsf@gitster.siamese.dyndns.org>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
 <20090211180559.GC19749@coredump.intra.peff.net>
 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
 <20090211184429.GA27896@coredump.intra.peff.net>
 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
 <20090211191445.GU30949@spearce.org>
 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
 <7vd4doepvb.fsf@gitster.siamese.dyndns.org>
 <8e04b5820902111134o73f0cbc9gc25aeaae9a267f9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:42:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKyH-0004dQ-Uz
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbZBKTkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbZBKTkm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:40:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbZBKTkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:40:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D31689874A;
	Wed, 11 Feb 2009 14:40:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3D4F998748; Wed,
 11 Feb 2009 14:40:34 -0500 (EST)
In-Reply-To: <8e04b5820902111134o73f0cbc9gc25aeaae9a267f9a@mail.gmail.com>
 (Ciprian Dorin's message of "Wed, 11 Feb 2009 21:34:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD4815E2-F873-11DD-92E5-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109514>

"Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:

> On Wed, Feb 11, 2009 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> And why isn't it in $HOME/bin/?
>
>     No, it is inside .git/bin folder.

You are not answering my question.

I questioned the sanity of putting the scripts in .git/bin/ per
repository.  Why shouldn't a useful script like your "branch-import"
available to _all_ your repositories, possibly taking customization per
repository from repository's .git/config file, so that it does what is
appropriate in each repository?
