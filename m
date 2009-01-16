From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'mail' link on http://repo.or.cz/w/git.git no workee?
Date: Thu, 15 Jan 2009 18:41:04 -0800
Message-ID: <7vd4eootvj.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901151651460.3586@pacific.mpi-cbg.de>
 <20090116015439.GF12275@machine.or.cz>
 <7vmydsovs5.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901160315170.3586@pacific.mpi-cbg.de>
 <20090116022408.GG12275@machine.or.cz>
 <8c9a060901151832l71464185qf9f88afede6f550d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jacob Helwig" <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 03:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNefO-0007LS-8Y
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 03:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbZAPClP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 21:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZAPClO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 21:41:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbZAPClN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 21:41:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A317390BEA;
	Thu, 15 Jan 2009 21:41:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5AAB090BE9; Thu,
 15 Jan 2009 21:41:06 -0500 (EST)
In-Reply-To: <8c9a060901151832l71464185qf9f88afede6f550d@mail.gmail.com>
 (Jacob Helwig's message of "Thu, 15 Jan 2009 18:32:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23761F26-E377-11DD-87E5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105913>

"Jacob Helwig" <jacob.helwig@gmail.com> writes:

> On Thu, Jan 15, 2009 at 18:24, Petr Baudis <pasky@suse.cz> wrote:
>>
>> IIRC I found no way to actually make a gmane link since it requires POST
>> query for the searches or something.
>>
>
> $ cat bin/gmane-links.pl
> #!/usr/bin/perl
>
> use strict;
> use warnings;
>
> use Mail::Summary::Tools::ArchiveLink::Gmane;
>
> unless ($ARGV[0]) {
>     print STDERR "Must provide a message-id.\n";
>     exit 1;
> }
>
> my $link = Mail::Summary::Tools::ArchiveLink::Gmane->new(message_id =>
> $ARGV[0]);
>
> print "Thread: " . $link->thread_uri() . "\n";
> print "Message: " . $link->message_uri() . "\n";

Not quite, if message_id means what I think it means.

Pasky searches for the title of the message, and he does not have the
Message-ID header of the original message.
