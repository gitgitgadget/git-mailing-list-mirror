From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Don't die when command fails for one
 submodule
Date: Tue, 04 Mar 2008 12:32:27 -0800
Message-ID: <7vzlte44dg.fsf@gitster.siamese.dyndns.org>
References: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>
 <alpine.LSU.1.00.0803041500170.22527@racer.site>
 <46dff0320803040800o499bb77bsa033134bda43becb@mail.gmail.com>
 <alpine.LSU.1.00.0803041602150.22527@racer.site>
 <46dff0320803040806y5ed02b86p9216ddc752f3052@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:35:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWdpH-0004Ru-Sc
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 21:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764547AbYCDUcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 15:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764421AbYCDUcm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 15:32:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764315AbYCDUcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 15:32:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5583D3E10;
	Tue,  4 Mar 2008 15:32:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A27693E0C; Tue,  4 Mar 2008 15:32:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76134>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Wed, Mar 5, 2008 at 12:03 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>>
>>  On Wed, 5 Mar 2008, Ping Yin wrote:
>>
>>  > The error output is not lost and is in module_name
>>
>>  That's what I am saying: the error output is not enough.  The exit status
>>  needs to indicate that there was an error, too.  Everything else is
>>  unusable by scripts.
>
> I think this can be done in a following patch which capture any error
> and give the right exit status.

Please.

"You are absolutely right.  I'll fix it in my next round to do frotz and
xyzzy as you suggested.  I want to make my next round better with fixes
and improvements based on other comments I will receive during this round,
so it will be at least in a few days.  Thanks."

That's how I want to see things work around here.

