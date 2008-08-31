From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 01:35:31 -0400
Message-ID: <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
References: <20080830173947.GF7185@schiele.dyndns.org>
	 <20080830183413.GG7185@schiele.dyndns.org>
	 <20080830183949.GA16415@coredump.intra.peff.net>
	 <200808302237.17017.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Robert Schiele" <rschiele@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 07:36:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZfc7-00075Z-N8
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 07:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYHaFfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 01:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYHaFfd
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 01:35:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:10555 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbYHaFfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 01:35:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so820536yxm.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 22:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=V4CD4UUX+euCCoytvMks3SUGf0hzLSlqXdHW4WcZyak=;
        b=UWzSZ21Rl3jKeDtgXxJzgMImQzZaMk1jdxaGZvsnYCryFlObLAx+g7IhjvX33TeQLC
         XdnBO3H16XZYmAvwxjNCq//HbWrW8qMKJfXmZY3XvVWOJa7wEUz/IeohDNEdQX/tm0LR
         +pEx+qzbTluQ4/+i8L5adFg4D4Zg99lNmaD2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MGuw2TNJWAJSZOSvdmJqzQlWBiybT8GzhARKJAzk6zpJyCPmlNQCjb2MPsuzEIND0+
         tDVcuut4f0l2N5yzmrtnDrCDp99cvaI1iIs1owZ0mkHpWa5E3MjCw+fNs0HSW7eGVK/I
         W2JpkHJdieKC0rDADb0Rrq49JmGFcX2pAFmZs=
Received: by 10.150.204.12 with SMTP id b12mr2276129ybg.100.1220160931742;
        Sat, 30 Aug 2008 22:35:31 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Sat, 30 Aug 2008 22:35:31 -0700 (PDT)
In-Reply-To: <200808302237.17017.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94453>

On Sat, Aug 30, 2008 at 4:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Or you can use "open $fd, '-|'" to fork, an "manually" exec/system.

Shell quoting is a disaster (including security holes, where relevant)
waiting to happen.  The above is the only sane way to do it, and it
isn't very hard to implement.  (Instead of system() in the subprocess,
you can use exec().)

Have fun,

Avery
