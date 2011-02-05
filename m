From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Sat, 5 Feb 2011 20:00:47 +0100
Message-ID: <AANLkTikX5Y=TrXayXj-MCaR5p0=Tokc_5ihGqHFL9CQx@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <m3zkqe8xc8.fsf_-_@localhost.localdomain> <201102051931.10979.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Sat Feb 05 20:01:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlnO1-0008OI-BE
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 20:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab1BETB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 14:01:28 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63570 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab1BETB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 14:01:28 -0500
Received: by iwn9 with SMTP id 9so3275091iwn.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 11:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Dw8BRSNjZlQ+Ds7p76Q5N1cGtov/bmhygZSc9KOFPwQ=;
        b=Rjx22EZmiem6gDR5/182QV5LXoeYlP7+i8GHF1UH7b03ieIZ4aqE8+AfPtNhseBBDT
         U/3udhQWjT9Rbj5NAgK4pg9daOR5NThKEV3dbZJMLjeNg5OAv7wr0T3A8XeEBS5cFTr2
         +FJbAP0tRZ/LVSAwwzqVlC894MMpnkek5EINI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mOpC+mt0k6YlSoXxMOpJWK8cWqj1648ZL7TS4Dd3yWCr2uc/g7QzP3LfKmbugUbbDa
         JZMJVkFWGDuKJ4x5wOYK08CL/oM9mFUnO3ljDghodeXbStzQZM1U+QoYu+5OwMClkL4p
         2+7eMKWdURdlWPhKZgUCYZw+1aVgknBMM+WsU=
Received: by 10.231.10.138 with SMTP id p10mr1535436ibp.177.1296932487399;
 Sat, 05 Feb 2011 11:01:27 -0800 (PST)
Received: by 10.231.39.140 with HTTP; Sat, 5 Feb 2011 11:00:47 -0800 (PST)
In-Reply-To: <201102051931.10979.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166112>

Heya,

On Sat, Feb 5, 2011 at 19:31, Thomas Koch <thomas@koch.ro> wrote:
> - Implement the possibility to checkout/read/handle empty directories as soon
> as possible, even in the next 1.7.x release.

I think regardless of whatever else we do, this makes sense. I think
it's been suggested by Junio in a neighboring thread as well.

> - Implement the possibility to checkin empty directories next year, but allow
> it only, if the user knows that this breaks backwards compatibility of the
> repo. (Generate warning and require --commit-empty-directories option)

I don't know about this part though.

-- 
Cheers,

Sverre Rabbelier
