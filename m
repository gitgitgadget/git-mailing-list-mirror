From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 0/6] Improve remote helper documentation
Date: Fri, 7 Dec 2012 22:41:00 +0100
Message-ID: <A6FF9929-74F8-4F2F-BA0B-1B1086D4E7F5@quendi.de>
References: <1354038279-76475-1-git-send-email-max@quendi.de> <7v1uf1he6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:42:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th5h0-0006nq-NB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 22:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab2LGVm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 16:42:26 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:60328 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756868Ab2LGVmY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Dec 2012 16:42:24 -0500
Received: from drms-590edca7.pool.mediaways.net ([89.14.220.167] helo=[192.168.1.37]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Th5gZ-0001PS-T4; Fri, 07 Dec 2012 22:42:19 +0100
In-Reply-To: <7v1uf1he6m.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354916544;0d9930ff;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211196>


On 07.12.2012, at 20:09, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>> Various remote helper capabilities and commands were not
>> documented, in particular 'export', or documented in a misleading
>> way (e.g. 'for-push' was listed as a ref attribute understood by
>> git, which is not the case). This patch series changes that, and
>> also address some other things in the remote helper documentation
>> that I found jarring when reading through it.
>> 
>> Note that the description of export and (im|ex)port-marks probably can be
>> improved, and I hope that somebody who knows more about them
>> than me and/or is better at writing documentation will do just that.
>> But I felt it was better to provide something than to do nothing
>> and only complain, as I did previously on this subject ;-).
> 
> A second ping to people who have touched transport-helper.c,
> remote-testsvn.c, git-remote-testgit, and contrib/remote-helpers/ in
> the past 18 months for comments.  I've re-read the documentation
> updates myself and didn't find anything majorly objectionable.
> 
> Except for a minor nit in 6/6; I think "defined options" should be
> "defined attributes".
> 
>    --- a/Documentation/git-remote-helpers.txt
>    +++ b/Documentation/git-remote-helpers.txt
>    @@ -227,6 +227,8 @@ Support for this command is mandatory.
>            the name; unrecognized attributes are ignored. The list ends
>            with a blank line.
>     +
>    +See REF LIST ATTRIBUTES for a list of currently defined options.
>    ++

Indeed, my mistake. Dumb question since I am still not completely familiar with the procedures here: Would you just fix this yourself as you apply this, or is it better (or even required) that I reroll for this? (Of course if I ned to re-roll for other reasons, I'd fix this one as well).


Thanks,
Max