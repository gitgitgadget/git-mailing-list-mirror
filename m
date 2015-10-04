From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sun, 04 Oct 2015 20:06:08 +0200
Message-ID: <1443981968.3520.5.camel@kaarsemaker.net>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	 <1443150875.3042.3.camel@kaarsemaker.net>
	 <699c08632232180166145f70c7f16645@dscho.org>
	 <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	 <vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	 <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	 <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	 <CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	 <vpq1tdb83nt.fsf@grenoble-inp.fr>
	 <xmqqmvvy1q83.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Roberto Tyley <roberto.tyley@gmail.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:06:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zinfs-0000I7-Iu
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbJDSGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:06:12 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33705 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbbJDSGL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:06:11 -0400
Received: by wiclk2 with SMTP id lk2so91883244wic.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=d713OVtc2tbo45vsAIG3gB5YsI/wAe4gdC0wD2vjwQk=;
        b=dE2ihYK4PBo5FL+1ckXuZjFtJ+WGZiuhcD/n+t2bVXinwHWggpVUM8tmxcWUgXFTR4
         xEj24MV2dID88SwOgbkq9OFTV26cnYDP+NbS7PsuoyUwdsx30IEUY/osvxY6YtG/OYNk
         aGoy1zn79Ca9QX2JYjKKZiWLbni3Y0gHicHV4EWiu6uhnQ74US9ZLWa7Ic7dbwawB+/R
         V0h4guOPmyjAJwTB/TdCyvBk1wPg8sPW2fJfzEZw/UAZD7lm/wF7aIogPiSeBA/egAau
         xWvsJhELQne/UCA85bjZBop+nn8TPAdNjUsGGSnHig9lJlCrFzWaEmp/QyMQWZERjZY1
         tV/A==
X-Gm-Message-State: ALoCoQm9ZSQ4OwwcylpAgKjAWD582nojRPzdepqXemOU851zR+RUjS26CbCEwKbSzCrT0XrT8MS9
X-Received: by 10.194.117.39 with SMTP id kb7mr25105156wjb.129.1443981970682;
        Sun, 04 Oct 2015 11:06:10 -0700 (PDT)
Received: from spirit.local ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id jq3sm22624371wjb.26.2015.10.04.11.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2015 11:06:09 -0700 (PDT)
In-Reply-To: <xmqqmvvy1q83.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279009>

On zo, 2015-10-04 at 10:46 -0700, Junio C Hamano wrote:
> One final question.  Which configuration file does the CI use when
> running a PR-initiated test?  The one already in the repository
> i.e. the target of the proposed pull, or the one that is possibly
> updated by the PR?
>
> I am wondering if that can be an avenue for a possible mischief.

The latter. And it can, as it can enable notifications.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
