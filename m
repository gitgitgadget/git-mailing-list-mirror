From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Wed, 09 Jul 2008 01:18:22 -0700
Message-ID: <7vhcazlbch.fsf@gitster.siamese.dyndns.org>
References: <11911047823308-git-send-email-jean.guyader@linkea.org>
 <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709300039430.28395@racer.site>
 <7v4phdja01.fsf@gitster.siamese.dyndns.org>
 <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org>
 <20080709055150.GA28482@glandium.org>
 <7vlk0blgg0.fsf@gitster.siamese.dyndns.org>
 <20080709075345.GA22022@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 10:19:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGUts-0000aY-KA
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 10:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYGIISr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 04:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYGIISq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 04:18:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYGIISp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 04:18:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 84F9923AE3;
	Wed,  9 Jul 2008 04:18:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6029223ADC; Wed,  9 Jul 2008 04:18:34 -0400 (EDT)
In-Reply-To: <20080709075345.GA22022@glandium.org> (Mike Hommey's message of
 "Wed, 9 Jul 2008 09:53:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A59F8DDA-4D8F-11DD-BF77-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87859>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Jul 08, 2008 at 11:28:15PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> >> Actually Documentation/howto/setup-git-server-over-http.txt
>> >> talks about http://user@server/path/ format.  How well does this
>> >> work in practice?  If it does, we should update Documentation/urls.txt
>> >> to allow optional user@ there like...
>> >
>> > AFAIK, there is nothing to deal with asking a password to the user in git
>> > in this case, so that doesn't work.
>> 
>> Then perhaps the howto needs updating?
>
> Actually, the howto tells to setup a ~/.netrc file, which should make
> the http://user@server/path/ format work. I don't know if dropping user@
> would still work, that depends how libcurl works with it.

Ok, so the documentation update I suggested earlier may actually be
valid, right?
