From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: how to clone all branches include remote branches
Date: Tue, 10 Feb 2009 18:05:42 +0000 (UTC)
Message-ID: <gmsflm$sd4$1@ger.gmane.org>
References: <95463c700902100949w23a95536re9a65a2e5c3c0b5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 19:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWx11-0006Tk-EU
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 19:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbZBJSF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 13:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZBJSFz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 13:05:55 -0500
Received: from main.gmane.org ([80.91.229.2]:42764 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbZBJSFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 13:05:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWwzY-0008JX-BT
	for git@vger.kernel.org; Tue, 10 Feb 2009 18:05:52 +0000
Received: from u-5-128.vpn.rwth-aachen.de ([137.226.101.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 18:05:52 +0000
Received: from heipei by u-5-128.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 18:05:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-5-128.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109285>

On 2009-02-10, gnu kevin <kevin.gnu.zhang@gmail.com> wrote:
> I'd like to know how to get all remote(grandparent) branches by clone
> a remote repo . for example:
> remote repo ABC contains below branches:
> master
> stable/main
> dev/main

You could (if your .git/config) already contains the remote simply add a 
line:
fetch = +refs/remotes/*:refs/remotes/<remote-name>/remotes/*

The double remotes is used so that no remote-remote-branch can overwrite 
your tracking branch with the same name.

Hope that helped,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
