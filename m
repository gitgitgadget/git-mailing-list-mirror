From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH/RFC] alias: use run_command api to execute
 aliases
Date: Fri, 07 Jan 2011 11:21:45 -0800
Message-ID: <7v8vyw7c52.fsf@alter.siamese.dyndns.org>
References: <1294341187-3956-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1101070216390.1542@bonsai2>
 <AANLkTi=6wG6khBAqLA8nki5-wbxQB-oYUAgMSqT-egpt@mail.gmail.com>
 <alpine.DEB.1.00.1101071551190.15247@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:22:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHt3-0001ig-3f
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab1AGTWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 14:22:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1AGTWB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:22:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8181D32AB;
	Fri,  7 Jan 2011 14:22:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z8a9Mh6brYMmq0oAvvi8ZuIr7LQ=; b=jVWfGt
	AtuqhHBISkkz67ssuhhS96bHg2LyCmaEFuxkWBB6Lz6w5qlKGJz16oTSItPIxOPc
	PbZcc+Ezf+JelZRxnri3/mqrewI5zDzJaE94y6zBQYu6oJNHloto8ZZUizOVO5Ge
	UsX21Knt6iapySoLkoOTinDxxyAogEJbg8/no=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v+xtH3rK941R/aEbABERMu5eC7Kf6Ro6
	xr/maiSspsORrU+6pdZanjk2PyUCIwRa/z8uEQWenK+IficiwRycpmDGPdB5IRVg
	VJE4R7RH601dHzTbUbE1Ntu9mbRNnmwwWRArodfFZBZP+dvQR87WEBrSHve0BkS3
	pFs5sNCCSSY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EBA232A5;
	Fri,  7 Jan 2011 14:22:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A461532A4; Fri,  7 Jan 2011
 14:22:26 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1101071551190.15247@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri\, 7 Jan 2011 15\:51\:45 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A105388-1A93-11E0-9CBF-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164744>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But I'm kind of of two minds here myself, but for a slightly different 
>> reason: I think Git for Windows SHOULD use cmd.exe to execute scripts. 
>> We should be able to lose the msys-environment and still have the basic 
>> functionality working. In that sense, this is a step in the wrong 
>> direction. But I'd rather have all code use the same code-path to 
>> execute scripts, and make a bit switch to cmd.exe together with porting 
>> all supplied scripts to batch-files some time in the future.
>
> Okay, strike my objections, I agree now. Feel free to apply!

FWIW, I agree with Erik's reasoning, too.
Thanks, both.
