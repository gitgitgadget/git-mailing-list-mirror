From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Sat, 24 Jan 2009 21:05:45 -0800
Message-ID: <7vy6x0j7py.fsf@gitster.siamese.dyndns.org>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
 <20090123230520.GL21473@genesis.frugalware.org>
 <alpine.DEB.1.00.0901240131570.3586@pacific.mpi-cbg.de>
 <bd6139dc0901231642v6bd593d3mfefaca3c419a9f0a@mail.gmail.com>
 <20090125004955.GY21473@genesis.frugalware.org>
 <bd6139dc0901241655n66f75a8fn8450b774809fa8e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 06:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQxDL-0005mo-88
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 06:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbZAYFFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 00:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbZAYFFy
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 00:05:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbZAYFFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 00:05:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E164930C9;
	Sun, 25 Jan 2009 00:05:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 11E0A930C8; Sun,
 25 Jan 2009 00:05:47 -0500 (EST)
In-Reply-To: <bd6139dc0901241655n66f75a8fn8450b774809fa8e7@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun, 25 Jan 2009 01:55:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7726034-EA9D-11DD-9F06-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107041>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Jan 25, 2009 at 01:49, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> On Sat, Jan 24, 2009 at 01:42:30AM +0100, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>>> Which means all protocols actually die?
>>
>> I think so.
>
> Junio, are your concerns address now, since Miklos confirmed that
> transport_get_remote_refs always dies?

Yeah, it is on 'next' and I've pushed the results out last night, but I
got sick and didn't manage to send out "What's cooking".
