From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current
 directory.
Date: Thu, 06 May 2010 08:36:55 +0200
Message-ID: <4BE26387.1010904@viscovery.net>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain> <20100505005153.GC25390@coredump.intra.peff.net> <4BE115EF.8010306@viscovery.net> <20100505070131.GA11265@coredump.intra.peff.net> <19425.9169.537598.876589@winooski.ccs.neu.edu> <7v1vdql4c9.fsf@alter.siamese.dyndns.org> <19425.54504.163875.379151@winooski.ccs.neu.edu> <19425.58290.42871.986460@winooski.ccs.neu.edu> <1273098179.723.10.camel@dreddbeard> <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: wmpalmer@gmail.com, Eli Barzilay <eli@barzilay.org>,
	Jeff King <peff@peff.net>, Jared Hance <jaredhance@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 08:37:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9uht-0001Ka-0d
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab0EFGhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:37:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62855 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0EFGhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:37:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O9uhb-0005qH-QZ; Thu, 06 May 2010 08:36:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 794CB1660F;
	Thu,  6 May 2010 08:36:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146445>

Am 5/6/2010 1:43, schrieb Junio C Hamano:
> It probably is a good idea to switch aliases to start at the $cwd in 1.8.0
> (or perhaps one major release after it), and using a notation that is more
> descriptive, something like "!(cwd)" vs "!(root)", may give us a better
> transtion strategy than casting cryptic "!!" in the stone.

As always, we should start with the verbose tag, and if one turns out to
be used frequently, use !! for it as a shortcut.

> What other variants might we want to be able to specify while defining and
> using aliases?  If cwd vs root is the only distinction, then !(cwd) would
> be a bit overkill, but if we used !! for this new feature, I suspect that
> it would make it much harder to switch the default in the future.

The syntax should use a symbol that is less likely to appear at the start
of a shell script. Perhaps "!@cwd".

-- Hannes
