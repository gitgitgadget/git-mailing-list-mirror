From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC] Git Wiki Move
Date: Fri, 15 Jan 2010 16:05:26 -0800
Message-ID: <4B5102C6.3020709@eaglescrag.net>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> <fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com> <7vska7rkr0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwBD-00058D-P3
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758436Ab0APAGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758423Ab0APAGM
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:06:12 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:58634 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758409Ab0APAGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:06:11 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0G05QZI002243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 15 Jan 2010 16:05:27 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <7vska7rkr0.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 15 Jan 2010 16:05:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137168>

On 01/15/2010 03:50 PM, Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
>> On Sat, Jan 16, 2010 at 00:18, J.H. <warthog19@eaglescrag.net> wrote:
>>> Quick update - I think I've got the vast majority of the obvious and
>>> simple to correct problems fixed at http://git.wiki.kernel.org anyone
>>> want to run through and see if there's anything else that would be
>>> considered a show stopper?
>>
>> I'd say it's pretty embarassing if our FAQ [0] is broken.
> 
> Many "<<GitLink(foobar}}" in the FAQ page do seem like result of
> mechanical misconversion.
> 
> John, thanks for doing this.  If people fix things up manually, can they
> expect their fixes will be kept from now on, iow, the changes will not be
> overwritten by "Ok, I found a much better mechanical conversion tool and
> updated with the latest snapshot from the original wiki" in the future?

I have no intention of re-converting the data, so yes fixups will not be
squashed.  I've got a small bot script right now that if there's a
change that needs to happen pretty universally across the entirety wiki
it can be run (it's written in perl, reads in the page text, runs the
conversion and re-uploads it), so if there's something that's
particularly repetitive people can get me some code that would fix the
problem.

So again short answer: I'm at the point where I'd rather clean-up what
we've got then try and re-import the data.

- John 'Warthog9' Hawley
