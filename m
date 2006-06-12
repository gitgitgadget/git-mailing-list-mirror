From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: Thoughts on adding another hook to git
Date: Mon, 12 Jun 2006 21:18:53 +0200
Message-ID: <f36b08ee0606121218s6cdcfec2i42482ed5284a45e3@mail.gmail.com>
References: <448DB201.5090208@shlrm.org>
	 <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>
	 <448DBC2B.1070807@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 21:19:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FprwB-0008GJ-Ce
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWFLTS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWFLTS4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:18:56 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:41834 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932136AbWFLTS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:18:56 -0400
Received: by py-out-1112.google.com with SMTP id x31so1783171pye
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 12:18:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UFcdBB0BtA/phXXlSkTDetvayH2rTHtmxrfoj6mzeYADag2xAoLhGgHIkBQc+5ZRPTnKTG+5eZF3BMLRj0q6pQKprWhvaNeC1BNiAaJW6RJ9gmldVfTPCADkS96B2aY+Yrk3m3qEOl9sOPK2rHsduRUk0o+Lm+kh8+fSe6GtZ+E=
Received: by 10.35.97.17 with SMTP id z17mr1323752pyl;
        Mon, 12 Jun 2006 12:18:55 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Mon, 12 Jun 2006 12:18:53 -0700 (PDT)
To: "David Kowis" <dkowis@shlrm.org>
In-Reply-To: <448DBC2B.1070807@shlrm.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21732>

On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Yakov Lerner wrote:
> > On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
> >> I'd like to be able to modify the commit message before it ends up in
> >> the $EDITOR.
> >
> > Can't you define $EDITOR to point to some script
> > which modifies the file as you wish then calls the
> > real editor on it ?
> >
>
> I could, but then anything else that uses $EDITOR would also be affected
> in the same way... Which would produce interesting results.

git-commit sure creates those temp files with
specific naming in specific dir. You could check for
that in EDITOR script. In the script, you could even check
the name of the parent process.

Yakov
