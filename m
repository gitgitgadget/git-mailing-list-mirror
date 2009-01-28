From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git clone ssh:// auth failiure
Date: Wed, 28 Jan 2009 10:06:55 +0000 (UTC)
Message-ID: <glpanv$fs5$1@ger.gmane.org>
References: <197294.49807.qm@web35708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 11:08:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS7LV-0006OJ-Pp
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbZA1KHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbZA1KHK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:07:10 -0500
Received: from main.gmane.org ([80.91.229.2]:33968 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbZA1KHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:07:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LS7K5-00033c-UI
	for git@vger.kernel.org; Wed, 28 Jan 2009 10:07:05 +0000
Received: from u-4-010.vpn.rwth-aachen.de ([137.226.100.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 10:07:05 +0000
Received: from heipei by u-4-010.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 10:07:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-4-010.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107520>

On 2009-01-28, Arya, Manish Kumar <m.arya@yahoo.com> wrote:
> root@dcb0:~# git clone ssh://localhost/~/testproject manish
You are aware that youre calling ssh as root, and that ssh will try to 
login to localhost as user "root"? A lot of sshd installations do not 
allow this by default.

> Permission denied 
> (gssapi-keyex,gssapi-with-mic,publickey,keyboard-interactive).
This is an ssh-error, has nothing to do with git

Greetings, Jojo (from a Nokia N810, yuk)

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
