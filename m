From: Junio Hamano <junio@twinsun.com>
Subject: "git diff --summary --diff-filter=AD" without --stat does not work.
Date: Tue, 03 Oct 2006 12:15:52 -0700
Message-ID: <7v3ba5tdlj.fsf@dee.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 21:16:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUpkM-0000SP-Qm
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 21:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWJCTQC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 15:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWJCTQB
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 15:16:01 -0400
Received: from alcor.twinsun.com ([198.147.65.9]:48549 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id S1030371AbWJCTQA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 15:16:00 -0400
Received: from sic.twinsun.com ([192.54.239.17])
	by alcor.twinsun.com (8.13.4/8.13.4) with ESMTP id k93JFuul006459;
	Tue, 3 Oct 2006 12:15:56 -0700 (PDT)
Received: from pete.twinsun.com (pete.twinsun.com [192.54.239.43])
	by sic.twinsun.com (8.11.7p3+Sun/8.11.7) with SMTP id k93JFu103452;
	Tue, 3 Oct 2006 12:15:56 -0700 (PDT)
Received: from sic.twinsun.com ([192.54.239.17])
 by pete.twinsun.com (SMSSMTP 4.1.0.19) with SMTP id M2006100312155204083
 ; Tue, 03 Oct 2006 12:15:55 -0700
Received: from dee.twinsun.com (dee.twinsun.com [192.54.239.18])
	by sic.twinsun.com (8.11.7p3+Sun/8.11.7) with ESMTP id k93JFq103448;
	Tue, 3 Oct 2006 12:15:52 -0700 (PDT)
Received: from dee.twinsun.com (junio@localhost [127.0.0.1])
	by dee.twinsun.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id k93JFquW021276;
	Tue, 3 Oct 2006 12:15:52 -0700
Received: (from junio@localhost)
	by dee.twinsun.com (8.13.4/8.13.4/Submit) id k93JFqiT021275;
	Tue, 3 Oct 2006 12:15:52 -0700
X-Authentication-Warning: dee.twinsun.com: junio set sender to junio@twinsun.com using -f
To: junkio@cox.net
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28290>

I think it should only show create/delete notes and not even
diff text.
