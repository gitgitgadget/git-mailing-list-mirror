From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 16/47] remote-hg: load all extensions
Date: Tue, 14 May 2013 17:12:32 -0400
Message-ID: <CAPig+cROU5mDp3A=3ZQzcstyo7WD4rQd+K49G1AmngNEAxDktw@mail.gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
	<1368506230-19614-17-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcMWY-0005fy-On
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430Ab3ENVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:12:38 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:59838 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758395Ab3ENVMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:12:38 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so746817lab.18
        for <git@vger.kernel.org>; Tue, 14 May 2013 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=b8HntWEb/JD6IZi3NVpP3aTNU2yLf5itMdAizv5f5WI=;
        b=bRxJVjAKYQcrWp3iIIxKuqF/u+YsqxV1JiVlpXz2Yqm0jQjt6Od0lIMAWmBzDAoNbi
         Ml4KLGqcVxAQMIViS2NJ0QKBlLqbQh6yfgZGmI3V6W6rSdJx9hxKAAZ/S+2Zce5QJJOU
         7MWr1lYVCTNnMa2jN9/bkQhjDdevNX7x8zXSMuo1197QEc4BIPYig4bVcgBE80xcuaZP
         nFxNZMtFPWp0pP4dt8ptAz+dojpQjKZaPZWJkiuXSLD2ZjOnc/UuU9vEwcNQcQHy6wCZ
         iIknkXDfPZxeElXiBAUF+P+c/lrYezWD61RHIAtVMQ7WBYKJcFWdqtfqtR5W82/vbcgE
         r00A==
X-Received: by 10.112.133.137 with SMTP id pc9mr15978413lbb.74.1368565952891;
 Tue, 14 May 2013 14:12:32 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Tue, 14 May 2013 14:12:32 -0700 (PDT)
In-Reply-To: <1368506230-19614-17-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: InuuTiAVW1TDZeaofPe3rGcf7p0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224347>

On Tue, May 14, 2013 at 12:36 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> The user might have then configured differently, plus, all of them will

Did you mean s/then/them/ ?

> be loaded anyway later on.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
