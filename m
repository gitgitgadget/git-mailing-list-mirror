From: Arthur <a.foulon@amesys.fr>
Subject: Re: git-p4 clone @all error
Date: Tue, 6 Nov 2012 06:20:07 -0800 (PST)
Message-ID: <1352211607674-7570631.post@n2.nabble.com>
References: <1351593879401-7570219.post@n2.nabble.com> <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com> <20121103231305.GB11267@padd.com> <1352109747598-7570575.post@n2.nabble.com> <20121105221212.GA12003@padd.com> <20121106002515.5b7eba50@fenix.utopia.dhis.org> <1352192140569-7570622.post@n2.nabble.com> <loom.20121106T135442-279@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 15:20:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVk0u-0005xz-EG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 15:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab2KFOUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 09:20:09 -0500
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:50516
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab2KFOUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 09:20:08 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <a.foulon@amesys.fr>)
	id 1TVk0d-0006b0-M4
	for git@vger.kernel.org; Tue, 06 Nov 2012 06:20:07 -0800
In-Reply-To: <loom.20121106T135442-279@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209112>

In ~/.gitconfig i've :


[user]
        name = Arthur
        email = a.xxxxx@xxxxx.fr
[git-p4]
        branchList = MAINLINE:DEV_DATA
        branchList = MAINLINE:RELEASE_1.0
        branchList = MAINLINE:RELEASE_1.0.0

it's ok ?
So :

/# git config  git-p4.branchList 
MAINLINE:DEV_DATA
error: More than one value for the key git-p4.branchlist:
MAINLINE:RELEASE_1.0
error: More than one value for the key git-p4.branchlist:
MAINLINE:RELEASE_1.0.0/



--
View this message in context: http://git.661346.n2.nabble.com/git-p4-clone-all-error-tp7570219p7570631.html
Sent from the git mailing list archive at Nabble.com.
