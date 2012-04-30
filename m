From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Glossary for bootstrapping Git translations
Date: Mon, 30 Apr 2012 12:44:28 +0200
Message-ID: <CACBZZX7H8qB05qc+ovaeFJ_qR3bF7=uWq6bjOHq8+_YNDLTu2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Hinrik_=C3=96rn_Sigur=C3=B0sson?= <hinrik.sig@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Xin Jiang <worldhello.net@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 12:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOo6B-0007cS-Jh
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 12:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab2D3Kov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 06:44:51 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46600 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2D3Kou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 06:44:50 -0400
Received: by eekc41 with SMTP id c41so654463eek.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=JHm+p37F1Qumvhor/zzgzqjviYqvfAnSqT69nVr7bCc=;
        b=BInE03sNLN2EaecQfV0vaiVnANnx7N3ju1TCgPF0gWi+ijj0We/b5grQJ5ppv7XxTT
         61Wpi9vQyxIN6betVnp+Cgt+gj61UbqeM50GO6NLvUEj2ePQ5iZA57AH/p3WjbMRkPWu
         ThSMcWWR0N3glfPlSfVVn53SXFIJpmx/syiu2pFtgpObIwTGvwi2hdlfWtm23EzZoasV
         OOelonSI45FrB2A0udIKCT/9tz11LDxGpGJYh+GVrncCYcIlzuuaNEvozB5QSXueJ9/M
         LtplvqhB6tfRxGL1YqWl5n5jPYCvlFj+fL3/HS7QKu/hCZXt8hXgaeVdNsaDJAvBi2ct
         oE5A==
Received: by 10.14.127.74 with SMTP id c50mr4390772eei.0.1335782689288; Mon,
 30 Apr 2012 03:44:49 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Mon, 30 Apr 2012 03:44:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196551>

Over the weekend I started the Icelandic translation of Git beyond the
current test messages that are there in po/is.po already.

I find that the most difficult part of getting started is getting all
the core terminology of Git straight, i.e. gathering and classifying
all the jargon involved and translating that. Once that's done the
rest of the translation is relatively straightforward.

So with a lot of help from others I've started a glossary for English
-> Icelandic Git terms hosted at:

    https://raw.github.com/avar/git/avar/is-po/po/is.README

I think having something like this in po/GLOSSARY or in a similar
location would be very useful to get new translators started. I'm
CC-ing the other translation leads so they can look the English core
terms I've come up with over, and suggest new ones.

If we can get together a good glossary then a new translation of Git
would be pretty much:

 1. Create a new $lang.po file
 2. Copy GLOSSARY over to $lang.GLOSSARY
 3. Try to translate all the core terms
 4. Once you've got that straight translate the rest of $lang.po
