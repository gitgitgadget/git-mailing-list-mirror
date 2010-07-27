From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 15:35:54 +0000
Message-ID: <AANLkTin-x01FrFWLD04um8xwKeb6vUjpqlG0S7Xnk85j@mail.gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tong Sun <suntong@cpan.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 17:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdmCH-0002Em-1j
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 17:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab0G0Pf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 11:35:56 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45237 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0G0Pfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 11:35:55 -0400
Received: by qwh6 with SMTP id 6so786657qwh.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Xi5OAwHj3GpS1o789DOxlw9tYLj+uQpJDzsiL48sb0s=;
        b=PQyvaqXZqi7xzV7/MlYGs0wMczaEUTLtU43mfjZ3DZCpweNEyk3R8LbW0UpWMvzUB9
         VTcU7+YfFgcPaSAQeGFlxHbNMuH4umMHBlzeLGHha8oZh7TKHw/pB8SrHF3GYORyL0L0
         VgYRVfF90iu+0rdxqkQfS6SxnaZFp7VeZ34n4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BRkqeuTrU388Tie1zA+BWwEuQ8+EgkzxCIQSQ08yQwf6jHq83EyVWj5FPORtoAvNbt
         xiz+2Ah8SKilFg+dkrzZ8YU5/YYTb5/L0ZzhdQ14bLXy0AL3Fx/M+ju4gS4DsTc33ywK
         M7h0yvB8V6U2SOskhM8fFT4sKmwLYcfD1+ScU=
Received: by 10.224.80.2 with SMTP id r2mr7390563qak.380.1280244954386; Tue, 
	27 Jul 2010 08:35:54 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 08:35:54 -0700 (PDT)
In-Reply-To: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151949>

On Tue, Jul 27, 2010 at 15:31, Tong Sun <suntong@cpan.org> wrote:
> - work on the code, commit, hack, commit, hack, commit -- commit often
> & commit small

So far so good.

> - when AOK and need to integrate patches into main branch, squash all
> patches into one

That's just silly. Why is the policy to destroy commit information
when submitting patches?
