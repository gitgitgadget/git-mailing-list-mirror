From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn messing with timezones
Date: Wed, 27 Feb 2008 15:23:32 -0800
Message-ID: <7vlk56ouff.fsf@gitster.siamese.dyndns.org>
References: <20080226124748.GH31792@mail.stoakes.net>
 <20080227073244.GB24316@soma> <20080227102631.GJ30300@mail.stoakes.net>
 <alpine.LSU.1.00.0802271039220.22527@racer.site>
 <20080227230916.GF18074@mail.stoakes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUVdX-0007BU-2j
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 00:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbYB0XXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 18:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754215AbYB0XXv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:23:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296AbYB0XXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 18:23:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D44F81228;
	Wed, 27 Feb 2008 18:23:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E7EBC1222; Wed, 27 Feb 2008 18:23:42 -0500 (EST)
In-Reply-To: <20080227230916.GF18074@mail.stoakes.net> (Tim Stoakes's message
 of "Thu, 28 Feb 2008 09:39:16 +1030")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75322>

Tim Stoakes <tim@stoakes.net> writes:

> Johannes Schindelin(Johannes.Schindelin@gmx.de)@270208-10:40:
>> Note: if all you want is such a strange behaviour as svn's (I mean, why 
>> does it insist to show the dates as if they were done in _your_ 
>> timezone?):
>> 
>> 	git log --date=local
>
> Ah excellent, that's what I want I think. I'm stuck with SVN for work,
> and reviewing commits that appeared to happen at 4am does not do much
> for my sanity!

FYI ("you" not referring to Tim in particular but the list
readers in general), the same --date=local can be used in a
repository that talk with CVS.
