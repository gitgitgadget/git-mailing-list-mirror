From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git fast-export and lightweight tags
Date: Tue, 7 Jun 2011 16:10:45 +0200
Message-ID: <BANLkTikiNeufjH30HeApW6-71T2vOpKrxQ@mail.gmail.com>
References: <20110607110213.GA2698@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
X-From: git-owner@vger.kernel.org Tue Jun 07 16:11:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTx0G-0003v4-7X
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 16:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab1FGOL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 10:11:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44262 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab1FGOL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 10:11:26 -0400
Received: by qwk3 with SMTP id 3so2151977qwk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=reHaZU8lZUzIEphTF8mMgjyNBNWw8KfHBz0tEs7b+tI=;
        b=ZdaYB66sQo/GL/1dTI6ZaJu3d6tNiGnlgJJ7o8kIZPATsD1AqhKnA6yJXRaMF6zVO2
         vexXVevg9eO3weajqn9aSK4p0oGjBkW0Aas3kBU7d5bhFUyz6xXTwhphuaKq5BimLjE6
         46T/28EbnVRiBKsJLZvqFnXQkl3VfUXiZUXUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mKRABKc2rP3NWzaysKdu0HFrZOb80MVaeH37n8uhuW6in3nDcXwXETIJFHYQ1okpwC
         LU+/r4Vfxut2y6HPqm9S2kztqi7lXmomQRbnrUUbp9FIWXDbLsZNu0yOeW/d3vfeiEDo
         HMmco9hCxgdh68axY4egig8t9/F49mm5POZUQ=
Received: by 10.229.127.99 with SMTP id f35mr4547005qcs.91.1307455885518; Tue,
 07 Jun 2011 07:11:25 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 07:10:45 -0700 (PDT)
In-Reply-To: <20110607110213.GA2698@frolo.macqel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175206>

Heya,

On Tue, Jun 7, 2011 at 13:02, Philippe De Muyter <phdm@macqel.be> wrote:
> How can I convince fast-export to export my tags ?

Untested, this is just from memory:

$ git fast-export --all --tags

-- 
Cheers,

Sverre Rabbelier
