From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: =?ISO-8859-15?Q?=5BBUG=3F=5D_git_log_does_not_decorate_when_cust?=
 =?ISO-8859-15?Q?om_format_is_used?=
Date: Wed, 20 Aug 2008 14:25:30 +0200
Message-ID: <1KVmkk-2IOrGi0@fwd26.aul.t-online.de>
Reply-To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 14:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVn3I-0003bD-Tv
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 14:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbYHTMm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 08:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbYHTMm4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 08:42:56 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:32933 "EHLO
	mailout10.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbYHTMmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 08:42:55 -0400
X-Greylist: delayed 1023 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Aug 2008 08:42:55 EDT
Received: from fwd26.aul.t-online.de 
	by mailout10.sul.t-online.de with smtp 
	id 1KVmkx-00074z-04; Wed, 20 Aug 2008 14:25:43 +0200
Received: from localhost (ZqF16MZDwhxQZM3QPuifjziImIaXjaSlmHJM86QwzLskjCTwl+Xthig4ORBLpbLZ8V@[172.20.101.250]) by fwd26.aul.t-online.de
	with esmtp id 1KVmkk-2IOrGi0; Wed, 20 Aug 2008 14:25:30 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-2-10
X-ID: ZqF16MZDwhxQZM3QPuifjziImIaXjaSlmHJM86QwzLskjCTwl+Xthig4ORBLpbLZ8V@t-dialin.net
X-TOI-MSGID: 0d716de9-865c-4a0d-9a77-400ff0478b28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92984>

Hi,

is it a bug?

When I use something like:
git log --pretty=format:'%H %s' --decorate
I do not get the decoration.
While 
git log --pretty=oneline --decorate
does decorate.

I'm using:
git version 1.5.6.1

Cheers,
Michael
