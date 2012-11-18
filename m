From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git-reset man page
Date: Sun, 18 Nov 2012 11:55:09 -0500
Message-ID: <CAM9Z-nkon5ZtPuqxL0HZPr1es9DSpLA+70++hYpTR4D7WTxbUA@mail.gmail.com>
References: <CAB9Jk9AdTBJotrB0fndZawMWH6hS4PW_5bHwecwY5Vz7=TnYAA@mail.gmail.com>
	<20121110155718.GA29321@shrek.podlesie.net>
	<7v8va9p6pn.fsf@alter.siamese.dyndns.org>
	<20121110204633.GA29363@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	peff@peff.net
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 17:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta89Y-0007z5-3o
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 17:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab2KRQzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 11:55:12 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45992 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2KRQzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 11:55:11 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1640053bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YkgApt3yOJuI3nhwuNMtJVpf1DcRn0jdt3/TQHhFFak=;
        b=cg3Glp8XzW99ttlAS9URQCDw6S+PxVZZqFvDXMLbDJEnHwsborLf2tAg8jiXoNQg6N
         DA2Yn47Tg6oHrjbHDPDsJ3VihwjoIMlXay79os5dSUV0T89VbBZaHH7Um+KK4dOfToWh
         wzLgLQACHb01HaWCrzphS0gqxSaGPYKyujXboIp+xwRuZTvzx5WN8ekEHWDfhF4Oi5b5
         KM6nvfkp5DhV6WvAfxF0WkQOAlVkEhai4zMZE1QeVAIyO3qCXVuRKBm8vG7sHpT9yrdx
         c5zdS8aObgmMBe3A6JXkMp3cWKPNXBOfMMS26ZP8nAfnAYpiWSM9XJ9NI3s/cUK4+1iD
         U5zA==
Received: by 10.204.145.217 with SMTP id e25mr4094635bkv.123.1353257709698;
 Sun, 18 Nov 2012 08:55:09 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Sun, 18 Nov 2012 08:55:09 -0800 (PST)
In-Reply-To: <20121110204633.GA29363@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210032>

On Sat, Nov 10, 2012 at 3:46 PM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
> On Sat, Nov 10, 2012 at 12:02:12PM -0800, Junio C Hamano wrote:
>> Krzysztof Mazur <krzysiek@podlesie.net> writes:
>>
>> > Maybe we should just add that <paths> is an shortcut for <pathspec>
>> > and fix places where paths and pathspec are mixed or <path> is used as
>> > <pathspec>.
>>
>> We should unify uses of <paths> and <path> (the former should be
>> <path>... or something).
>
> Currently in most cases "<paths>..." is used ;)

> So we should always use "<path>" for exact path, and "<pathspec>" for
> pathspecs patterns as defined in gitglossary. I think it's better
> to avoid "<paths>" and always use "<path>..." or "<pathspec>..."

I suspect that the only reason why the differentiation between
"<path>" and "<paths>" happened is because there may be some places
where it was seen that a _list of paths_ was acceptable (which isn't a
pathspec, as it isn't a search expression) and other places where
_only_ a single path was acceptable. Should that fail to be the case
then there would be a good argument for changing the affected
instances of "<paths>" to "<path>" in the documentation. (I know of no
other good way to pluralize "<path>" myself.)

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
