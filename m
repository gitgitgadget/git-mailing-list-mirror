From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: Count the line of codes
Date: Fri, 6 Feb 2009 08:23:26 +0000 (UTC)
Message-ID: <gmgs1u$lsv$1@ger.gmane.org>
References: <21868069.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 09:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVM1J-0003tC-Ho
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 09:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbZBFIXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 03:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbZBFIXi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 03:23:38 -0500
Received: from main.gmane.org ([80.91.229.2]:45355 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbZBFIXh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 03:23:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVLzs-0004dG-OT
	for git@vger.kernel.org; Fri, 06 Feb 2009 08:23:36 +0000
Received: from u-4-171.vpn.rwth-aachen.de ([137.226.100.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 08:23:36 +0000
Received: from heipei by u-4-171.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 08:23:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-4-171.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108664>

On 2009-02-06, zyk <zhengyuk@hotmail.com> wrote:
>
> Does anyone know if there is any tools available for counting the line of
> codes in the project using GIT?

wc -l *.c *.h for example would count the lines of all c-files and 
their headers.

> How to count the code changes on the specific branch?
> How to count the delta lines between one tag and its successive tag?

git diff tag~..tag --stat

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
