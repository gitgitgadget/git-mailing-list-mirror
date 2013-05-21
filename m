From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Tue, 21 May 2013 18:04:35 -0500
Message-ID: <CAMP44s1cbO-xzUAHR4THz4MPdqxY6SHG7uf_da_OM8YCDbTi+A@mail.gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
	<20130521224119.GF30969@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 22 01:04:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uevbk-0003Fh-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 01:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab3EUXEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 19:04:37 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:58312 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab3EUXEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 19:04:36 -0400
Received: by mail-lb0-f181.google.com with SMTP id w20so1430398lbh.12
        for <git@vger.kernel.org>; Tue, 21 May 2013 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jpVYsWil+ckclBXODIv01QQ3a2ptAMAglJPB4tjLVoM=;
        b=nRmcfiTz5ztJ6Lcw8hJ8lPDhiXxUtr7aOmFXOp1ey/bs3336tvLjpSKv1lHb56Fd6Y
         EKxyzUg7J+So8ChtU1PADdaa9D5EgC3DXxCuw7aanvuOmqEPPGdKK1O7QxmLbyDfnfpK
         QdmDjFSlfvgpqLX+wNkkeZL4iSVZ3F388fiUG8tEcDrOTxL2lDHTNsPdwAau/88ZVDsH
         Nu4REBsGwJvbFeNvBVxb3vk798A7hMCNXQESu2RgJAVlTvLa2hITGS/q+/qdEtka1dUf
         cEPp90iC3xRnlHy6BdL2+JfH76bnb6aSAnwq86xFGsvMoM9z/RkhjkbD3l8fQVCOLJ+L
         NO8Q==
X-Received: by 10.112.164.105 with SMTP id yp9mr93253lbb.103.1369177475090;
 Tue, 21 May 2013 16:04:35 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 16:04:35 -0700 (PDT)
In-Reply-To: <20130521224119.GF30969@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225092>

On Tue, May 21, 2013 at 5:41 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:

> On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote:
>> Currently the __git_ps1 git prompt gives the following error with a
>> repository converted by git-svn, when used with zsh:
>>
>>          __git_ps1_show_upstream:19: bad pattern: svn_remote[
>>
>> This was introduced by 6d158cba (bash completion: Support "divergenc=
e
>> from upstream" messages in __git_ps1), when the script was for bash
>> only.  Make it compatible with zsh.
>
> What is the actual cause of this problem/incompatibility and how/why =
do
> these changes fix it?

I think the commit message makes that very clear.

--=20
=46elipe Contreras
