From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] git-cvsserver: run post-update hook *after* update.
Date: Thu, 29 Jan 2009 22:56:29 +0000
Message-ID: <200901292256.30239.andyparkins@gmail.com>
References: <7viqo61mfq.fsf@gitster.siamese.dyndns.org> <1233266282-8010-1-git-send-email-stefan.karpinski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:58:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfpt-0007ks-H4
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbZA2W4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbZA2W4r
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:56:47 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:52663 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbZA2W4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:56:47 -0500
Received: by ewy14 with SMTP id 14so417931ewy.13
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=03d6y7CdOrAvJ2SrIHPbRUzktpNiRTzuf+Lf8vV+ncI=;
        b=KcFsL1B/oQZjpABggKmB1SUoUe7yL1Z6rIo6djTStdoewfRovh8r2UOIXNaZij3cKw
         4Dx8L5Gp6eJEuoQjiN6gjpwspWavt51clZO/hzSJ5a65NmFhG+vrFAmFyqcuxmNF1s8q
         zmGyRPVTKo2qBnd/c1EXquoK1ZLCG1mjekUeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OFUyRlmntBJhRdkKcBTOCSHq/HtjMwN8YATyk/RHGXPxKj4Somo6d5ZPe8XSeF5PUO
         GgmiK+cg81qrtM2TVcnnOX1FaMxzW3Svmq+V31tUjvA8O70rnEqhR4cRrK0uqC2q0zh5
         loSaUHMuM0mZhDu1ZpFFUm91hiLxUEgxCe6i0=
Received: by 10.67.123.1 with SMTP id a1mr1323204ugn.42.1233269805247;
        Thu, 29 Jan 2009 14:56:45 -0800 (PST)
Received: from grissom.localnet ([91.84.15.31])
        by mx.google.com with ESMTPS id 31sm16496ugg.8.2009.01.29.14.56.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 14:56:44 -0800 (PST)
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-686; KDE/4.2.0; i686; ; )
In-Reply-To: <1233266282-8010-1-git-send-email-stefan.karpinski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107747>

On Thursday 29 January 2009 21:58:02 Stefan Karpinski wrote:

> This patch would affect only users in case 3. These users are
> depending on fairly obviously wrong behavior, and moreover they can
> simply change their current post-update into post-recieve hooks,
> and their systems will work correctly again.

Quite right.

>
> Signed-off-by: Stefan Karpinski <stefan.karpinski@gmail.com>
Acked-By: Andy Parkins <andyparkins@gmail.com>

-- 
Dr Andy Parkins
andyparkins@gmail.com
