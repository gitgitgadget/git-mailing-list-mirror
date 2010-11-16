From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: Add colors to the prompt for status indicators
Date: Tue, 16 Nov 2010 09:11:14 +0100
Message-ID: <AANLkTimpyug867ccsKA+fLjzDJ8NukQXcPnVJw3Uk4LD@mail.gmail.com>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com>
 <4CE04B82.1040804@pileofstuff.org> <19363118-D147-4946-8973-B5DDA4B00985@sb.org>
 <F7A9874A-738C-4BEA-8EDF-0ED1FA7D6ACF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 09:12:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIGe0-000470-Pw
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 09:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759475Ab0KPIL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 03:11:56 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56479 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759389Ab0KPILz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 03:11:55 -0500
Received: by iwn35 with SMTP id 35so508910iwn.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 00:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ANj5A3UZnqv3h3h7RggP3HLaJsccymaZ5nPc6ANiG3g=;
        b=I+cxelWnehcXmTpZgxsuVvxZQwNHNAD/FaKWsufjqeNI2JwR/vaqo6SGr8L8vRSkL3
         1nWrv1kYn3y5DHzcanjbrWxegrfDwQxFlRJ8+7oPGY0BWg8Kiu96W518ur/LT/rK/fua
         rZM6hOOJgTLJTwmQwuYLUXY3b3Y6PxBIMVTBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qwYh/LXpST7URagfKMiByKjRrUqNbFYJ245D/2Ca1SXROQi+0U2i5NO6vKWdHJTKne
         IsyU5AtIY/duHBj4t1gFJ/NN0DwrsYZ92ByGeHXxnY2AAk9PZ/maN+i66Isj22u77n62
         g27acknU+tQsaoNsGLNkWyiQrPX5OTcA9y4cE=
Received: by 10.231.33.205 with SMTP id i13mr5328128ibd.59.1289895114178; Tue,
 16 Nov 2010 00:11:54 -0800 (PST)
Received: by 10.231.174.20 with HTTP; Tue, 16 Nov 2010 00:11:14 -0800 (PST)
In-Reply-To: <F7A9874A-738C-4BEA-8EDF-0ED1FA7D6ACF@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161548>

On Tue, Nov 16, 2010 at 00:14, Kevin Ballard <kevin@sb.org> wrote:
> I take it back. We can use PROMPT_COMMAND for this, to set up variables
> containing what you want.
>
> Something like the following should work:

Hi Kevin,
good job! I looked the git prompt and I'm a bit disappointed with the
combination, ps1 can show many items:

#
%
+
*
$
REBASE-i|
REBASE-m|
MERGING|
BISECTING|
< > <> (or u+count u-count u+countu-count)

Each item is "optional", so you can have REBASE-i| with * and +, or
only *. It seems to complicated to wrap all items (I think of the
verbose mode for upstream branches). Maybe coding a lua (or Python)
prompt with a config file.


-- 
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche (agile, lean, python, git, open source)
