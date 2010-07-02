From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported 
	commit
Date: Fri, 2 Jul 2010 05:16:55 +0200
Message-ID: <AANLkTim2DnettF2gNTQVaJvrpzwrTP_-HWTp8l6R5TVc@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 05:17:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUWkt-0001pE-DO
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 05:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab0GBDRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 23:17:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35532 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0GBDRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 23:17:17 -0400
Received: by gwaa18 with SMTP id a18so41073gwa.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 20:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=+ET3zsbF9V+f616EaET9+VyeezFxwaPdeVxUMcojGp0=;
        b=gfN5oyqYP61J64ZtL12l3N85kKElbH7QGwCJQHxItzhtWZLRa5zYiPqmhrww9s3guN
         8pkTeZwcM5J5TKYzxeBQ+ecEdTN7uj5ApZIoIBvIG/aY4Q/uDE8X9TnSBjtff05R4nfy
         6EqLVmsIFQ0xVORsOSX2c+PjrwQwyGtFfBe0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GQ7zRiddpkkbIwfdMO/2/JF1KOYjf4ZtqL34/mSPaSANCtPHgx0bY+SHgmqjngnbSt
         H3njYszDR5gtXE/ao8Ki1KDRaYNYOT5FhvRO7X8kaJQ+S+/mUBkpKewNv+Yl9PkRcmRQ
         2CrfR46iCgcKbuU4XliLPbAmoRZRg9nf2Flmk=
Received: by 10.101.147.19 with SMTP id z19mr48932ann.66.1278040636217; Thu, 
	01 Jul 2010 20:17:16 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Thu, 1 Jul 2010 20:16:55 -0700 (PDT)
In-Reply-To: <20100701054849.GA14972@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150101>

Heya,

On Thu, Jul 1, 2010 at 07:48, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Unfortunately when each commit object is written, it is not yet
> accessible to the caller.

This I don't understand, as soon as the object is written wouldn't it
be available in .git/objects?

-- 
Cheers,

Sverre Rabbelier
