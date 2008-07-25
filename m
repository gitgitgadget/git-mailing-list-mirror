From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/9 v2] Allow the built-in exec path to be relative to
 the command invocation path
Date: Fri, 25 Jul 2008 10:38:50 +0200
Message-ID: <4889911A.4040204@viscovery.net>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <200807232112.18352.johannes.sixt@telecom.at> <7vd4l37vz7.fsf@gitster.siamese.dyndns.org> <200807242124.14583.johannes.sixt@telecom.at> <7v3aly5zz3.fsf@gitster.siamese.dyndns.org> <1216974722.48898f82e80d6@webmail.eunet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMIqC-0007Os-Pe
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbYGYIi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 04:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbYGYIi5
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:38:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5725 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbYGYIi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 04:38:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KMIp9-0007cT-C4; Fri, 25 Jul 2008 10:38:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 164DCAFCC; Fri, 25 Jul 2008 10:38:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1216974722.48898f82e80d6@webmail.eunet.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90013>

Johannes Sixt schrieb:
> Oh, I see: You tested it on Linux, right? This patch series does not work
> correctly on Linux (Unix? bash?), as Dscho has pointed out, since argv[0]

does not work correctly on Linux... *iff gitexecdir is relative*

> does not have a directory part if "git" is in $PATH. In this case, system_path()
> just returns its argument, which is the relative path. :-/

-- Hannes
