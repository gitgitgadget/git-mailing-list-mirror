From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/11] add options to for-each-ref
Date: Mon, 22 Jun 2015 20:18:29 +0530
Message-ID: <CAOLa=ZSCTMoEwL8GmUn4fRygpfA6_gNKE0K7pTbiy4++saQrDw@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <CAOLa=ZRLzTm1nW+JMUTqGgZ_H25A53NyHNVnH-Fd7GuBgrH+vA@mail.gmail.com> <CAPc5daX6=LugA6n9DFWXxfJG-K_js73JSON7S6xbDrKWNA6Vvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:49:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7320-0003wW-8A
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbbFVOtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:49:00 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33903 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbFVOs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 10:48:59 -0400
Received: by obbkm3 with SMTP id km3so21577745obb.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Te9UGkezfcI8ZtxwvJSkLbT0DU8txeTIODmEv+lR+bE=;
        b=Nye/BWikU5Fm6N0KPu18PQZdIYxj89AX1b1OaP74VTi7+duT0QSq1zMxURml3VO57y
         PyfyKX3neczYYf5vjbTO7BYhz1Hy6KMDhOPXXUbhOUz7cRc6VwQjxOCBF1XPSSbaZzPo
         J8jMWgtJ3HkLt3KrlWsZJqxG6/PQi5jjMPQhexYVQmQerBlFH9C+dmI0aEWU2k/d+t/7
         oUn44KziWxEOvd5BoGaFfAsf9mpDiFG0TzD34YcdiOgE89NLk4YZ8SGj8t+Qvfx09/jF
         zDOj9MGZ8oZteVGlcE9QQJe0HiWGc/wadtkuI63StH7gitNM0w05yUXzBz0m8dC+tzas
         2A4Q==
X-Received: by 10.60.35.8 with SMTP id d8mr25392029oej.37.1434984538570; Mon,
 22 Jun 2015 07:48:58 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 22 Jun 2015 07:48:29 -0700 (PDT)
In-Reply-To: <CAPc5daX6=LugA6n9DFWXxfJG-K_js73JSON7S6xbDrKWNA6Vvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272367>

>
> Just FYI, you can "git format-patch -11 my-work~8" or something like that
> and get 01/11 to 11/11 even if you have more commits that are not yet ready
> near the tip.

I usually do a `git format-patch a..b` but I missed out the b it seems ;-)
Thanks!


-- 
Regards,
Karthik Nayak
