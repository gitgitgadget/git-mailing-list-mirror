From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v3/RFC 1/2] Introduce functions from bash-completion project.
Date: Mon, 01 Nov 2010 09:35:07 -0400
Message-ID: <4CCEC20B.1020003@xiplink.com>
References: <1288471350-5392-1-git-send-email-peter@avirtualhome.com> <1288471350-5392-2-git-send-email-peter@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 14:35:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCuXN-00006J-3J
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 14:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903Ab0KANes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 09:34:48 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:34730 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab0KANej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 09:34:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp35.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 7147F2C83CA;
	Mon,  1 Nov 2010 09:34:38 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp35.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F2D452C83C6;
	Mon,  1 Nov 2010 09:34:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1288471350-5392-2-git-send-email-peter@avirtualhome.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160482>

On 10-10-30 04:42 PM, Peter van der Does wrote:
> The completion script does not work as expected under Bash 4.
> Bash: 3
> output:
> $ git log --pretty=<tab><tab>
> email     full      medium    raw
> format:   fuller    oneline   short
> 
> Bash: 4
> output:
> $ git log --pretty=<tab><tab>
> .bash_logout         .local/
> .bash_profile        Music/
> --More--
> 
> With Bash 4 the way word breaking is done in the programmable completion
> code has changed. The documentation at the bash project is not very
> clear what was changed, the only reference found is in the NEWS section:
> 
> i.  The programmable completion code now uses the same set of characters
> as readline when breaking the command line into a list of words.
> 
> The word breaking problem occurs with certain characters, like double
> colon and equal sign.

Nit: "double colon" is "::" -- the name of the character is just "colon".

		M.
