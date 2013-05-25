From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 25 May 2013 17:20:29 +0530
Message-ID: <CALkWK0=16dmz548TQoj5YKp0dai7p1dpYAdXiWnnpiQdzyYHQg@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <1369405177-7855-2-git-send-email-artagnon@gmail.com> <CALWbr2yuEczF-G7uJ0r-teUJrZowrY8mYm+xwJmv4+CT6NgDPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 13:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgD0E-0003E3-V3
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 13:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab3EYLvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 07:51:11 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38885 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab3EYLvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 07:51:09 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so569030iee.39
        for <git@vger.kernel.org>; Sat, 25 May 2013 04:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vO2jE5j2JcbrvamYuM79CB19/fTALmgvrcyNYjU1fOo=;
        b=wXfbM+paKNcVhI29hRTF8WsVEUdIOUTtTYR+PSQ8vTPxcCL6Y+dB0YEDRqqj4/JfrM
         W+W04SUhujSdEpMSslgFicRhXyMrRuVrMmD3QDV9Nw8tDitMWZUtrjiY9AQxkcL5erue
         VKGqBPwz6xUJ1QAXsGD4fTlR38T9Upg4pnO8NZPG5Rzt3PIgrsnylSxaxsDO353a3NiY
         moRWBxwBX1y6Zx1SZvN22xiHVFCi7ORYTuZ36eSzDIbrvXlYdX+mu9axAi5cE6jEe7tI
         zI3c5JrOugPTQ/FetE830/NnY2OheHtPnSg+3uMTb6RCH7XK4zo9+nwBoR5HANRYo2ky
         /Hhg==
X-Received: by 10.50.66.197 with SMTP id h5mr1476419igt.63.1369482669454; Sat,
 25 May 2013 04:51:09 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 25 May 2013 04:50:29 -0700 (PDT)
In-Reply-To: <CALWbr2yuEczF-G7uJ0r-teUJrZowrY8mYm+xwJmv4+CT6NgDPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225522>

Antoine Pelisse wrote:
> Is it not possible for "color" to be used uninitialized here ?

My compiler didn't complain; what am I missing?  Doesn't the
declaration char color[COLOR_MAXLEN]; initialize an empty string?
More importantly, aren't there numerous instances of this in the
codebase?
