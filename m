From: Girish Ramakrishnan <girish@forwardbias.in>
Subject: [BUG?] ls-files -d does not show files removed using 'git rm'
Date: Fri, 22 Aug 2008 21:29:29 +0530
Message-ID: <48AEE261.8070906@forwardbias.in>
Reply-To: girish@forwardbias.in
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 18:00:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZ3z-0005AQ-69
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbYHVP73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbYHVP73
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:59:29 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:23852 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYHVP72 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:59:28 -0400
Received: by ti-out-0910.google.com with SMTP id b6so328138tic.23
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 08:59:26 -0700 (PDT)
Received: by 10.110.84.2 with SMTP id h2mr1423274tib.53.1219420766151;
        Fri, 22 Aug 2008 08:59:26 -0700 (PDT)
Received: from ?192.168.2.100? ( [121.243.191.102])
        by mx.google.com with ESMTPS id y5sm3570730tia.8.2008.08.22.08.59.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 08:59:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93317>

If I remove a file using the shell rm, it is listed by ls-files -d.
However, it is not listed if I use 'git rm'.

$ rm foo
$ git ls-files -t -d
R foo
$ git checkout foo
$ git rm foo
rm 'foo'
$ git ls-files -t -d
$

Is this a bug? In any case, is there a way to find out what files have
been removed using git rm using ls-files (git status does show it)?

Girish
