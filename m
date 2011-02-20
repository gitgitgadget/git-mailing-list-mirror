From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFD] Alternative to git-based wiki: wiki as foreign VCS
Date: Sun, 20 Feb 2011 13:00:00 +0100
Message-ID: <AANLkTik=-b-Ow9ttg6vob2czKvu+PyEUWUY_VjrqboDQ@mail.gmail.com>
References: <vpqoc6a8x0k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 20 13:00:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr7y1-00056S-Kr
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 13:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab1BTMAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 07:00:41 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35872 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab1BTMAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 07:00:40 -0500
Received: by yxn22 with SMTP id 22so222167yxn.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 04:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6FKSXgOf+dgupJaiDHCate8LN46HSZUX65hCSr+XkBM=;
        b=w0CacpZk22mV+Hn9ENtl7q2OMMIp/B8tZ4sAWYmX5rU/zY/eH2pyZJim+kmxD5YKhc
         kkxipC7qC2f/BoruM8+UBwYCwKw8aegZXBd6iceIOIlakDPuertGRkG2Sd8a+8KeP/Qg
         Sb+CLuWeNPtTIlLO4fhze705Nw2RyNWBGZqnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VGE8OiVcbdZY1owD2qO53hjrfN8XfINvcOy0bpaEzPTWkXTAoVmiY4tInMeqO5MQzI
         R5hs9YLdpXWw1y8+W0JGhuocBVLVOJG4NcvjxoBKVEYZoMKWJcKXoAY7FlmFVKaMqSvZ
         EnZeSQyIr4AzK7P7AHjBQFJRPxOQ5isCEiJGA=
Received: by 10.150.96.21 with SMTP id t21mr302935ybb.20.1298203240096; Sun,
 20 Feb 2011 04:00:40 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Sun, 20 Feb 2011 04:00:00 -0800 (PST)
In-Reply-To: <vpqoc6a8x0k.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167419>

Heya,

On Thu, Feb 17, 2011 at 17:07, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Any opinions? Advices? Does this sounds like a good idea? Any pitfall
> to avoid?

Sounds like a great idea, it'd be even better if it was implemented as
a remote helper.

-- 
Cheers,

Sverre Rabbelier
