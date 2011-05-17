From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Windows permissions with repository on a network share
Date: Tue, 17 May 2011 17:25:28 +0200
Message-ID: <iqu417$qnj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 17:25:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMM9Y-0005y4-Tk
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab1EQPZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 11:25:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:33859 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120Ab1EQPZi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 11:25:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QMM9R-0005tY-Ay
	for git@vger.kernel.org; Tue, 17 May 2011 17:25:37 +0200
Received: from 92.103.70.98 ([92.103.70.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2011 17:25:37 +0200
Received: from t2a2e9z8ncbs9qg by 92.103.70.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2011 17:25:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 92.103.70.98
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173805>

Hello,

Did anyone experiment with Windows permissions for a Git repository=20
located on a Windows network share?

Is it a sensible scheme in order to have a central repository with ACLs=
=20
(notably some group can read/write, some other group can only read)=20
without the need to set up a dedicated server (ala Gitolite) ?
(Assuming a Windows network share infrastructure is already in place...=
)

TIA
J=E9r=F4me
