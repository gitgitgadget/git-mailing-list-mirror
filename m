From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] send-email: ignore files ending with ~
Date: Sun, 3 Feb 2013 18:16:16 +0100
Message-ID: <CALWbr2wCEHkVU86Dkzq1+mRx605h4LBo-5e8ySAwv=T0pMw62A@mail.gmail.com>
References: <1359903340-14508-1-git-send-email-gnurou@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 18:16:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U23BJ-00018w-2a
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 18:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab3BCRQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 12:16:18 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:37220 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab3BCRQR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 12:16:17 -0500
Received: by mail-qa0-f49.google.com with SMTP id o13so973810qaj.8
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VsJ99VVidb8g7umclcuLzoGzlVaVa9+tHOtog/Pw6gk=;
        b=IyX4jpjYYqx56Le2KWMQNThrO0Jyw68yIXBfwoAxsKCYI6ulu1qFwPif17av5MTl5z
         fmiaiEtwSjtTPzeAEg5M65DSB7N8GgIrdxUuDKKMx/eony5HOP7YZ5AxqRoZsfmgsXNQ
         rjZbwIGA3vVNpEf/0LEB9Zeh1rNyAP++GCDj38eL1yB7UK1RDcdal29HMLzldrmXnHXA
         x4K1alHD0Joc5QRlvQDRzReNWKK+t/LpRVbxQFNdM7a4aMQ+Tai5FNHa08yys3Uf5w2P
         fM23whEMor0+ajgOpt9V9mJIwiHzkMKYvrnAzu6hkkrmMmtpaH8Pnq5mnNPKyrS+R2fQ
         MRbQ==
X-Received: by 10.229.197.155 with SMTP id ek27mr4182427qcb.131.1359911776650;
 Sun, 03 Feb 2013 09:16:16 -0800 (PST)
Received: by 10.49.13.200 with HTTP; Sun, 3 Feb 2013 09:16:16 -0800 (PST)
In-Reply-To: <1359903340-14508-1-git-send-email-gnurou@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215319>

On Sun, Feb 3, 2013 at 3:55 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> It certainly happened to a lot of people already: you carefully prepare
> your set of patches, export them using format-patch --cover-letter,
> write your cover letter, and send the set like this:
>
> $ git send-email --to=somerenowneddeveloper --to=myfutureemployer
>   --cc=thismailinglistiwanttoimpress 00*

Why don't you use 00*.patch ? That seems dubious to me to ignore files
specified on the command line.
