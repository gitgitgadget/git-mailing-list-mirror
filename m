From: janparadowski <janp617@gmail.com>
Subject: Re: [PATCH] Prevent space after directories in tcsh completion
Date: Tue, 1 Jul 2014 10:45:28 -0700 (PDT)
Message-ID: <1404236728065-7614312.post@n2.nabble.com>
References: <E59706EF8DB1D147B15BECA3322E4BDC06997E@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 19:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X227Y-0001hc-VE
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 19:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbaGARp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 13:45:29 -0400
Received: from sam.nabble.com ([216.139.236.26]:55294 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756327AbaGARp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 13:45:28 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <janp617@gmail.com>)
	id 1X227U-00066Q-2R
	for git@vger.kernel.org; Tue, 01 Jul 2014 10:45:28 -0700
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC06997E@eusaamb103.ericsson.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252730>

Hello

script works beautifully except for a small thing:

reporoot> ls 
 folder/ folder_file.txt

reproot> git commit fo<TAB>
completes to git commit folderSPACE without presenting the completion
options

(git diff fo<TAB> completes as expected to git diff folder and gives the 2
completion options)

is that easily fixable too?



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-Prevent-space-after-directories-in-tcsh-completion-tp7574444p7614312.html
Sent from the git mailing list archive at Nabble.com.
