From: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than 998 symbols
Date: Fri, 21 Nov 2008 12:37:08 +0200
Message-ID: <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
	 <1227263693.3311.0.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Arafangion <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Fri Nov 21 11:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3TP8-0002Z7-Ns
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 11:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbYKUKhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 05:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbYKUKhL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 05:37:11 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:5255 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbYKUKhK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 05:37:10 -0500
Received: by ey-out-2122.google.com with SMTP id 6so355892eyi.37
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yXq7Tnh1MyH1CGlokq2AuuudyiWYO4aWzjkqGQwzbv4=;
        b=jHJ9tWxYvx9O5MDkBqmLDqz3b+I8zPu2jXt5ZDPzJByuNMylnii1pZIVV/Z/H+6hyg
         kvsFegMRy5zU2rxWP8iOXa0S5gSAz6X+AZqf5QHMxPEdLhL6URjcayFp4oy/wxbAVqBz
         OstXBHcBRbAo1zrKYvJ2+cB0YzRmUZrZREwC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=e/4ZsjQ4s9XV201w2zALBrw4xymbeWWjvAHZdGFkTbXAI1twNzPkFVjkiY4enLmFX9
         2PRPHcjM0AmyFA2zn4huzucZ+zLHb1ERGs5qTzq8704foCdxtT7GLkAZaK7/2gJiSFsH
         Bk66T/yYA0HancnqC0tAzlI5NAVC5+aXMGjS4=
Received: by 10.210.59.3 with SMTP id h3mr346490eba.150.1227263828289;
        Fri, 21 Nov 2008 02:37:08 -0800 (PST)
Received: by 10.210.54.12 with HTTP; Fri, 21 Nov 2008 02:37:08 -0800 (PST)
In-Reply-To: <1227263693.3311.0.camel@therock.nsw.bigpond.net.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101507>

On Fri, Nov 21, 2008 at 12:34 PM, Arafangion <thestar@fussycoder.id.au> wrote:
>> By default git-send-email does not accept patch which is contain lines longer
>> than 998 symbols. Sometime it's inconvenient, i.e. you have a long list in one
>> variable in shell script. So, define environment variable
>> GIT_SEND_EMAIL_LONGLINE to something to avoid that restriction.
>
> As a curiosity, why is such a check even neccessary?
I'm not an author of that strange check (possible it's somehow related
to b8ebe08b9a643f432866eb7150c3b20d59b755f2)

-- 
With Best Regards,
Andy Shevchenko
