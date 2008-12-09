From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 9 Dec 2008 10:49:54 +0100
Message-ID: <8c5c35580812090149lc6dd79cj60a9d23c18089557@mail.gmail.com>
References: <1228815240.18611.48.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:51:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zFJ-0002vj-Cn
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbYLIJtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbYLIJtz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:49:55 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:54233 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYLIJtz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:49:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so736756wah.21
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=r2mN7Uw0xyOdGfo17MCk9pG6aPDg7CC9ZSY+uny7LGs=;
        b=gwlr19IkW1SWH968Z+D0iq9AYxhnIDJ0ROyqJGioov2ihbqmGWpyS8+PW9aQLBa5Tp
         Idu8UdVembwFO6yZijaJ7lLXkFEtm9G7EMthY7v6Hzh3XZ1E4G9yLZn6NMpa3ch0t1Yz
         nCLXVH6u4OqvXwGGe42zPgoKGEBG/AyBdor+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ZADM6P4lYVU81dgO34Wkzzexxl1o9A0XYC4mxX8kcBnUAAUuPByqmT7MynjBJmLoBS
         Ok6CM3EzJxROMTdLkHX6D8uSTirJ1Irpx7ieDNrPaqnNZS+mjernoXqWhyXh29I1SOfN
         Du0yVj6odzyZNE9CDAemOoj+atCsFsZCY5O4s=
Received: by 10.114.37.9 with SMTP id k9mr3062465wak.197.1228816194208;
        Tue, 09 Dec 2008 01:49:54 -0800 (PST)
Received: by 10.115.106.12 with HTTP; Tue, 9 Dec 2008 01:49:54 -0800 (PST)
In-Reply-To: <1228815240.18611.48.camel@starfruit.local>
Content-Disposition: inline
X-Google-Sender-Auth: 58a19f91287958cf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102617>

On Tue, Dec 9, 2008 at 10:34, R. Tyler Ballance <tyler@slide.com> wrote:
> Is there a header macro I can define or a config option I could define
> to make --no-ff on `git pull` implicit instead of explicit?

Try this:
$ git config branch.stable.mergeoptions "--no-ff"

--
lh
