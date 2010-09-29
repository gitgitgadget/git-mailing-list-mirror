From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Wed, 29 Sep 2010 09:20:39 +0200
Message-ID: <4CA2E8C7.4040100@viscovery.net>
References: <20100928222332.GA28859@soprano.nvidia.com> <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Aaron Plattner <aplattner@nvidia.com>, git@vger.kernel.org,
	jkain@nvidia.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 29 09:22:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0qzo-0001ZN-3u
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 09:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab0I2HUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 03:20:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64719 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751114Ab0I2HUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 03:20:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P0qxz-0005U2-Nw; Wed, 29 Sep 2010 09:20:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 72D031660F;
	Wed, 29 Sep 2010 09:20:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157538>

Am 9/29/2010 0:40, schrieb Brandon Casey:
> On 09/28/2010 05:23 PM, Aaron Plattner wrote:
>> Switching to a detached head prints something like
>>
>>   HEAD is now at 9d14017... dir.c: squelch false uninitialized memory warning
>>
>> These dots get selected when you double-click on the abbreviated
>> commit hash, which makes it annoying to copy and paste.
> 
> This must be another gnome-terminal/konsole "innovation".
> 
> xterm still does the "right thing"(tm) _and_ it doesn't eat my
> alt keystrokes like alt-b to move the cursor back a word. /rant

You must be running an xterm with settings from the stone ages. I had the
impression that modern installations have the selection configured such
that a file path can be selected with a mere double-click, without
dragging. For this, the dot must be in the same class as letters and
digits. Just for reference (I don't know how to read this):

$ appres XTerm | grep charClass
*charClass:     33:48,37:48,43:48,45-47:48,64:48,126:48,95:48

That said, I welcome this change, though I'd just have dropped ... or
replaced with a colon (preference for the second).

-- Hannes
