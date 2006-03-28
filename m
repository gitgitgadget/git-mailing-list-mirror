From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] xdiff: Show function names in hunk headers.
Date: Tue, 28 Mar 2006 10:13:13 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne2i31p.s3g.mdw@metalzone.distorted.org.uk>
References: <11435126113456-git-send-email-mdw@distorted.org.uk> <7vfyl3m7vy.fsf@assigned-by-dhcp.cox.net> <7vvetykiel.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 28 12:13:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOBCT-00052o-3a
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 12:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWC1KNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 05:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWC1KNS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 05:13:18 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:19294 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932073AbWC1KNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 05:13:17 -0500
Received: (qmail 7931 invoked by uid 110); 28 Mar 2006 10:13:13 -0000
To: git@vger.kernel.org
Received: (qmail 7918 invoked by uid 9); 28 Mar 2006 10:13:13 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143540793 7903 172.29.199.2 (28 Mar 2006 10:13:13 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Tue, 28 Mar 2006 10:13:13 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18116>

Junio C Hamano <junkio@cox.net> wrote:

> Obviously I was not thinking.  That should at least be "any line
> that begins with a non-whitespace and has a few characters", to
> omit "{\n" and catch "int main()\n" in:

Heh!  I already got that one wrong last night.  Hence my more
complicated version. ;-)

-- [mdw]
