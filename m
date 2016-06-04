From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Sat, 4 Jun 2016 14:14:58 +0900
Message-ID: <20160604051458.GA3149@glandium.org>
References: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
 <20160603232653.GA24538@glandium.org>
 <xmqqvb1pzvfu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 07:15:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b93va-00074R-NF
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 07:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbcFDFPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 01:15:15 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:36776 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbcFDFPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 01:15:13 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b93vG-0001OY-Ny; Sat, 04 Jun 2016 14:14:58 +0900
Content-Disposition: inline
In-Reply-To: <xmqqvb1pzvfu.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296442>

On Fri, Jun 03, 2016 at 04:47:33PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > In fact, the parser doesn't even reject the one that is considered
> > invalid (the first).
> 
> My question was what the desired behaviour is, and if your "fix"
> gives us that desired outcome.

>From my POV, the desired outcome from this patch series is that there is
no change of behavior, and Torsten's fix makes
git://[example.com:123]:/path/to/repo urls handled the same before and
after the patch series.

Whether that's the desired behavior is another topic, that we can,
IMHO, leave for later.

Mike
