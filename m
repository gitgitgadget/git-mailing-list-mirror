From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: git log, outputs something weird for colors
Date: Mon, 12 Jan 2009 14:28:02 -0800
Message-ID: <8c9a060901121428j37ff6699g7af264f79829b6de@mail.gmail.com>
References: <82fa9e310901121351y22feaf21rfb880bcd0d6cb1a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: mark <markkicks@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:30:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVIY-0007Aa-GH
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbZALW2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758698AbZALW2H
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:28:07 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:55267 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759201AbZALW2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:28:04 -0500
Received: by qw-out-2122.google.com with SMTP id 3so9900977qwe.37
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 14:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0cAxsIlAo0JlHNonwvv5A19dA1B3RnLDaD9U21JW+mE=;
        b=GLUQxpQt+tCWcOGevUYHgUjv5d6j4gKX6LsQ98aFqVAqDfkmM+52IcNR2TziAvRN3I
         M9gz0rM1MQQYXpUedqZ0/byaz4sNF/3tyS2i7Brc+NRAPjEHvxpDMcqu5Vyo8D4AYKVn
         XnYeEXvf03UherKPmHIB+qPrISi8fa+po20Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=E3ARS6boAZIv4W1g5vSt6cBvjy9yV83mbedhjdGtvQZEpmPnayrvQH6hhHdlcGc7HA
         j05h74DUzDBjbe+c6J9qE+Ag2hdaOxhSd2j/QXaSxqW6bcX/3FUsBYVVcizzKsMh2771
         u1W5/I8yrlWfV3W52/luKocL771jvZoqpy4u4=
Received: by 10.214.242.21 with SMTP id p21mr2331165qah.369.1231799282216;
        Mon, 12 Jan 2009 14:28:02 -0800 (PST)
Received: by 10.214.243.1 with HTTP; Mon, 12 Jan 2009 14:28:02 -0800 (PST)
In-Reply-To: <82fa9e310901121351y22feaf21rfb880bcd0d6cb1a3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105402>

On Mon, Jan 12, 2009 at 13:51, mark <markkicks@gmail.com> wrote:
> hi
> i am using kde konsole, and i am getting weird output for colors, for
> example for git log i get the following output
>
>
> git log
> ESC[33mcommit 8b918256d944221f741e5d7300873810e31466a6ESC[m
>
>
> settings in my bash and git.
>
> export | grep -i term
> declare -x TERM="xterm-256color"
>
>
> ~/.gitconfig
> [color]
>  branch = auto
>  diff = auto
>  status = auto
>
> do you know what is wrong?
> thanks
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I don't have any problems with Konsole and git's coloring, but my TERM
is set to "xterm", not "xterm-256color".

-Jacob
