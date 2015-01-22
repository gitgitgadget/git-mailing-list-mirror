From: Stefan Beller <sbeller@google.com>
Subject: Re: [BUG?] setting ulimit in test suite broken for me
Date: Wed, 21 Jan 2015 16:54:18 -0800
Message-ID: <CAGZ79kZTZfFg2GUNCeML8_wcL42egkpjp+1VTNVBb7UAMdf7YA@mail.gmail.com>
References: <1421866746-29444-1-git-send-email-sbeller@google.com>
	<20150121190348.GA29891@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 01:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE62R-0007eh-W6
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 01:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbAVAyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 19:54:20 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:49729 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbAVAyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 19:54:19 -0500
Received: by mail-ie0-f180.google.com with SMTP id rl12so11202877iec.11
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 16:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C07RaNUrQ1n4nFcsNNuF2yhjz0kWQlcdYyCGNXEOFVQ=;
        b=XxmqFuY5lZ1NaasAomkThRIcY2r+a7047P8CHDJXmoMz7SR+VRldS3Nf/J9p61Y5Q9
         K8sXgSWfdF4LgatHfiaFwnahx2UEhKb76A578Barlhtfau5bgJGQcyO8iGcoV+EupzOe
         POWBv5GE8bYpU9cAfns+4UIePHd3IwtzbuJH2QfNTrRCZe+Y+OywlYs1czZkhzdZe7oJ
         PHV5lnr/AcxDvA69LtNYQIVeNKoEvG3SvSmwFgUCmk9x/CR/vRQqT7XINRwnlod4NXmx
         O+++GIwfbguIXjEt5w+xETwPDt4xbP27X/EqAbcktqgsAnbIh7RJRHgQL+36P0tt+Rmn
         IfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C07RaNUrQ1n4nFcsNNuF2yhjz0kWQlcdYyCGNXEOFVQ=;
        b=lZ1McoQo2D3G1orB7YC8oZ+BZEGtaX/R0Z8JFsFah6FSJzis+XPdIK4cyNd3wOGK+6
         P7pq3DR68qYzhwkjST7QFgBCVB62mJstnG/NCXJdyvx9kI/ewsivr08SGRke3kk91P3r
         v798t9mrApTS17DRBTosy7YnuyFXbfPeXnauLDGKOodRIH9/hfMEVjXk0i27iyWimDoC
         RxgOoxueJTwHMJE78DVOFtcNIq/lgfqUvDH41ix5hzyd3mO06E6Pcii52Y/mZ8AS7kus
         PE2RJvDE8YeeH1pOZpJtP+QHywC1aiFZY9C4oOTQEiZ8eYcI6Svv1P7Rvf8Flw9TYJie
         Iz1w==
X-Gm-Message-State: ALoCoQk/X0C3qO8amNM+nSr17QlMyLHpCm19v8XbSGjqqBhuzrjely6cRFjiOAwqYVGKMrrqv48p
X-Received: by 10.42.71.194 with SMTP id l2mr36751938icj.71.1421888058748;
 Wed, 21 Jan 2015 16:54:18 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 21 Jan 2015 16:54:18 -0800 (PST)
In-Reply-To: <20150121190348.GA29891@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262790>

On Wed, Jan 21, 2015 at 11:03 AM, Jeff King <peff@peff.net> wrote:
>
> in your debugging statement (and of course use run_with... for the
> actual git command you want to limit).
>

Thanks for that hint, its now part of the bugfix series.

Stefan
