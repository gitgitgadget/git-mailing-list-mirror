From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] git-gui: fix applying line/ranges when the selection
 ends at the begin of a line
Date: Sat, 14 Jan 2012 06:26:14 +0100
Message-ID: <CAKPyHN0tqQKuPONj_F9MXbgoHxeoZ7pFVSLPNWHddnA8340MGA@mail.gmail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
	<37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jan 14 06:26:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlw8C-00008n-9L
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 06:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab2ANF0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 00:26:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60211 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab2ANF0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 00:26:15 -0500
Received: by wgbds12 with SMTP id ds12so3764490wgb.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 21:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V0yso1ujwGliy93Mr46gHzFCDtRCyG04SyrLCoz8NvM=;
        b=Ftgb0YGzhJ5HUL8U06HGl4LwM8spxz8mkbyprrRZIk7XWknw9rKrGZzo3qOC2jzMdE
         2C+f1gU9SoVtksQMQUOC9BvyhdbnQtuqJLROY3+pdufbDudD9tDiUKTfIGt2aOwqWsvL
         K9vm5W942oPX5MMUvCr9OSEk1iyzkQBL7pDs4=
Received: by 10.180.75.7 with SMTP id y7mr6643643wiv.2.1326518774840; Fri, 13
 Jan 2012 21:26:14 -0800 (PST)
Received: by 10.223.118.10 with HTTP; Fri, 13 Jan 2012 21:26:14 -0800 (PST)
In-Reply-To: <37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188549>

Hi Pat,

On Mon, Jan 9, 2012 at 14:43, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Selecting also the trailing newline of a line for staging/unstaging would
> have resulted in also staging/unstaging of the next line.
>

same here, could you please consider pushing this into the 1.7.9
release. I see no point in waiting for the next release.

Thanks.

Bert
