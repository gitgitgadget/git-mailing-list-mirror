From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] git-bisect.txt: clarify that reset quits bisect
Date: Mon, 11 Feb 2013 00:39:49 -0800
Message-ID: <20130211083949.GQ15329@elie.Belkin>
References: <5118A5F2.6000007@drmicha.warpmail.net>
 <d679f620f10ad7afc044c9f5dadcf433b388ad10.1360571552.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Mohr <andi@lisas.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ow0-0004ZD-Be
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 09:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab3BKIj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 03:39:57 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:54977 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab3BKIj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 03:39:56 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so602744pbc.17
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 00:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fp8hmFcqMpCxsIrWtuxzaYVn/NhEe0UYiBOlB5EhZrY=;
        b=j6hG0IBQTqfbwMapghqKTTGiGJDb0PIJZC1cT2Od9B7AG0pnWGXd2wViaAvxrWECDW
         rD5v3cUGrGVkBj1MxRqbeL/rpfVDoV6EK0FfcaqcXr+N4GfAUzOtm93wwTU/jyiuiQBg
         KaP26Y/ry2yPWVQlK+7eqjzKDYfH1jq34Xdz/+A3GQ3JXRllHlZQjqF2V8zZfIbLrLdp
         MDMegmaAXvJ4O7MoSZ8yoGk/KfUT7XqO0NK8cDW6rfeCi8HosJQsG78Nz0eux+uT45YQ
         bkxi5XYIJcbd2X2DqAB+j3/gt9GoMWl46TID0YiU0VhdXhVBhqBW+jVs+OOAxLtuCFkO
         7Rrg==
X-Received: by 10.67.22.33 with SMTP id hp1mr2593810pad.3.1360571996505;
        Mon, 11 Feb 2013 00:39:56 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id r2sm4481876pbd.1.2013.02.11.00.39.54
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 00:39:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <d679f620f10ad7afc044c9f5dadcf433b388ad10.1360571552.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216025>

Michael J Gruber wrote:

> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
[...]
> @@ -284,6 +284,7 @@ EXAMPLES
>  ------------
>  $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
>  $ git bisect run make                # "make" builds the app
> +$ git bisect reset                   # quit the bisect session

I had forgotten that "git bisect run" ends in a bisecting state.
Good call.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan
