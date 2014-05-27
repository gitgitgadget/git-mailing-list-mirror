From: Thomas Koch <thomas@koch.ro>
Subject: Best practices/conventions for tags and references in commit message
Date: Tue, 27 May 2014 13:26:35 +0200
Message-ID: <201405271326.36031.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 13:36:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpFgV-0002iq-0M
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 13:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbaE0Lgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 07:36:43 -0400
Received: from emita2.mittwald.de ([188.94.250.252]:25711 "EHLO
	emita2.mittwald.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaE0Lgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 07:36:42 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2014 07:36:42 EDT
Received: from mail5102.mymxserver.com (mail5102.internal [172.16.51.2])
	by emita2.mittwald.de (Postfix) with ESMTP id BD87B1B3A4C
	for <git@vger.kernel.org>; Tue, 27 May 2014 13:29:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.mx51.mymxserver.com (Postfix) with ESMTP id EC159318CF5
	for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:36 +0200 (CEST)
X-Virus-Scanned: by Mittwald Mailscanner
Received: from mail5102.mymxserver.com ([127.0.0.1])
	by localhost (mx51.mymxserver.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNM3S-659m0C for <git@vger.kernel.org>;
	Tue, 27 May 2014 13:26:36 +0200 (CEST)
Received: from koch.localnet (178-82-100-66.dynamic.hispeed.ch [178.82.100.66])
	(Authenticated sender: koch@comsolit.ch)
	by mail5102.mymxserver.com (Postfix) with ESMTP id C6417318D7B
	for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:36 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/3.14-0.bpo.1-amd64; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250162>

Hi,

different projects or tools have conventions to include machine parsable 
information in commit messages, e.g.:

Closes: #42
Thanks: my mother, my wife
Git-Dch: Ignore
Commit-Id: 50M3R34LLYR4ND0MB1TSANDNUMB3R5

(see thread: "RFE: support change-id generation natively" for Commit-Id)
("Git-Dch: Ignore" ecludes the commit from the changelog)

Are you aware of any convention or best practices for such tags that are used 
in more than one project? Are there more tags like these?

Maybe it would also be helpful to have some more plumbing support from Git for 
such tags. But I've not yet thought enough about this.

Best regards, Thomas Koch
