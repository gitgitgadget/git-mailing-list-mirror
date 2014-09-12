From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [boinc_dev] (local ?) BOINC repo broken again -or- how to act
 on the CR/LF changes made upstream
Date: Fri, 12 Sep 2014 20:32:26 +0200
Message-ID: <54133C3A.4080700@gmx.de>
References: <541336D6.3050803@gmx.de> <1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: boinc_dev@ssl.berkeley.edu
To: Rom Walton <romw@romwnet.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 20:32:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSVe7-0002Ya-VB
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 20:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbaILScb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 14:32:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:62699 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbaILSca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 14:32:30 -0400
Received: from [192.168.178.21] ([78.54.159.21]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LvV1X-1YRSLn0cDb-010gyG; Fri, 12 Sep 2014 20:32:28
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
X-Provags-ID: V03:K0:Ixr7snah9uREpV+pwldlBQux+brU3/UTXULfgHpCEKICo1FNOH3
 p4c4jk4B5ez4TDuvTUX33kri/4R4fvO6aLP7MZNb6gMf3GbFuzERg7aJwBQgvpCOxjCp75w
 EbaaEb061kTptQHgtg2UXlhBTSJl2ApeLEFl0sn3PMA6vnis5Wlrxa3dxs9IS83y7uQO5d6
 csstW6sltIpBdQH1jDxYg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256938>

On 09/12/2014 08:19 PM, Rom Walton wrote:
> Try:
> git checkout -f master
> git pull origin
> 
> I committed fixes for that stuff this morning.

doesn't helped :

tfoerste@n22 ~/devel/boinc-v2 $ git checkout -f master
Already on 'master'
Your branch is behind 'origin/master' by 7 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

tfoerste@n22 ~/devel/boinc-v2 $ git pull origin
Updating ce97e85..d2e5582
error: Your local changes to the following files would be overwritten by merge:
        html/languages/translations/hu.po
        html/languages/translations/nl.po
        locale/bg/BOINC-Web.po
        locale/da/BOINC-Web.po
        locale/el/BOINC-Web.po
        locale/fr/BOINC-Web.po
        locale/hr/BOINC-Web.po
        locale/hu/BOINC-Project-Generic.po
        locale/hu/BOINC-Web.po
        locale/it_IT/BOINC-Project-Generic.po
        locale/lv/BOINC-Web.po
        locale/nl/BOINC-Project-Generic.po
        locale/nl/BOINC-Web.po
        locale/pl/BOINC-Web.po
        locale/pt_BR/BOINC-Web.po
        locale/ro/BOINC-Web.po
        locale/sk/BOINC-Web.po
        locale/zh_TW/BOINC-Web.po
Please, commit your changes or stash them before you can merge.
Aborting

-- 
Toralf
pgp key: 0076 E94E
