From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Wed, 12 Aug 2009 10:43:42 -0700
Message-ID: <fabb9a1e0908121043p390d8532tc3a661b42b3bfd1a@mail.gmail.com>
References: <1250036031-32272-1-git-send-email-johan@herland.net> 
	<1250036031-32272-3-git-send-email-johan@herland.net> <20090812021017.GB62301@gmail.com> 
	<200908121108.28714.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org, gitster@pobox.com,
	Johannes.Schindelin@gmx.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:44:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbHs0-0003mj-Ku
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 19:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbZHLRoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbZHLRoE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 13:44:04 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40886 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZHLRoD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 13:44:03 -0400
Received: by ewy10 with SMTP id 10so195619ewy.37
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JJGlCtmyhfxlLE/uHdm5oCizYZVg1g+vaBclMVT4JgA=;
        b=xsmKDgTKEdlnv5JMYUO0JgKFS2ehRCukWn73WZATEw3dyyzQmK0Ds28ke4SPG6fKog
         GGIdyXfTc8dpP2u8XJTi+UPeczO5OpZOlRdrpNQA+qjUORW+wIkT6TaxWCvJinoZMdfi
         qyuiDPBaIAzPvpSgpqS86C5A4FgGHnh7qOnd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r7qekurgayyFEXbE5b7LwB1OnHv1Zl1yLI6pzQYwhcJRT8RSgtUTweS4FMIhQJOmBn
         hC++Tm8FRnMMpdYEyQIOV225vdHoZ8P3utONM4dZnAC0qLXlRZHQN7kczZsnJXLWqWJI
         e2v0HHbl3kvWuX2rfPjyb3xHEWqpOG/avv0To=
Received: by 10.216.86.193 with SMTP id w43mr57930wee.17.1250099042143; Wed, 
	12 Aug 2009 10:44:02 -0700 (PDT)
In-Reply-To: <200908121108.28714.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125719>

Heya,

On Wed, Aug 12, 2009 at 02:08, Johan Herland<johan@herland.net> wrote:
> I can't find a good rationale for this rule in PEP8 (other than Guido's
> personal style), and I personally find the above much more readable
> (otherwise I wouldn't go through the trouble of lining them all up...). Can
> I claim exception (1) (readability)?

Working with python a lot myself, if you want to claim readability _to
python hackers_, then you should follow PEP8. If you want to follow
your own personal style which is easily readable to you, then by all
means; just know that people that read python a lot will have a hard
time reading your code ;).

-- 
Cheers,

Sverre Rabbelier
