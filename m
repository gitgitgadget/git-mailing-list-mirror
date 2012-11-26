From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: git-gui: textconv not used on unstaged files
Date: Mon, 26 Nov 2012 21:28:02 +0100
Message-ID: <50B3D0D2.6060308@arcor.de>
References: <5088347F.50503@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 21:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5Hz-0003kC-Lz
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab2KZU2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:28:07 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:45943 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752246Ab2KZU2F (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2012 15:28:05 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 8685E5AE99
	for <git@vger.kernel.org>; Mon, 26 Nov 2012 21:28:03 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 8161F28B5C3
	for <git@vger.kernel.org>; Mon, 26 Nov 2012 21:28:03 +0100 (CET)
Received: from [10.0.0.2] (188-22-34-229.adsl.highway.telekom.at [188.22.34.229])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-14.arcor-online.net (Postfix) with ESMTPA id 48BF99CD2D
	for <git@vger.kernel.org>; Mon, 26 Nov 2012 21:28:03 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 48BF99CD2D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1353961683; bh=0GKA02bIEsp5ixfBSTjA/re8S0B9vqoApxuIyHoJGnc=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Yf95OywJfXoMs+90nakXhY8PGaW0hw5boLNrapuAgXSL8E8wu9ORkP9Ep/yxUywNc
	 +QBlTvTgj4WBRkuvpemT9aK/ckujuvdBvDL42BU3nxcrBPnr3Ifm/hqGMVK0Zt5iCJ
	 LfhTYpiY47yW3sVaNakhDDgzi+oAP8hvbBfMn0vU=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <5088347F.50503@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210480>

On 2012-10-24 20:33, Peter Oberndorfer wrote:
> Hi,
>
> i am using a textconv filter to display .doc files as plain text.
> It seems git gui does not use this textconv filter for displaying new unstaged files
> (other files? = _O)
> It seems diff.tcl start_show_diff calls show_other_diff because of this.
> This manually loads the file and does not care about textconv filters.
>
> Is this manual loading really necessary or can't we just ask git?
> If it is can it be modified to use the textconv filter?
>
Does anybody have a idea which git command
would output the diff of a untracked file against /dev/null?
So I can show the textconved version of the file in git gui.
(and not reinvent the code to apply textconv already in git)

Thanks,
Greetings Peter

>
> .gitattributes:
> *.doc    diff=astextplain
>
> gitconfig:
> [diff "astextplain"]
>     textconv = astextplain
