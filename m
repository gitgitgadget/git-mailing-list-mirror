From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add status.relativePaths config variable
Date: Sat, 08 Dec 2007 00:05:49 -0800
Message-ID: <7v63z9y5k2.fsf@gitster.siamese.dyndns.org>
References: <20071207165703.GA8889@sigill.intra.peff.net>
	<Pine.LNX.4.64.0712071853500.27959@racer.site>
	<4759996B.2000300@gmail.com>
	<20071207204937.GA20111@coredump.intra.peff.net>
	<20071207212607.GA11504@coredump.intra.peff.net>
	<7vejdxy70p.fsf@gitster.siamese.dyndns.org>
	<7vaboly6dv.fsf@gitster.siamese.dyndns.org>
	<20071208080238.GB4812@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0uho-00069L-Aw
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbXLHIGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbXLHIGP
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:06:15 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:60492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbXLHIGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:06:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E37241BC;
	Sat,  8 Dec 2007 03:06:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E003441BA;
	Sat,  8 Dec 2007 03:06:01 -0500 (EST)
In-Reply-To: <20071208080238.GB4812@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Dec 2007 03:02:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67524>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 07, 2007 at 11:47:56PM -0800, Junio C Hamano wrote:
>
>> Which would make the rewritten patch like this...
>
> Looks like our patches just crossed paths.  Yours looks OK, but we
> should add something to the 'configuration' section, and...
>
>> diff --git a/wt-status.h b/wt-status.h
>> index 225fb4d..63d50f2 100644
>> --- a/wt-status.h
>> +++ b/wt-status.h
>> @@ -28,6 +28,7 @@ struct wt_status {
>>  
>>  int git_status_config(const char *var, const char *value);
>>  int wt_status_use_color;
>> +int wt_status_relative_paths;
>>  void wt_status_prepare(struct wt_status *s);
>>  void wt_status_print(struct wt_status *s);
>
> Shouldn't both of these ints be marked "extern"? I'm surprised it worked
> at all (or perhaps the part of my brain that stores C linkage issues is
> rotting?).

Yes, rotting very much.
