From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 21:27:09 +0200
Message-ID: <5069EE8D.6050200@nieuwland.nl>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org> <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org> <7v4nmec8fi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, s.oosthoek@xs4all.nl,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 21:35:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIlmI-0007hm-Hh
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 21:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab2JATfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 15:35:05 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:1288 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab2JATfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 15:35:03 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2012 15:35:02 EDT
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id q91JR9ZS009224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Oct 2012 21:27:10 +0200 (CEST)
	(envelope-from soosthoek@nieuwland.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7v4nmec8fi.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206761>

On 01/10/12 21:13, Junio C Hamano wrote:

> Hrm, let me ask a stupid question.  Why do we even need __git_ps1_pc
> in the first place?  Wouldn't it be just the matter of
> 
> 	PROMPT_COMMAND='__git_ps1 "%s"'
> 
> once you have __git_ps1 that works?

Apart from one small detail, PS1 must be set directly when __git_ps1 is
called as a PROMPT_COMMAND, while in command substitution mode,
__git_ps1 needs to put out a string value to substitute...

This is the way it works now (I'll send the patch later this week, I
want to test it some more...)

/Simon
