From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Trivial fix: Display a more friendly message with 
	git-shell.
Date: Mon, 21 Sep 2009 12:21:54 +0800
Message-ID: <be6fef0d0909202121u1d7f843bx97f86eed8bf79618@mail.gmail.com>
References: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 06:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpaRS-0007Gp-5R
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 06:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbZIUEVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 00:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbZIUEVw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 00:21:52 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:35315 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbZIUEVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 00:21:51 -0400
Received: by iwn8 with SMTP id 8so1486091iwn.4
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=44dzwPhVEU8Z+2NTBr2oqa5d8MrvtniyhQnGO5FV7zg=;
        b=Ha+OPy7vzm+KYQDFq624B2QIN5fE7deeobD22Yo1q0eV7K6KmLMMJvyjPOPq1qg7Og
         MTRPiND+RzvWB2TboUcarlzyc1qaWp52Dyoonpcl4uDvCQZWOBiRAwvhGiyRsby3g6Cy
         btGTychbLb4FrXXJJ04161NFMPraWdkRz5W2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XpMfX2qCoLndI7WwYcMUixWQXU3Ya7QhKSerUWxCQLioB4nkoecccUuWD+o58+Qe8G
         prTa0g4TJUYsv8gR70MSAc9hnVe/YjAVLf4r5sTCs4CVx2m/E3Q6avAJ51mEYPWEWljy
         7gnlP8W8hwa/JdLqWMmN3TBVQKEFUz2EoTWdE=
Received: by 10.231.29.149 with SMTP id q21mr8409128ibc.35.1253506914715; Sun, 
	20 Sep 2009 21:21:54 -0700 (PDT)
In-Reply-To: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128863>

Hi,

On Mon, Sep 21, 2009 at 1:11 AM, Thiago Farina <tfransosi@gmail.com> wrote:
> Instead of simply die without give a helpful message, displays the usage

s/give/giving/.

Not sure if the same should be done for die (like die()'ing).

-- 
Cheers,
Ray Chuan
