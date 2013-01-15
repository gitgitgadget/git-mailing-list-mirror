From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore
 certain stat fields
Date: Tue, 15 Jan 2013 01:43:46 +0100 (CET)
Message-ID: <1620721033.2052381.1358210626868.JavaMail.root@dewire.com>
References: <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 01:44:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuudM-0005oU-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab3AOAns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:43:48 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:36538 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab3AOAns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:43:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 49274826D8;
	Tue, 15 Jan 2013 01:43:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AOR6JYJTIRbU; Tue, 15 Jan 2013 01:43:47 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id F01CB82688;
	Tue, 15 Jan 2013 01:43:46 +0100 (CET)
In-Reply-To: <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213550>


> Is this "the user edits in eclipse and then runs 'git status' from
> the
> terminal" problem?

Yes. Of course not just status, but any command that validates
the index. On Unix this is usually bearable, though slow, but on
Windows I often see git status take minutes (yes large files...).

-- robin
