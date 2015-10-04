From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sun, 04 Oct 2015 10:13:49 +0200
Message-ID: <1443946429.3520.3.camel@kaarsemaker.net>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	 <1443150875.3042.3.camel@kaarsemaker.net>
	 <699c08632232180166145f70c7f16645@dscho.org>
	 <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	 <vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	 <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	 <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	 <CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	 <xmqq612n2z3d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 10:14:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZieRR-00052I-M7
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 10:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbbJDIN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 04:13:58 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36123 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbJDINw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 04:13:52 -0400
Received: by wicgb1 with SMTP id gb1so80995670wic.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 01:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=0ZNPENfxYRtGXW6XV+4fvT8m/cdtxUnifpGRCvF+Ubk=;
        b=WMrQjenu6QbaRkzw9NbFGN72d1DrL+7Q6QXaLyca3YVKwpfL0AShOePUoXR/csWsbB
         iFZ//qva4Oqd38o73IuWHgoPlk9SLHYoksmd+bwGfVPDU8IShg59K/VLcafQpK6X2/BK
         ZiZ/EkFdiRKmEYhpIUq+Xl3p/BwZBVMnktrIUQzlgqCyGpv3G2MiqakYiL3pVtSOBEg+
         x3pgE8NCSuvqkdJ8q3flh3viwIn5zwo0Hurg3j3oh4NIFhkiZuoTXnhpA0SV+BlcZn14
         UH7pmC7k23QsdWXnkUmM4oophcLLyL0LB3D9TAO0lGTX9uRpSG5hyEbfYtbgufjbeLHO
         3GSA==
X-Gm-Message-State: ALoCoQmsPpcyHUtGLHyPmEvUC5cRw+DlzScjhU4yoL37h3N1r1t8fEgtW9AzXCYXMQndhe3ddwJg
X-Received: by 10.180.184.201 with SMTP id ew9mr6076969wic.53.1443946430823;
        Sun, 04 Oct 2015 01:13:50 -0700 (PDT)
Received: from spirit.local ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id it4sm20412144wjb.0.2015.10.04.01.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2015 01:13:50 -0700 (PDT)
In-Reply-To: <xmqq612n2z3d.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278997>

On za, 2015-10-03 at 18:37 -0700, Junio C Hamano wrote:
> If somebody says "I've been maintaining a clone of git/git with
> Travis webhooks enabled and as the result caught this many glitches
> during the past two months without any ill side effect.

I've been maintaining a clone of git/git with a different ci system
enabled, and it hasn't really caught anything. Only the occasional test
failure in pu like the one I mailed about yesterday.

The automated testing of pull requests could be useful, but pull
requests don't seem to be used much yet.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
