From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Problem packing repository
Date: Mon, 22 Jun 2009 08:30:17 +0200
Message-ID: <4A3F24F9.2060502@viscovery.net>
References: <4A3EF989.4070101@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 08:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MId32-0002yC-DG
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 08:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZFVGaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 02:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbZFVGaR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 02:30:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32887 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZFVGaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 02:30:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MId2n-0003Rc-Cd; Mon, 22 Jun 2009 08:30:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 27EC7C6C1; Mon, 22 Jun 2009 08:30:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A3EF989.4070101@lwfinger.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122012>

Larry Finger schrieb:
> For the past 2 weeks, every pull from the mainline kernel repository
> has included the following message about "Auto packing" that fails to
> complete.
> 
> git --version yields "git version 1.6.3.2.198.g6096d"
> 
> ================================================
> 
> Auto packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> usage: git-pack-objects [{ -q | --progress | --all-progress }]
>         [--max-pack-size=N] [--local] [--incremental]
>         [--window=N] [--window-memory=N] [--depth=N]
>         [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
>         [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]
> [--reflog]
>         [--stdout | base-name] [--include-tag]
>         [--keep-unreachable | --unpack-unreachable]
>         [<ref-list | <object-list]
> error: failed to run repack

I'm pretty sure that you have inconsistent versions of git in your PATH.
You can use GIT_TRACE=2 to debug this. I think that you should get the
same error if you run 'git gc' manually.

-- Hannes
