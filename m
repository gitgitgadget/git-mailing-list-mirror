From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC] git clone --checkout <branch>
Date: Tue, 16 Feb 2010 19:12:41 +0800
Message-ID: <be6fef0d1002160312w82c7f33t42e383b0756e4fae@mail.gmail.com>
References: <be6fef0d1002160248h7410d4edu6e3ed1fd27c40059@mail.gmail.com>
	 <20100216110724.GA25173@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 12:12:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhLMG-0000L6-4N
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 12:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab0BPLMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 06:12:43 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:36051 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab0BPLMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 06:12:42 -0500
Received: by iwn15 with SMTP id 15so5673644iwn.19
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 03:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=5rQHHoN/XZCXFwcmHv1kYyQtya64RmvD2/5SKbd6uB4=;
        b=ibmaqwk36Cc5b4GFEHxgEiLvTHmYxWeEKArtOr/5g4Ztp5Y9tUSGRxlDVy+HeKqpky
         aPqfNWwVlh10s01z+r3jXpJ6oF4OydYo0I548KkbRsoizdCD1c23Qqv1cBRzWz2xNr0a
         RLYczMbXsgDH11u6nO02+fDXh82NHHhhnAwkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=L9FGW1b8q35zyP9cDrQcPuA+qE1GkRJh/GEPNbWVEf45v+TJB+8/mVC3qSUF0Jkyq2
         EkjTQxSt8gmytxgyUQr7dXM3z/T7woVlPlyZ+UVs8hO0sDCktGys6EOsEdR9BuO8nYJ4
         SCA9kUwKyNvD82prJt53z1vY801axT/tw8bmA=
Received: by 10.231.146.2 with SMTP id f2mr857034ibv.23.1266318761302; Tue, 16 
	Feb 2010 03:12:41 -0800 (PST)
In-Reply-To: <20100216110724.GA25173@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140097>

Hi,

On Tue, Feb 16, 2010 at 7:07 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 16, 2010 at 06:48:42PM +0800, Tay Ray Chuan wrote:
>
>> what do you guys think about allowing users to specify the branch to
>> checkout when cloning, instead of the default HEAD of the to-be-cloned
>> repository?
>
> I think it's a great idea, but that we should call it "--branch" and
> that I should travel back in time to implement it last September as
> 7a4ee28.

ah, yet another RTFM, my bad. :)

-- 
Cheers,
Ray Chuan
