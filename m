From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 13:15:17 +0100
Message-ID: <2F7A8304-A34E-4870-A877-EEBAC9D74EF9@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> <7vzlviymxw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 13:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBqvl-0007zA-Cz
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 13:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbYAGMRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 07:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbYAGMRs
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 07:17:48 -0500
Received: from mailer.zib.de ([130.73.108.11]:48382 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbYAGMRr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 07:17:47 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m07CEBYR016330;
	Mon, 7 Jan 2008 13:14:11 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m07CEApF013502
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 7 Jan 2008 13:14:10 +0100 (MET)
In-Reply-To: <7vzlviymxw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69787>


On Jan 7, 2008, at 11:00 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Per default, CRLF conversion is disabled in msysgit.
>
> That's interesting, as core.autocrlf was invented _specifically_
> for use on Windows.

My take on this is that is was invented for cross-platform projects.

But if you have a Windows-only project it does not make sense to
convert line endings.  Only if you plan to work on multiple
platforms, line ending conversion makes sense.  The most
conservative choice is to leave content unmodified.  This is true
for Windows, as it is for Unix.  Therefore, msysgit does not
modify your content unless requested otherwise.

	Steffen
