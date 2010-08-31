From: Eric Raible <raible@nextest.com>
Subject: RFH: is the current file available to a custom merge driver?
Date: Tue, 31 Aug 2010 11:52:19 -0700
Message-ID: <4C7D4F63.2060307@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqW1T-0005iq-Nc
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab0HaS5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:57:24 -0400
Received: from mail.nextest.com ([12.96.234.114]:22700 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496Ab0HaS5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 14:57:24 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2010 14:57:24 EDT
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Tue, 31 Aug 2010 11:52:19 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154963>

[Note: this is a resend - the initial attempt got no responses]

Hello All -

In writing a custom merge driver to support $dayjob
requirements I've failed to find a simple way of getting
the current file name that the driver is supposed to
be merging.

I of course have the "ancestor", "ours", and "theirs"
temporary files, but for Ui purposes I'd like to know
the filename as well.

As a workaround, I'm grepping for the git-hash-object
of %A (aka "ours) from the output of "git ls-tree -r HEAD".

I've examined the environment, and saw nothing relevant.
"git-ls-files -u" isn't useful, since the items aren't
unmerged yet.

Can anyone offer hints/help/tips?

Thanks - Eric

git version 1.7.0.2.msysgit.0
