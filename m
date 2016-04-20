From: Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 14
Date: Wed, 20 Apr 2016 16:19:33 +0200
Message-ID: <CAP8UFD0GZWkJRF02DOXS8QbKT6nrvc2=US5pGv-+6f+A8ihiXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: lwn@lwn.net, Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <nick@durdn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Lars Schneider <larsxschneider@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Tim Pettersen <tim@atlassian.com>,
	David Turner <dturner@twopensource.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:19:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1assym-0003uy-Go
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 16:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbcDTOTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 10:19:35 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37120 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107AbcDTOTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 10:19:34 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so84588092wmn.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=SuAFsM7EV39JNkD22axk1MMYRuY3S46nzgk9R572XqI=;
        b=i7jOPXjHte72oKYTVJq3PoM1WGMAeif0mLNis18lS6phiu7L1QyQNGSkYTOa0xo3PZ
         +oJCJQP3quk+r9Rybdhtr6CiEcrmxQosWpbxRYKRy0NKhx/Va6RXcAGQEmpJp8nETaaX
         Bhlaav6tjxPRHHqy6fZa2JxT8KIRMBE1DVqmeVk8dYCt9Bk3FiLg8pAwc8zSuxRKQs5x
         NYf1kEFeYFPHFL8+ZE0wyZC2PwSM9gdZecyqZJUT9HSAN4OuPMCGmLv2Qnny9eNbQ3YM
         QSOOJobRGQhc6zIrKsgaeIyxGVldH+w7jP2likhtbwqOV2G84LCdcYoHNcFXgmz7Z4m9
         nDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=SuAFsM7EV39JNkD22axk1MMYRuY3S46nzgk9R572XqI=;
        b=F8F2b8V3mB0pBoVD8KRtkIQeYscIuQbopdPWXuooa1BoRYB5QT+y/qjucr8yAkHWAk
         ElAGYrw4wS11sMr02LCapPx6HhCJY+JX/+6grMlDHp8xOZ9teKeDwBGUTTrP4bUFGlzc
         K0vfiEz6O7TGQKFE4AMOd6Tp8VdeE34+SWTZXPZdHHLApXOeoEsBxqiQzslJFvPP8f9/
         uwio/FttsY2WIPURhO2AZ6Y2fNBNmiu58mN5bBtFXFaLDC7SxU3FkO9w0Ey8x5kDX4ry
         RJGU2+IvQzoNEZ9dEaWWYtgQMpGif4FeXYssEBnpaES02GEmj6FnJfTz1L0hwbQa0RT2
         9ODg==
X-Gm-Message-State: AOPr4FU94v/Sv3nxGEQMfpAtqbT1MgX1/0HNvuMYaEP5msFtlfyxelVnaxBfCpCkB32ArGlmNyeueLYHIx2HGQ==
X-Received: by 10.194.235.39 with SMTP id uj7mr8925093wjc.78.1461161973264;
 Wed, 20 Apr 2016 07:19:33 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 20 Apr 2016 07:19:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292025>

Hi everyone,

I'm happy announce that the 14th edition of Git Rev News is now published:

http://git.github.io/rev_news/2016/04/20/edition-14/

Thanks a lot to all the contributors and helpers, especially Johannes Sixt!

Enjoy,
Christian, Thomas and Nicola.
