From: list@phuk.ath.cx
Subject: Re: git rm --cached and pull semantics
Date: Mon, 18 Jan 2010 03:31:27 +0100
Message-ID: <4B53C7FF.7060604@phuk.ath.cx>
References: <4B51EE39.3010401@phuk.ath.cx> <vpq1vhpufec.fsf@bauges.imag.fr>	<4B53941A.6020500@phuk.ath.cx> <86my0c5l9s.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 18 03:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWhPT-0003oI-1e
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 03:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0ARCbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 21:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855Ab0ARCbc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 21:31:32 -0500
Received: from xdsl-78-35-144-86.netcologne.de ([78.35.144.86]:40719 "EHLO
	horst.phuk.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab0ARCbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 21:31:31 -0500
Received: from [192.168.10.144] (wald.phuk.ath.cx [192.168.10.144])
	by horst.phuk.ath.cx (Postfix) with ESMTP id 9EA05249C68;
	Mon, 18 Jan 2010 03:31:16 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091230 Thunderbird/3.0
In-Reply-To: <86my0c5l9s.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137359>

On 01/18/2010 01:06 AM, Randal L. Schwartz wrote:
> The real WTF here is that you are using a workdir as your live dir.
>
> If you treat git as a *source* manager like it is, you'd also have an
> installer that would copy the resulting files into their live locations,
> and could be edited to either leave that newly untracked file alone,
> or deliberately remove it.
>
> Use git as intended, and you get no problems.
>
>   
Hm. Good point. I'll try to put that into some post-pull hook and see
how it works out. Thanks for the help.
