From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git color in commit editor
Date: Sun, 9 Jan 2011 12:33:04 -0600
Message-ID: <20110109183304.GB7718@burratino>
References: <AANLkTimMZaSW4ZUS60Vo38vyuq-PPqPhGdCVZjFzF2Gs@mail.gmail.com>
 <AANLkTimAXV9u4FfL2cv5vE9oDgs-LfJu2DopRw=FEqUE@mail.gmail.com>
 <AANLkTikns9XyM48HkggaKFEsj61hP1y3Y-QczA0Pp9Bs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Pavan Savoy <pavan_savoy@sify.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 19:33:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc04q-0001uT-M0
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 19:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1AISdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 13:33:11 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36910 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab1AISdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 13:33:10 -0500
Received: by gwj20 with SMTP id 20so8293798gwj.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 10:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gOWwGQDRQMcV4NIp/23DgGmT9W4oBE/+4Mkik+KoQLw=;
        b=HPrgIkUbNE7G6OlPdSNdlIiY1I0M6JUlyukq1bIMezkNvaiexU9hqrACcxUxRfeXis
         GfSckspd32sN2dH6/vviYqrqzuKE0McD933es2RzWimPrme66pzFssMlv4dGpWibMrI2
         T8xkJzz1RtgCc9Hw4aM7r1onSSI8e1wboMdfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AGUmtsysnX2Oms9WahnZLptE5thonFQBh+ZEPF8/AffC0YrTDyPGMt6l9dtlRnQ70H
         4tpEDVy7JsWwc09LqJPA6JTuR1c7BQb+IQk/+Gsh39N9TiTAL8Nr6EHwrQ3NaZMiXCEt
         OFHUhHRZRX25q2oQ/xbth3bAVSQ9RTHvdp6Kg=
Received: by 10.90.83.11 with SMTP id g11mr5352928agb.86.1294597989862;
        Sun, 09 Jan 2011 10:33:09 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id c7sm36469998ana.37.2011.01.09.10.33.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Jan 2011 10:33:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikns9XyM48HkggaKFEsj61hP1y3Y-QczA0Pp9Bs@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164857>

Pavan Savoy wrote:

> Thanks, I do have syntax on in my vimrc, as I mentioned, I also have colors in
> vim for .c files on both machines...
> The only differences being git versions, also what syntax or color
> format would vim get for git and from where?

$ find /usr/share/vim -name git\*
/usr/share/vim/vim73/ftplugin/gitconfig.vim
/usr/share/vim/vim73/ftplugin/gitsendemail.vim
/usr/share/vim/vim73/ftplugin/gitrebase.vim
/usr/share/vim/vim73/ftplugin/gitcommit.vim
/usr/share/vim/vim73/ftplugin/git.vim
/usr/share/vim/vim73/indent/gitconfig.vim
/usr/share/vim/vim73/syntax/gitconfig.vim
/usr/share/vim/vim73/syntax/gitsendemail.vim
/usr/share/vim/vim73/syntax/gitrebase.vim
/usr/share/vim/vim73/syntax/gitcommit.vim
/usr/share/vim/vim73/syntax/git.vim

":help :syn-files" explains how to use them.

Hope that helps,
Jonathan
