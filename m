From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH 4/4] diff.c: convert builtin funcname patterns to extended
 regular expressions
Date: Thu, 18 Sep 2008 12:15:51 +0200
Message-ID: <48D22A57.7070300@isy.liu.se>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org> <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil> <200809181039.46954.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 12:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgGZU-0001sk-Vv
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 12:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbYIRKP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 06:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbYIRKP5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 06:15:57 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:59450 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbYIRKP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 06:15:56 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id E9A9B25A44;
	Thu, 18 Sep 2008 12:15:53 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 24942-04; Fri,  4 Jul 2008 02:08:55 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 576F925A41;
	Thu, 18 Sep 2008 12:15:53 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <200809181039.46954.johan@herland.net>
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96189>

On 09/18/2008 10:39 AM, Johan Herland wrote:
> On Thursday 18 September 2008, Brandon Casey wrote:
>> This is a blind conversion removing \\ before ( and { etc.
>> and adding \\ before naked ( and { etc.
>>
>> I hope the authors who last touched these patterns will help with
>> testing:
>>
>> bibtex: Johan Herland
> 
> This was moved by Junio when he applied my patch; the line was originally 
> written by Gustaf Hendeby in 23b5beb28fdadbb1d80ebf686a35385609f7a180

I'm on the road the rest of this week and don't have access to a
suitable machine for testing until I get back.  Will put testing this on
the list of things to do for Monday.  The patch looks good, though, but
I haven't actually tested it.

/Gustaf
