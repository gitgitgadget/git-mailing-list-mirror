From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Fri, 21 Aug 2015 04:10:46 -0400
Message-ID: <CAPig+cQjNHB-VyNvWn2rmD6H6p3mOg2SQZCBfh+0sN=yU7UVpg@mail.gmail.com>
References: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com>
	<1440014686-63290-2-git-send-email-larsxschneider@gmail.com>
	<55D55EC9.6050002@web.de>
	<917E3751-4BC8-4034-9101-30C77426D81C@gmail.com>
	<xmqq37ze7y4o.fsf@gitster.dls.corp.google.com>
	<C80E3141-C247-439B-97B5-562881C127F3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 10:11:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZShPb-0002bf-NA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 10:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbbHUIKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 04:10:50 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33367 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbHUIKq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 04:10:46 -0400
Received: by ykll84 with SMTP id l84so63131866ykl.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ODrtZGZyVWg+fGOnPY9J/MRfMAi0/swaUXS0ZW5XMgQ=;
        b=BCKRXluQmNMrPWuFbLc53CBuOvlQFl0tgyg3KE0R+ub7/q4JzlXs3b1mb3MFYdgR3q
         ZCsaDh+IBaCAK4bJegMvieVcNYyYW8+1iCWr11lBb3QGIXlPxEQuHjKxabup92BYd8hw
         Ujg4EMkaD973I3KYNov/GDtG2uvTCfrmN/yhBZBkM10lvjKwXCGeKFw4FoZzr14kqdJp
         qdvxGunP3YDMhkaav41jhG5PmMAZWrvg5/kTCmxMHr6yTpKPls6V/eHvjeb3V/Xx7GKa
         IvgqJGQiANdhVHYYPHhVZOhzgLthG4J4lsFjRzsgPZ3LGQEiKG5/k71kh9sCvbt/m6bB
         U6+g==
X-Received: by 10.129.76.151 with SMTP id z145mr9728849ywa.17.1440144646222;
 Fri, 21 Aug 2015 01:10:46 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 21 Aug 2015 01:10:46 -0700 (PDT)
In-Reply-To: <C80E3141-C247-439B-97B5-562881C127F3@gmail.com>
X-Google-Sender-Auth: xZ9s2ZYincr5WNzIhGnM1R1B-pI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276283>

On Fri, Aug 21, 2015 at 4:08 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> @Luke, Torsten, Eric, Junio:
> Thanks for the great feedback. I incorporated everything into
> "[PATCH v3] git-p4: fix faulty paths for case insensitive systems=E2=80=
=9D.
> Is this the correct way? I have never worked with the email-patch-fil=
es before :-)

I'm not a p4 user nor have I any knowledge of it, however, with
regards to the issues my v2 comments touched upon, your v3 changes
look fine.
