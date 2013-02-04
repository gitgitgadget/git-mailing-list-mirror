From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Sun, 3 Feb 2013 19:40:03 -0800
Message-ID: <20130204034002.GA6337@elie.Belkin>
References: <19086873.858651359944284535.JavaMail.weblogic@epml01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jongman Heo <jongman.heo@samsung.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 04:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Cv6-0006MQ-NK
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 04:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3BDDkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 22:40:14 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:38634 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab3BDDkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 22:40:12 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so2471179dae.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 19:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PZ5UZVV6IHYEmI+VoOybP+F+1LPC6Sj5t41gW/I7bRg=;
        b=N+0UaHVQXx1xpAJqugc58TA6hsQ4Y9oSz8AV89Ni6z8hNxtlZWmL3SDurVC/3k0bXT
         aZo2Etj1kwWtYUUT7wAb9soDUA6L9KGXuoeppOgaOZcSp3zG12VYa6pGjbv/WNO5sulU
         5VjRD/EwNtOegzGxO0Bzbe4uVvfOgrThjivyHo/oXRQ+M1hiSOyswLyAVnfMMISLV9kf
         5ydDAHOegzDRBQkVgTgQRW9PnK1jUPei5+H25OJGtKqo/+JLyaJQR55GP4uNxCzLXbsW
         y9lcRkvPVtYn7H3SA8HlNzABfohtJj2uP5DwnS27IKNQfOgvesASxfXLna6hBRdjBUM+
         LyHw==
X-Received: by 10.66.81.166 with SMTP id b6mr48276472pay.7.1359949211844;
        Sun, 03 Feb 2013 19:40:11 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id b3sm15147956pax.14.2013.02.03.19.40.09
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 19:40:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <19086873.858651359944284535.JavaMail.weblogic@epml01>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215354>

Jongman Heo wrote:

> Unfortunately, the patch didn't help to me.

Thanks for testing.  Did you apply the patch to the older version of
git that generates builtin/.depend/fetch.o.d or the newer version that
consumes it?

Curious,
Jonathan
