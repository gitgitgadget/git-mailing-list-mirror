From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git pull is slow
Date: Thu, 10 Jul 2008 12:13:28 -0300
Message-ID: <46a038f90807100813s82e1e54l1d8ac6851015a500@mail.gmail.com>
References: <g5570s$d5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephan Hennig" <mailing_list@arcor.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGxqq-0005DA-N7
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbYGJPNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbYGJPNc
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:13:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:48594 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbYGJPNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:13:31 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1440446wxd.4
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UbLRnAubXsETFK/mIgNYKQALXfKztbe2rnafItPu56A=;
        b=hBv4toVcczxMCV8isKIj4OzTnJjtT9KRinCs7BZTCuLXTtDxWo5QyJ8etEYMKQWqBK
         zQaGeVeGKt/7G56Rys7Qow5kHoNtfvhAJZd/OkL+F8Xxk1iWUarTLMzIkGk2oBdQwncx
         cI3Nz4msiMtSgubWLYyTaSzyUhIEt/CJq5hfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kjYBus9YtFJDIIIRKkEEM6USdTkIg+dQsmR8Qfm7ToB+dU8FDWV4wajbsDX2j4ewiN
         3MXnqcgIq3pTAFho1eO4XlsR63ymm6aYYICrWPNxx6uANHpdkBVOOk74iG5gFb073ro4
         PxxhmmJAOH1FeHoHOcbgx6jBuN7ublL8OlPDc=
Received: by 10.142.12.14 with SMTP id 14mr2771901wfl.147.1215702808184;
        Thu, 10 Jul 2008 08:13:28 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Thu, 10 Jul 2008 08:13:28 -0700 (PDT)
In-Reply-To: <g5570s$d5m$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87979>

On Thu, Jul 10, 2008 at 11:40 AM, Stephan Hennig <mailing_list@arcor.de> wrote:
> commits to the repository is fast (with git+ssh access method).  Any
> ideas what's going on and how to make pulling faster?

When pushing you can use --thin to get a "thin pack" transfer, where
the delta-base is not transferred. Not sure how you request this from
git fetch these days though :-/ Search the list for "thin packs"
perhaps?

cheers,


m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
