From: Karl Brand <k.brand@erasmusmc.nl>
Subject: How to avoid the ^M induced by Meld and Git
Date: Tue, 11 Dec 2012 13:33:37 +0100
Message-ID: <50C72821.10908@erasmusmc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 13:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiPAP-0000EI-W4
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 13:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab2LKMmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 07:42:17 -0500
Received: from lists.erasmusmc.nl ([156.83.10.20]:61438 "EHLO
	lists.erasmusmc.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab2LKMmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 07:42:16 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2012 07:42:16 EST
Received: from lists.erasmusmc.nl (localhost [127.0.0.1])
	by lists.erasmusmc.nl (Postfix) with ESMTP id 91F44EB6A6C
	for <git@vger.kernel.org>; Tue, 11 Dec 2012 13:35:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at erasmusmc.nl
Received: from lists.erasmusmc.nl ([127.0.0.1])
	by lists.erasmusmc.nl (lists.erasmusmc.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ujx0IVWD2Hsl for <git@vger.kernel.org>;
	Tue, 11 Dec 2012 13:35:10 +0100 (CET)
Received: from rbox3.erasmusmc.nl (mailhost.erasmusmc.nl [156.83.10.13])
	by lists.erasmusmc.nl (Postfix) with ESMTP id 5E50DEB6A71
	for <git@vger.kernel.org>; Tue, 11 Dec 2012 13:35:10 +0100 (CET)
Received: from rbox3.erasmusmc.nl (localhost.erasmusmc.nl [127.0.0.1])
	by rbox3.erasmusmc.nl (Postfix) with ESMTP id 9F6306D442D
	for <git@vger.kernel.org>; Tue, 11 Dec 2012 13:33:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at erasmusmc.nl
Received: from rbox3.erasmusmc.nl ([127.0.0.1])
	by rbox3.erasmusmc.nl (rbox3.erasmusmc.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id K5-YM5xX_8XU for <git@vger.kernel.org>;
	Tue, 11 Dec 2012 13:33:38 +0100 (CET)
Received: from [10.92.2.214] (4JH5P4J.erasmusmc.nl [10.92.2.214])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: 117730)
	by rbox3.erasmusmc.nl (Postfix) with ESMTPSA id 7C5EB6D442A
	for <git@vger.kernel.org>; Tue, 11 Dec 2012 13:33:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211288>

Esteemed Git users,

What i do:

1. Create a script.r using Emacs/ESS.
2. Make some modifications to script.r with the nice diff gui, Meld
3. Commit these modifications using git commit -am "my message"
4. Reopen script.r in Emacs/ESS to continue working.

The lines added (&/edited ?) using Meld all end with ^M which i 
certainly don't want. Lines not added/edited with Meld do NOT end with ^M.

There are plenty of posts around about these being line endings used for 
windows which can appear when working on a script under a *nix OS which 
has previously been edited in a Windows OS. This is not the case here - 
everything is taking place on Ubuntu 12.04.

FWIW: the directory is being synced by dropbox; and in Meld, Preferences 
 > Encoding tab, "utf8" is entered in the text box.

Current work around is running in a terminal: dos2unix /path/to/script.r 
which strips the ^M's

But this just shouldn't be necessary and I'd really appreciate the 
reflections & advice on how to stop inducing these ^M's !

With thanks,

Karl

(re)posted here as suggested off topic at SO:
http://stackoverflow.com/questions/13799631/create-script-r-in-emacs-modify-with-meld-git-commit-reopen-in-emacs-m

-- 
Karl Brand
Dept of Cardiology and Dept of Bioinformatics
Erasmus MC
Dr Molewaterplein 50
3015 GE Rotterdam
T +31 (0)10 703 2460 |M +31 (0)642 777 268 |F +31 (0)10 704 4161
