From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Thu, 21 May 2015 15:08:30 -0700
Message-ID: <CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
	<9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Heiko Voigt <hvoigt@hvoigt.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 22 00:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvYdo-00075T-MS
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 00:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbbEUWId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 18:08:33 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33772 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbbEUWIb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 18:08:31 -0400
Received: by qkgv12 with SMTP id v12so783300qkg.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hWr3TckcucLYLWty0u2vOhZrqRj99Wmy8TzZUq7RAwE=;
        b=gnP6Rx3PZVu6wEC3Cj3tsmBxkj1SPPfwG5H2Nhc5FN7f2Ho4EIB9Zqu7+PsHEG5/ID
         rJmQz1n9O2NaRkG+uCiQ22TCzhkEsQciaqnDxpAF+3WcfhvLIa9BY0N5TaJ+9WUKF958
         +CKyTjrfM2omtJlOxHizmyLtpfoOxr9dKkTwcVNls+XiQE2/1YY49Qp8UZGFcIx8RfR8
         KlF7RqhZgMCJShRh3aoLEBrmF+frxMNnfkFS2xLPhnQ20CSz3n/wVsxSIpl0TOPLvv3f
         TuySBhfVvkxu1HRIunVAeM9dbpsonT81jKnhV0Y2kKVGWVnpkr1sRoB5VvddFnbtj5hJ
         xRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hWr3TckcucLYLWty0u2vOhZrqRj99Wmy8TzZUq7RAwE=;
        b=WdejNuqsZooCgsNFxA5USMd09PfzoYO6oCAA73GRqpc/b7sVBNMC0qugd2Y/bJV0Bs
         hyk/dQHdsPq5A1EcUB7ATAptYtYekReY9Q88CGVLVDg8m9DETZIfsPDIYwG+Fs1xtQB1
         LPY9xMNKcaHdtHz+xJduBmvlQ8yjoULvmolA704A6li+jKp9YVNzknDRYFgXXWwxGI7+
         N5c1sIw878nauFqOSSsvo1KSGJcbyary8lQgAzi6zm9OPt/rI40G6nJOsRN78z5HLgjh
         vWb1C6i4WH+5qRVrz0TmlEgwSHX+ZrgqdrxWEAdJVrt+sTlQKoWjKwSH69jYRK73WcGu
         /2dw==
X-Gm-Message-State: ALoCoQl3iuF2rOCk13JWzUAGQBtvo18jYGZmmUulY2Kh6hnW/Ao7wD6dzeZ9kZXTy4b6HGzWRVx0
X-Received: by 10.140.96.202 with SMTP id k68mr6902211qge.102.1432246110706;
 Thu, 21 May 2015 15:08:30 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Thu, 21 May 2015 15:08:30 -0700 (PDT)
In-Reply-To: <9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269669>

On Thu, May 21, 2015 at 1:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> +Submodules are not to be confused with remotes, which are meant
>> +mainly for branches of the same project;
>
>
> This use of 'branches' didn't work for me. "remotes are meant mainly for
> branches of the same project" ?
>

Maybe

    Submodules should not be confused with remote repositories, which are
    meant to track the same repository, just at another location; ...

? Though I'm not yet completely happy with that either.
