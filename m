From: <Tillmann.Crueger@telekom.de>
Subject: Git submodules with usernames in the URL
Date: Tue, 14 Feb 2012 14:26:56 +0100
Message-ID: <E76DF6102FDBC04BA291EAE9A3BAECB50137C2AC6530@HE111540.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 14:37:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxIZs-0000oD-6K
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 14:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600Ab2BNNhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 08:37:46 -0500
Received: from tcmail53.telekom.de ([217.5.214.110]:22704 "EHLO
	tcmail53.telekom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2BNNhq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 08:37:46 -0500
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Feb 2012 08:37:45 EST
Received: from he101251.emea1.cds.t-internal.com ([10.125.92.154])
  by tcmail51.telekom.de with ESMTP/TLS/AES128-SHA; 14 Feb 2012 14:26:59 +0100
Received: from HE111540.emea1.cds.t-internal.com ([169.254.1.127]) by
 HE101251.emea1.cds.t-internal.com ([fe80::e428:2144:dcc5:bcce%15]) with mapi;
 Tue, 14 Feb 2012 14:26:58 +0100
Thread-Topic: Git submodules with usernames in the URL
Thread-Index: AczrHFOrphNBkVZ4QSST3NkrecctYQ==
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190722>

Hi,

I already had a look at the mailinglist archive, but I could not find any mention of this problem. There is a posting on Stackoverflow.com about this (http://stackoverflow.com/questions/7714326/git-submodule-url-not-including-username) with a workaround, but it would nice to have an official position.

Here is the problem:

When I am using git-submodule over an authorized https it is convenient to be able to specify the username directly in the url in the form https://user@domain.com/path/to/repo. So I am able to do a 

> git submodule add https://user@domain.com/path/to/repo

Howver if I do this, the username becomes baked into the URL of the submodule, so other people working with the repository will not be able to use the submodule and have to change the URL first.

Is there an actual rationale for including the username in the URL in this case, or is this just because it is simpler than removing it?

One thing I noticed, is that automatically removing it would basically eliminate the convinience for the person who has been using that URL in the first place. If the username was removed every update would have to query the username again. Also having a username in the repo could be correct, in case this isn't a real user, but a role for using that repository.

Still I feel that having a username within a repository is hardly ever what someone wants and most often a mistake. For now I will try to educate everybody about this and fix all repositories where this goes wrong, but a better solution would be nice to have.

Thanks for your time,
  Till
