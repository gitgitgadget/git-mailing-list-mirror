From: Christian Couder <christian.couder@gmail.com>
Subject: Re: seg fault in "git format-patch"
Date: Mon, 1 Jun 2015 16:17:21 +0200
Message-ID: <CAP8UFD0kRJfqEgKNhbqKsPxSW4jvr_8o2Hrtu_b3_raONUN7YQ@mail.gmail.com>
References: <556B5D4C.4030406@gmail.com>
	<CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
	<CAKRnqNKVfzt_qMqoxsjMpunUYDNYd8C0jACM69HxGhJHEeVY-Q@mail.gmail.com>
	<CAKRnqNJnaLioQPWYDmSiBfLCSMGdFR21bAEXRzdpkChDBf2wgw@mail.gmail.com>
	<CAP8UFD1rKmKgKqCsffCLyOCny3JEACxgmBN_eqOj_=3zBW-MZg@mail.gmail.com>
	<CAP8UFD0_RCOHUF6BgczgS5kWAFc0QKdw4cUy_bpB2jhd+kYWdw@mail.gmail.com>
	<CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
	<CAP8UFD2KYSCMG7p22J78U8yVy49380PCxiXuvartXZdTGm1JFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Development <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:17:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQWy-0000Zo-7R
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbbFAOR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 10:17:27 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35927 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbbFAORX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 10:17:23 -0400
Received: by wibdq8 with SMTP id dq8so30894054wib.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9wiQqnh8UZIbxcPl5QR9qAbTq9MNqU/TRhKBdwJ6+FQ=;
        b=PgXOYJsm4fN0HdvznfhTFdjikBqgob6r9rWZb4xQMEqpnFh6NcuvWLsARmYuDJlzm7
         2D6TJWjodIAhHfm7iluERl5p9/0Y01sqpYdZ29zR68hGU1pWD0QIqoXGjMTIyg4lEKE5
         ezOGnMCN7uiW7ILIQzgTOO4vzcLa/ZtPP8vuGTqUxWdzWPLwrIT+DxKKjiYqASk5l+Br
         O5bRWYaKl1JW4p700DHqyA7ZI7g4OAFzpuyssfPuQEhojfBENNv65g8zE/utyckI/6ef
         EaKoTUSBvtcdC7Pox7dWMAUZLkroxCIltbt6jQ1es+PuQuYBKhi3N3LIc2gCT1/6TzZf
         mFDw==
X-Received: by 10.194.178.227 with SMTP id db3mr28333694wjc.82.1433168241837;
 Mon, 01 Jun 2015 07:17:21 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Mon, 1 Jun 2015 07:17:21 -0700 (PDT)
In-Reply-To: <CAP8UFD2KYSCMG7p22J78U8yVy49380PCxiXuvartXZdTGm1JFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270414>

On Mon, Jun 1, 2015 at 3:44 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> The following seems to fix it, but I am not sure it is the right fix:

Ooops, I had not seen that Brian and Peff are already discussing a fix
in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/270371
