From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 21:20:21 +0200
Message-ID: <94a0d4530901211120o4d06c813l3abf86c657a7ee16@mail.gmail.com>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
	 <49773240.7090605@drmicha.warpmail.net>
	 <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
	 <49773E48.90302@drmicha.warpmail.net>
	 <20090121161940.GA20702@coredump.intra.peff.net>
	 <94a0d4530901211031s18261776rf8abfddcdcb42402@mail.gmail.com>
	 <20090121191619.GE21686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:21:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPie4-0006vq-25
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbZAUTUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbZAUTUX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:20:23 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:25741 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbZAUTUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:20:23 -0500
Received: by ey-out-2122.google.com with SMTP id 22so709483eye.37
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SUJeihq5KInseezzxBXaQi8igsu2TfWRcDky6XGCdzQ=;
        b=uXTHogDe47OLFP9aPZAE2UfHBHWO75Zuw11fDNGEjVHGA1cf7ALGqLUEUyYTw6tYpz
         dYlg/E8Tghq0DuLbTH4RD4yqAqtMrIaJRfPI8JEg5UrqzJ56TwutC3O2FiOpSshXgLzq
         amZX0mGovv3+uotDtWC88f61RgSv5Ui3FPPGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wXuzsVYPLjmp2/qtHkQPLThSEWYqJAfbIArXORnvtPrMXe+OysEJH10WdtYJDAwwgK
         iTQZzeQ5yQxgbSSGgyIyDaCZb5WfDZXKv4psBb7ipGs4fLxRYagPbq9iB1zYWAcWLSKW
         +QWGTIfcDIpOJ1H9ZygttLSREbxLBrUllvChE=
Received: by 10.86.51.10 with SMTP id y10mr648654fgy.51.1232565621104; Wed, 21 
	Jan 2009 11:20:21 -0800 (PST)
In-Reply-To: <20090121191619.GE21686@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106651>

On Wed, Jan 21, 2009 at 9:16 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 21, 2009 at 08:31:50PM +0200, Felipe Contreras wrote:
>
>> Why should we care about the remote HEAD? Isn't that relevant only
>> when cloning to find out the branch to checkout?
>
> You can use the shorthand $foo to refer to refs/remotes/$foo/HEAD. Which
> means, in the default case, you can refer to just "origin" to talk about
> origin's master branch.
>
> But as Daniel noted, that is really about local preference for "what is
> the most interesting branch on the remote". You might want to track what
> the remote sets to HEAD, or you might want to set it individually.

Ah, good to know. But then the message should appear only when doing
something with the $foo branch.

-- 
Felipe Contreras
