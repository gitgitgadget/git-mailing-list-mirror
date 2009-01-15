From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 08:59:21 -0800
Message-ID: <7vmydsv72u.fsf@gitster.siamese.dyndns.org>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
 <496EE74F.6000205@viscovery.net> <200901151101.53441.johan@herland.net>
 <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
 <bd6139dc0901150445l51f3b861n5bbd85bb6d1382b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, gitster@pobox.com
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVaT-0000qO-Fl
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 18:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZAOQ7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbZAOQ7e
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:59:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbZAOQ7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 11:59:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56BDF901EA;
	Thu, 15 Jan 2009 11:59:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E5A28901E2; Thu,
 15 Jan 2009 11:59:22 -0500 (EST)
In-Reply-To: <bd6139dc0901150445l51f3b861n5bbd85bb6d1382b6@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu, 15 Jan 2009 13:45:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0A84436-E325-11DD-A7F1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105855>

"Sverre Rabbelier" <srabbelier@gmail.com> writes:

> On Thu, Jan 15, 2009 at 13:36, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> If at all, I'd introduce 'examine' as a synonym to 'edit' (might be more
>> intuitive).
>
> Examine suggests that you cannot change the commit (you can look, but
> don't touch it!), no?

'stop' would be closest to what it currently does.  It stops and it is up
to you how to screw up the result ;-).
