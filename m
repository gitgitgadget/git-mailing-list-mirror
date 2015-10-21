From: Johan Laenen <johan.laenen+cygwin@gmail.com>
Subject: Re: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.
Date: Wed, 21 Oct 2015 05:34:20 +0000 (UTC)
Message-ID: <loom.20151021T073251-696@post.gmane.org>
References: <loom.20151020T131513-529@post.gmane.org> <vpq37x54vav.fsf@grenoble-inp.fr> <cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com> <xmqqr3kp8qqe.fsf@gitster.mtv.corp.google.com> <33632f538b4a406fb8f0e1eb2b016c43@EXMBNJE8.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 07:35:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zom35-0001eS-Sj
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 07:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbbJUFer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 01:34:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:60935 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbbJUFeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 01:34:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Zom2n-0001PQ-Hs
	for git@vger.kernel.org; Wed, 21 Oct 2015 07:34:37 +0200
Received: from 193.191.180.236 ([193.191.180.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 07:34:37 +0200
Received: from johan.laenen+cygwin by 193.191.180.236 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 07:34:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.191.180.236 (Mozilla/5.0 (Windows NT 6.1; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279968>

Enrique Tobis <Enrique.Tobis <at> twosigma.com> writes:

>  <at> Johan: how are you configuring your proxy? Git configuration or
environment variables? Also, could you


I'm just using the https_proxy environment variable, not the git configuration:

$ export https_proxy=http://<userid>:<pw>@myproxy:8080



Sorry for the multiple attemps at answering your questions, but the mailing
list keeps on complaining about spam :/
