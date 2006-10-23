From: David Lang <dlang@digitalinsight.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 15:28:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610231526510.7756@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>  <453A7D7E.8060105@utoronto.ca>
  <20061022074513.GF29927@artax.karlin.mff.cuni.cz>  <200610221105.26421.jnareb@gmail.com>
  <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> 
 <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
  <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 00:30:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8Jf-0001Zo-Eu
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 00:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWJWWaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 18:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWJWWaF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 18:30:05 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:42948 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751437AbWJWWaD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 18:30:03 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 23 Oct 2006 15:30:02 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 23 Oct 2006 15:29:19 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061023222131.GB17019@over-yonder.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29892>

On Mon, 23 Oct 2006, Matthew D. Fuller wrote:

>
> I don't understand the thrust of this, either.  As I understand the
> operation you're talking about, it doesn't have anything to do with a
> branch; you'd just be whipping the working tree around to different
> versions.  That should be O(diff) on any modern VCS.

on many modern VCS systems it's O(n) on the number of changes (start from where 
you are and apply the patch to change it to rev -1, then apply the patch to 
change it to rev -2, etc)

on git it's O(1) (write the new files into place)

David Lang
