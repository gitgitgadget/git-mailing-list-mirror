From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Mon, 3 Dec 2012 22:45:45 +0100
Message-ID: <CAGK7Mr4HkCkbw-SV-d=JAmQieV0ZQOE7YqR-g7rTWzHGPYqzHA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu> <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
 <20121127143510.GA15831@google.com> <20121127183530.GB11845@thyrsus.com> <CAMP44s27gdDJGNx-UTe1rdQZFpn3M60L=nMyd69gAFo15VnMAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: esr@thyrsus.com, =?ISO-8859-1?Q?Magnus_B=E4ck?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfdqT-0005jE-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 22:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab2LCVqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 16:46:16 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:33197 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab2LCVqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 16:46:15 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2565743iay.19
        for <git@vger.kernel.org>; Mon, 03 Dec 2012 13:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K4PWBBjWOUxZf1QdOfmQfkpu8drDAgXmNuJlpTPF1Zc=;
        b=L78xP/netkY93kKrRQxSQquOgrhsJrKDg9F43tz/yinFwcUFU0mgKULxT1pz463VD5
         0ocAIQuQf/E8xLi2YFfvLqwElk0n+JSVHiEulfLZTUps1xX9Tch9VyMYgs85J0f47kB4
         fGEjx4MY9A9I59wbhkOhO7vEZ0ojmBPqKabpZXBLls1m70zikL8J2VOeWPu2elTrbuSJ
         lnfiniuKXCG1PSo6X+GhMHB94aPNunkKzJkEffG5h2MrEFiCtBNLs01vxlI5O0Zaq14K
         uWNMJ56fosYNKVoPuyulEQrR0qI4tx84G/hVA7r3oKQvlmE9thiH0XdfI8vX+UNlroCR
         hkVw==
Received: by 10.50.185.230 with SMTP id ff6mr607489igc.7.1354571175327; Mon,
 03 Dec 2012 13:46:15 -0800 (PST)
Received: by 10.50.73.100 with HTTP; Mon, 3 Dec 2012 13:45:45 -0800 (PST)
In-Reply-To: <CAMP44s27gdDJGNx-UTe1rdQZFpn3M60L=nMyd69gAFo15VnMAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211061>

> Also, you are ignoring all the advantages that shell has and python does not.

Out of curiosity, can you list the advantages? From what I gathered:

- no need to install bash
- git contributors are more used to bash
- there's only one "version" of bash (no real need to handle different
versions compared to py26, py27, etc)

Are there any "language" advantage or are all the advantages in the
"pragmatic" section?
I don't really have an opinion on this topic. A "real language" seems
better, but bash's pragmaticity seems to outweight the cons,
especially the "contributors want bash" argument.

Thanks,
Philippe
