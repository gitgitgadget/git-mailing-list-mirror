From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH maint 0/3] do not write files outside of work-dir
Date: Fri, 27 May 2011 12:16:40 -0700
Message-ID: <7v7h9crm1z.fsf@alter.siamese.dyndns.org>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <7vr57krppq.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1105272007500.16250@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 27 21:17:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ2Wr-0007S2-VM
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 21:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab1E0TQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 15:16:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1E0TQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 15:16:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBE164370;
	Fri, 27 May 2011 15:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zrD7KhkR4/N7pKrTuZdU4L+EbZs=; b=liKG4r
	5wQ06Sot7LCqL1bZimGW3uqkpJFZtdScZya+xcPvyQ2gKBCmdl3jkZ92i5IEyss1
	eAvgAO4jdegmr4Hdnx+mpwtmu8PZA+4Ra53EjJ4yxx1AIwyJqRbXYSCNFVsDtDHR
	O6WHnTKAd4EaJfCuUJ0Q2ZB8PrzMmto31iQfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xx6RsMgQlecPclyWMy83g6+uUDdEhhvE
	9VAFkbk937eBtb1oT5Fl2G1OAU8ng6dJGrc1LcNcDemdmRUp2QN3PqawxO2CnRyX
	UdpIdYTVSEhl3mVmNwKCWPKuwXKKrpp1aJnjCKKMIhDDpl9h1lzyjqxqh72icjM9
	eRZBwDOHjFc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84327436E;
	Fri, 27 May 2011 15:18:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C3C26436D; Fri, 27 May 2011
 15:18:48 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1105272007500.16250@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Fri, 27 May 2011 20:09:02 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ABC818C-8896-11E0-AA1B-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174640>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Which of my integration branches do msysGit/Git for Windows folks base 
>> their releases these days? I could carry this through the regular "next 
>> to master and then sometime later to maint" schedule, but if you are not 
>> using maint and basing primarily on master then I'd rather skip the "and 
>> then sometime later to maint" part.
>
> We follow 'next'.
>
> [Cc:ing the msysGit list, as I don't know whether Pat or Sebastian follow 
> git@vger]

Thanks.

Then my preference would be to queue this to "next", wait for msysGit to
cut a release based on that, and then graduate it to "master" on my side.
