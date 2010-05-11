From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-gui disagrees with git status
Date: Tue, 11 May 2010 07:57:47 +0200
Message-ID: <4BE8F1DB.2060205@viscovery.net>
References: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com>	<20100510213926.GA7156@spearce.org> <buo632vj8px.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bill Winspur <bwinspur@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 11 07:57:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBiTd-0003w5-KU
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 07:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab0EKF5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 01:57:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27471 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754620Ab0EKF5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 01:57:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OBiTU-0004Nv-AT; Tue, 11 May 2010 07:57:48 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E8E971660F;
	Tue, 11 May 2010 07:57:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <buo632vj8px.fsf@dhlpc061.dev.necel.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146869>

Am 5/11/2010 7:41, schrieb Miles Bader:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> Its more a feature.
>>
>> git-gui shows all untracked files, recursively expanding any
>> directories which contain untracked files.  git status collapses
>> them up.
> 
> Wait, why is this a feature, exactly...?
> 
> It may be well known that git-gui works this way, but that doesn't make
> it good behavior for the user.

Oh, it *is* good behavior. Otherwise, it would not be possible to stage a
file that resides in a currently untracked directory; you would have to
fall back to 'git add' on the command line.

-- Hannes
