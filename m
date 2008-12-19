From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Thu, 18 Dec 2008 22:55:13 -0500
Message-ID: <76718490812181955u5f56180en47b3a8268c3538bb@mail.gmail.com>
References: <200812182039.15169.bss@iguanasuicide.net>
	 <alpine.DEB.1.00.0812190353520.14632@racer>
	 <7vej04eui5.fsf@gitster.siamese.dyndns.org>
	 <200812182129.01021.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 04:56:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDWTb-0002HN-4p
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbYLSDzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 22:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbYLSDzQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 22:55:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:21394 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbYLSDzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 22:55:14 -0500
Received: by rv-out-0506.google.com with SMTP id k40so723017rvb.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 19:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kyT9z8wkE98Pt7Bf6PPCM1IR4IonLm/hukpbwP6+xR0=;
        b=aNEl2dJp+6lVzmkQCVP5PSklp6JjJDDJr8/BzoI6DJJ1BtRgXInIS2P4XO8Tx1n7ym
         mtuGpi3v7RLSNHkji418AlQJbotoMFCfvrnYslR47NfW/n5uOYzYpJK8YkRcjoMlNRPn
         Z+FlaCFh8FfVPDOuPRYXv2NquENGvc2UgbFpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vkOHnO3utvx4PeDYM9ORh8j6wm8QQOa5Y/4l0ksn1q6scNfso2NZ+bImg1jG489fbY
         82487WKhU6qInFPAAygfqdt9FCUetgcLPo1kl83CTlgd1bfoJCg4FpwF+M4r/0CWjt5d
         zwRyuOqF2i4VgqIKRohTi++syFcaebZThIAlg=
Received: by 10.141.194.6 with SMTP id w6mr1322712rvp.257.1229658913745;
        Thu, 18 Dec 2008 19:55:13 -0800 (PST)
Received: by 10.141.33.20 with HTTP; Thu, 18 Dec 2008 19:55:13 -0800 (PST)
In-Reply-To: <200812182129.01021.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103540>

On Thu, Dec 18, 2008 at 10:29 PM, Boyd Stephen Smith Jr.
<bss@iguanasuicide.net> wrote:
> At least, it might make someone read the manpage again.  Still, I'm unhappy
> with the message, but I didn't want to be too wordy.  A URL or manpage
> reference would be nice, but I didn't know of a good guide that explained the
> dangers of reverting a merge commit as well as Linus's emails.

Put his email in Documentation/howto/undoing-merge-commits.txt and
reference that?

j.
