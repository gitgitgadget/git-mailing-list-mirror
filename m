From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in
 	the case of conflicts.
Date: Fri, 02 Apr 2010 10:37:39 +0200
Message-ID: <4BB5ACD3.10307@viscovery.net>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>	 <4BB2F7A0.6020702@viscovery.net>	 <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>	 <4BB3346C.7070700@viscovery.net>	 <t2u2cfc40321003310523u8fda9baeo883d2e0b3c6fa807@mail.gmail.com>	 <4BB3534E.3080803@viscovery.net> <v2z2cfc40321003311252s86d44ad7l540559eafb0636d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 10:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxcNx-00067r-Iq
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 10:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab0DBIhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 04:37:45 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:12110 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752251Ab0DBIhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 04:37:42 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ED7F02C4050;
	Fri,  2 Apr 2010 10:37:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <v2z2cfc40321003311252s86d44ad7l540559eafb0636d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143799>

Am 31.03.2010 21:52, schrieb Jon Seymour:
> I agree that removing the options is better than preserving the
> current behaviour,

So, we are in agreement in this. Suppose we do remove them. What remains 
that is dangerous?

The user has no option to accidentally revert changes that are not 
displayed even if the current diff --cc remains. The user is forced to run 
mergetool or to go to the editor.

It is now an orthogonal matter whether diff --cc is helpful. Here I do 
agree somewhat that diff against HEAD is more helpful than the current 
diff --cc.

> I would imagine that a change that proposed to remove the actions,
> without an option to enable them, would encounter stiff resistance
> from the list. However, perhaps the list can respond?

Who knows? There was not a lot discussion when the feature was presented 
to the list, not even a word of excitement.

http://thread.gmane.org/gmane.comp.version-control.git/94425/focus=94426

-- Hannes
