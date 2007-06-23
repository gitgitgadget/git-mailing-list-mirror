From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Teach rebase an interactive mode
Date: Sun, 24 Jun 2007 01:33:42 +0200
Message-ID: <81b0412b0706231633yd0f19e8xbb0b7004fd7f75ef@mail.gmail.com>
References: <Pine.LNX.4.64.0706240001150.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 01:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2F6v-0000uO-Q8
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 01:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbXFWXdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 19:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbXFWXdo
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 19:33:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:27434 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbXFWXdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 19:33:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1052564ugf
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 16:33:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mRwm5mpmGDjX1nvogaTn+B5SqWlTeYihTxsNEB7UCfUy3wE1jmTknURXBsIx1R0XnIDAnePHViMiFKpiHks6/bNImxN7sfonuufIyXGke6Bx2p07dBGZo/kyhVZAD8J9i4SuzaWZXwS/HlBwZN+EqqQ5yhN5V3wfNiExaxmUMwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVII6DiuIXocpmA2BrjPqne7dR99Y7Z6icSipHtxOOoYqJ6WfWuxqAY6vhwB8GaiCgqEoJcZFO2MpUsR568hWZ0tI/RYY5I7N5IZyZAyqbZsGoIxTYsLDfuTc1pU1VOenzEeHfG5WpsiwZ7o4RTKhIwEzHmdxJuKa3j+ByqEFnA=
Received: by 10.78.153.17 with SMTP id a17mr2055421hue.1182641622466;
        Sat, 23 Jun 2007 16:33:42 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Sat, 23 Jun 2007 16:33:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706240001150.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50759>

On 6/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> +If you want to fold two commits into one, just replace the command "pick"
> +with "squash" for the second commit.  After squashing the commits,

Can I fold 3 commits into one? 4 and 5?
