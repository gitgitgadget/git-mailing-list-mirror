From: Kevin Daudt <me@ikke.info>
Subject: Re: Improving code base readability
Date: Sun, 3 May 2015 18:11:11 +0200
Message-ID: <20150503161111.GA28448@vps892.directvps.nl>
References: <CAKB+oNvB322hyX3UbGBPETDc0zEdC39PdeM=GG=rVf_WYGq_OA@mail.gmail.com>
 <20150501185946.GV5467@google.com>
 <CAKB+oNsYDL=iv8AqjoN_JqGTFf0_=f4nKa9_gcxHPLZO+rxmbA@mail.gmail.com>
 <CAKB+oNtUy12qumkE7VAe8_N6aHesJtMqpWNxi3M-7yOviE6BLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 18:11:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YowUF-0004Vt-R5
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 18:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbbECQLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 12:11:15 -0400
Received: from ikke.info ([178.21.113.177]:39847 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbbECQLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 12:11:13 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id C55651DCF6D; Sun,  3 May 2015 18:11:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAKB+oNtUy12qumkE7VAe8_N6aHesJtMqpWNxi3M-7yOviE6BLQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268267>

On Sat, May 02, 2015 at 08:15:45AM +0100, Alangi Derick wrote:
> I read the po/README and also the po/TEAMS and i can't find English
> there as a language. So what should i do or is it that the english in
> the error messages are not clear that i can work on?

The idea is to find error messages in the code base that are not marked
for translation. That is:

  error("Something is wrong"); 

should be:

  error(_("Something is wrong"));

This way, these strings will be extracted for the teams for translation.
There is no english because those messages are already in the code.
