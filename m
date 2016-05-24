From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and
 reply to
Date: Tue, 24 May 2016 18:30:05 -0400
Message-ID: <20160524223005.GB23162@pug>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
 <20160523195504.GA8957@dcvr.yhbt.net>
 <0285f901-a1d1-2715-4207-68c7d103da5e@grenoble-inp.org>
 <vpqshx77h9o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Eric Wong <e@80x24.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 00:30:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5KqF-00063J-KB
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 00:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbcEXWaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 18:30:08 -0400
Received: from pug.qqx.org ([50.116.43.67]:55615 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbcEXWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 18:30:07 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 May 2016 18:30:07 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
	id BC33D1D8B0; Tue, 24 May 2016 18:30:05 -0400 (EDT)
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Eric Wong <e@80x24.org>,
	Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
Content-Disposition: inline
In-Reply-To: <vpqshx77h9o.fsf@anie.imag.fr>
User-Agent: Mutt/1.6.1+70 (g71ac0c0) (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295539>

At 14:49 +0200 24 May 2016, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> What kind of help text would you want to see?
>>
>> Maybe something like this:
>>
>>   GIT: Quoted message body below.
>>   GIT: Feel free to trim down the quoted text
>>   GIT: to only relevant portions.
>>
>> As "GIT:" portions are ignored when parsed by `git send-email`.
>
>That's an option, but in the context of email, I think these
>instructions are not necessary.

In an ideal world that would be true.  But in the real world I think 
evidence of many messages to this mailing list containing full quotes 
suggests it might be helpful. I'd actually argue that the message be 
more forceful, making it a suggestion/request to trim rather than simply 
telling the user that it's allowed.
