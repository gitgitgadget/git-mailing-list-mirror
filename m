From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 13/16] remote-hg: allow refs with spaces
Date: Mon, 22 Apr 2013 17:38:45 -0500
Message-ID: <CAMP44s0f+gJNNESJbYXQgG05Xn0xkkFJMJq6=XC9RsnCdAGzMw@mail.gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
	<1366667724-567-14-git-send-email-felipe.contreras@gmail.com>
	<7v61zenqm4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:38:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPNr-0002IY-3W
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab3DVWir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:38:47 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36185 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab3DVWiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:38:46 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so85299lbi.17
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 15:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WkvmEaiajFqODxp/UrQBfMQ6N8yMYI7LRFyAK8yQlsE=;
        b=WavptnT8glTORPl1EQrXUXYPZDaV+uszzmF56+UCLXStZrpCLOPPWA8Nof5RH+7QcM
         PMlh0U13sGvVgdvm1kmYZ7/aAanT6sz5w4U/iaTFi/Egutz8L2K6dd1SWxvbnE+wSWkX
         qtDF7gOM8YCn0CCHvHOV5Fr7SIizxi0zGg4/6f3yQz6Yt16YjEAbfit3x1EL1zQayE0T
         6IqT6EvuL1DCUPLWpiMFC351aKJO9/DLl9PWt4wRz/bB6Mji4zcUyVhh9FHiJCEqmVOP
         RaQQoQflE95qb3Mpq1wPoVswwVr2Er5xTD6ZTj16quG+GF6N4xv59SaeRETPq4g6U/ob
         FMpQ==
X-Received: by 10.112.22.198 with SMTP id g6mr10138419lbf.135.1366670325072;
 Mon, 22 Apr 2013 15:38:45 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 22 Apr 2013 15:38:45 -0700 (PDT)
In-Reply-To: <7v61zenqm4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222124>

On Mon, Apr 22, 2013 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Mercurial supports them, Git doesn't.
>
> Another important thing to note is that you represent a SP with
> three underscores on our side, no?

Probably, I don't think it's really important. Perhaps some users
would benefit from this information, but they would be better served
by a README, or a wiki, the commit message doesn't help them.

-- 
Felipe Contreras
