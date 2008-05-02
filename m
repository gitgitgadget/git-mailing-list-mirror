From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Fri, 2 May 2008 17:28:29 +0800
Message-ID: <46dff0320805020228v61c452f4y7f6c2e92cb9b4ea8@mail.gmail.com>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
	 <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 02 11:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrrZu-0001BO-8U
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 11:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888AbYEBJ2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 05:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757794AbYEBJ2b
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 05:28:31 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:46783 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbYEBJ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 05:28:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so291364and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SI1S28XxkaOVdmYTDeGdLUQRm4LIcyV6UoemoHnwgWk=;
        b=os2rlfiJfso0sNBd59C5ZAGZpDAw6Fgp9Leh6yoZ3KM1QHBKZ1BHWBNviaUYp+HZA30cSgbl8QbM1haEXQPLFFoWkrgB2EfhgStqchHDPlFqcPjjZ+pIspQbcQjcAgiF4z2IZErUfhPXyWdmGXv8cmN8V19GuwXEkOBqIeL6zkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=svTGt9qetUIzx1U5sUgF9rM8ZqhFZYusunJ5elhBqr/AfquHSLQbctXkliqsOuFjMM3EZImzAKBTPQQrcwKNwz2h1w21tcHcAGhlPFw8OTGxrQo/0z/r7mHvpAa15TkQH9s/frtl6558ERyXmShueiU62Mq81sh0S3Ncc3khGmk=
Received: by 10.100.33.4 with SMTP id g4mr4283127ang.128.1209720509752;
        Fri, 02 May 2008 02:28:29 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 02:28:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80973>

On Fri, May 2, 2008 at 3:45 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,

>
>  However, as Junio pointed out, it is easier to specify word-characters,
>  rather than non-word characters (think TAB), and...
>

We don't have to designate TAB. i think space characters should always
be word boundary.



-- 
Ping Yin
