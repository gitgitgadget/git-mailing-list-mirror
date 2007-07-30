From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Arbitrary long file lists?
Date: Mon, 30 Jul 2007 14:43:08 +0200
Message-ID: <81b0412b0707300543p48964b73o5f972405645e70e9@mail.gmail.com>
References: <866442t6j5.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 14:43:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFUal-00080T-8l
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 14:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXG3MnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 08:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbXG3MnL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 08:43:11 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:22135 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXG3MnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 08:43:09 -0400
Received: by ik-out-1112.google.com with SMTP id b32so898366ika
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 05:43:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BzzL6JyUbx325QoOTWBEsLqCG577Np9Uzbn80rUq44cFIYNeHmvcxUFI/xOPrBCXA5OWu9b4XJF4nB/LdyhbHDAoVizvPooFvngBqaE9HUUee+svFU30SYgdGjMHPlpz1Q75TaJlSSVwylfJBUEUH4drGGPVOUIOeo7R1ub9Z+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k2VkyVAIExQKAbvyy0GAHFXMwXBfDYC/PUPptypQYI9aOJR9NAo0lNbPRi+wqQstDNKlPIDJUwY8wLUdeuSJG0iewgb2i3yGu7VwSpDoRNblGf+5tAljWtVg8EXx+iMOH+hU00TLmrcZ0DpIPJ2ZqWmhGWxaxP7oL0UsqjmIFcQ=
Received: by 10.78.181.13 with SMTP id d13mr1481114huf.1185799388479;
        Mon, 30 Jul 2007 05:43:08 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Mon, 30 Jul 2007 05:43:08 -0700 (PDT)
In-Reply-To: <866442t6j5.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54228>

On 7/30/07, David Kastrup <dak@gnu.org> wrote:
> commands like git-archive take a file list on the command line.  If
> the number of files does no longer fit the argv limitations, this
> causes a problem.
>
> So it might be nice to be able to treat some "filenames" in a file
> list special:
>
> -@=filename (read LF-lines with filenames from filename)
> -@=- (read lines with filenames from stdin)
> -@z=filename (read NUL-terminated list with filenames from filename)
> -@z=- (same from stdin)

git-update-index and the like use --stdin and -z.
What do you need the one with filename for?
