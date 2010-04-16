From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] format-patch: use current date in mbox 'From COMMIT
 DATE' header line
Date: Fri, 16 Apr 2010 08:52:51 +0100
Message-ID: <20100416075251.GA25147@arachsys.com>
References: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
 <20100415231945.GA20584@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 09:53:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2gMU-0003UD-R0
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 09:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab0DPHw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 03:52:58 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:53742 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101Ab0DPHw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 03:52:58 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2gMB-0001a4-Uo; Fri, 16 Apr 2010 08:52:56 +0100
Content-Disposition: inline
In-Reply-To: <20100415231945.GA20584@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145055>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Please no.  It is useful that format-patch generates the same output when
> run a few times in a row. If it is important to have a realistic date,
> would the commit date or similar work?

Yes, sure: s/time(NULL)/commit->date/ works equally well for me.

Best wishes,

Chris.
