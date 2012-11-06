From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4 clone @all error
Date: Tue, 6 Nov 2012 18:35:16 +0000 (UTC)
Message-ID: <loom.20121106T193301-775@post.gmane.org>
References: <1351593879401-7570219.post@n2.nabble.com> <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com> <20121103231305.GB11267@padd.com> <1352109747598-7570575.post@n2.nabble.com> <20121105221212.GA12003@padd.com> <20121106002515.5b7eba50@fenix.utopia.dhis.org> <1352192140569-7570622.post@n2.nabble.com> <loom.20121106T135442-279@post.gmane.org> <1352211607674-7570631.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 19:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVo05-0002TT-8C
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 19:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab2KFSff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 13:35:35 -0500
Received: from plane.gmane.org ([80.91.229.3]:48437 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab2KFSff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 13:35:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TVnzu-0002NX-7D
	for git@vger.kernel.org; Tue, 06 Nov 2012 19:35:38 +0100
Received: from 57.79.130.182 ([57.79.130.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 19:35:38 +0100
Received: from vitor.hda by 57.79.130.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 19:35:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.182 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209115>

Arthur <a.foulon <at> amesys.fr> writes:

> 
> In ~/.gitconfig i've :
> 
> [user]
>         name = Arthur
>         email = a.xxxxx <at> xxxxx.fr
> [git-p4]
>         branchList = MAINLINE:DEV_DATA
>         branchList = MAINLINE:RELEASE_1.0
>         branchList = MAINLINE:RELEASE_1.0.0
> 
> it's ok ?
> So :
> 
> /# git config  git-p4.branchList 
> MAINLINE:DEV_DATA
> error: More than one value for the key git-p4.branchlist:
> MAINLINE:RELEASE_1.0
> error: More than one value for the key git-p4.branchlist:
> MAINLINE:RELEASE_1.0.0/

You need to run "git config --get-all git-p4.branchList" to avoid those
warnings.

How does "git p4 clone //depot@all" behave with these options?

Vitor

P.S. - Please keep me in Cc:
