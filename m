From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 21 Jan 2008 18:04:33 -0800
Message-ID: <7vprvuvcni.fsf@gitster.siamese.dyndns.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
	<47946F67.5060601@gbarbier.org>
	<7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>
	<47947399.3000507@gbarbier.org>
	<7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801211212010.5731@racer.site>
	<7vejcbx795.fsf@gitster.siamese.dyndns.org>
	<20080121202953.GA18440@glandium.org>
	<alpine.LSU.1.00.0801220056080.5731@racer.site>
	<7vy7aive18.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801220137310.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 03:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH8Vw-0005w5-3D
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 03:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbYAVCEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 21:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbYAVCEz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 21:04:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbYAVCEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 21:04:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D49D866E5;
	Mon, 21 Jan 2008 21:04:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5400E66E0;
	Mon, 21 Jan 2008 21:04:50 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801220137310.5731@racer.site> (Johannes
	Schindelin's message of "Tue, 22 Jan 2008 01:38:49 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71400>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 21 Jan 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > So I am half-convinced that http-push w/o CURL_MULTI was broken since 
>> > long ago (pre 1.5.3).
>> 
>> Sigh, but Ok.  Then let's do this.
>
> This sigh hurts my heart.

Heh, it's not like you broke it, and if I sounded like I was
shooting at the messenger I apologize.
