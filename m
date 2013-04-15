From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 09:07:30 +0200
Message-ID: <516BA732.4080405@viscovery.net>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com> <7v38uvcrjl.fsf@alter.siamese.dyndns.org> <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com> <7vehed7ilu.fsf@alter.siamese.dyndns.org> <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com> <7vppxw335o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 09:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URdYr-0004Bc-Ao
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 09:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894Ab3DOHKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 03:10:40 -0400
Received: from so.liwest.at ([212.33.55.14]:3313 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881Ab3DOHKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 03:10:40 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1URdW2-0007UR-Hs; Mon, 15 Apr 2013 09:08:20 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 046401660F;
	Mon, 15 Apr 2013 09:07:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vppxw335o.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221195>

Am 4/15/2013 5:04, schrieb Junio C Hamano:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>> ...  In my proposal, the
>> precedence order branch.<name>.pushremote, remote.pushdefault,
>> branch.<name>.remote, remote.default, origin, remains the same: we
>> just want to change which branch that <name> refers to.
> 
> That "changing the meaning of <name>" in the middle, and doing so
> will be confusing to the users, is exactly the issue, isn't it?
> 
>> In my
>> opinion, it is a much more subtle change than the entirely new
>> precedence order that you're inventing.
> 
> Adding "--" has never been my itch. I just brought it up out of thin
> air as a possible alternative that is less confusing.

User says:

   git push -- master docs release

Then git pushes the three branches to three different upstreams. You find
that confusing. Do I understanding correctly so far?

If I were a push.default=(simple|upstream) type, then I would be totally
aware that there are three different upstreams involved because I had had
to configure them manually and explicitly (correct?), and I would be
completely surprised if the push would *not* go to three different upstreams.

Just my 2 cents. (But I'm a traditional "matching" type, so take this with
a grain of salt. Or I may be missing the point of this thread, as I
haven't followed closely.)

-- Hannes
