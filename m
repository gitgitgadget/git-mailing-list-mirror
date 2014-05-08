From: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2 - the SAME on 12.04 server
Date: Thu, 08 May 2014 23:36:07 +0200
Organization: Fabio D'Alfonso
Message-ID: <536BF8C7.6010208@fabiodalfonso.com>
References: <536A8FF8.7080909@fabiodalfonso.com>
Reply-To: fabio.dalfonso@fabiodalfonso.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 00:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWty-0006R4-B1
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 00:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949AbaEHWet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2014 18:34:49 -0400
Received: from gateway15.websitewelcome.com ([70.85.130.11]:35743 "EHLO
	gateway15.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755808AbaEHWes (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2014 18:34:48 -0400
X-Greylist: delayed 2003 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2014 18:34:48 EDT
Received: by gateway15.websitewelcome.com (Postfix, from userid 5007)
	id 0D6682EC923FD; Thu,  8 May 2014 16:37:12 -0500 (CDT)
Received: from gator4050.hostgator.com (gator4050.hostgator.com [192.185.4.61])
	by gateway15.websitewelcome.com (Postfix) with ESMTP id E43112EC9237B
	for <git@vger.kernel.org>; Thu,  8 May 2014 16:37:11 -0500 (CDT)
Received: from [95.237.40.27] (port=13069 helo=[192.168.1.16])
	by gator4050.hostgator.com with esmtpa (Exim 4.82)
	(envelope-from <fabio.dalfonso@fabiodalfonso.com>)
	id 1WiW07-0005j4-AD
	for git@vger.kernel.org; Thu, 08 May 2014 16:37:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <536A8FF8.7080909@fabiodalfonso.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4050.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fabiodalfonso.com
X-BWhitelist: no
X-Source-IP: 95.237.40.27
X-Exim-ID: 1WiW07-0005j4-AD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.16]) [95.237.40.27]:13069
X-Source-Auth: fabio.dalfonso@fabiodalfonso.com
X-Email-Count: 1
X-Source-Cap: ZGFsZm9uc287ZGFsZm9uc287Z2F0b3I0MDUwLmhvc3RnYXRvci5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248459>

Hi,
strange that no one gets the error. I get also on another server 12.04.=
4=20
LTS so the problem is not on a single VM or version.

No idea?

=46abio D'Alfonso
'Enabling Business Through IT'
cell.  +39.348.059.40.22 ***
web: www.fabiodalfonso.com <http://www.fabiodalfonso.com/>
email: fabio.dalfonso@fabiodalfonso.com
<mailto:fabio.dalfonso@fabiodalfonso.com>linkedin:=20
www.linkedin.com/in/fabiodalfonso <http://it.linkedin.com/in/fabiodalfo=
nso>
twitter: www.twitter.com/#!/fabio_dalfonso=20
<http://www.twitter.com/#%21/fabio_dalfonso>

fax: +39.06.874.599.581
BlackBerry=C2=AE Wireless Enabled Address.


          ** Hidden  numbers are automatically rejected by the phone*

On 5/7/2014 9:56 PM, Fabio D'Alfonso wrote:
> Hi,
> I am getting this in Ubuntu, something wrong with my env?
> Thanks
>
> root@HDUBVM01:~/builds/git/t# ./t5539-fetch-http-shallow.sh
> ok 1 - setup shallow clone
> not ok 2 - clone http repository
> #
> #        git clone --bare --no-local shallow=20
> "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> #        git clone $HTTPD_URL/smart/repo.git clone &&
> #        (
> #        cd clone &&
> #        git fsck &&
> #        git log --format=3D%s origin/master >actual &&
> #        cat <<EOF >expect &&
> #    7
> #    6
> #    5
> #    4
> #    3
> #    EOF
> #        test_cmp expect actual
> #        )
> #
> not ok 3 - no shallow lines after receiving ACK ready
> #
> #        (
> #            cd shallow &&
> #            for i in $(test_seq 15)
> #            do
> #                git checkout --orphan unrelated$i &&
> #                test_commit unrelated$i &&
> #                git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
> #                    refs/heads/unrelated$i:refs/heads/unrelated$i &&
> #                git push -q ../clone/.git \
> #                    refs/heads/unrelated$i:refs/heads/unrelated$i ||
> #                exit 1
> #            done &&
> #            git checkout master &&
> #            test_commit new &&
> #            git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
> #        ) &&
> #        (
> #            cd clone &&
> #            git checkout --orphan newnew &&
> #            test_commit new-too &&
> #            GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/trace" git fetch=20
> --depth=3D2 &&
> #            grep "fetch-pack< ACK .* ready" ../trace &&
> #            ! grep "fetch-pack> done" ../trace
> #        )
> #
> httpd (pid 10653?) not running
> # failed 2 among 3 test(s)
> 1..3
>
