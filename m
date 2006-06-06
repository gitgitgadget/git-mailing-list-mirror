From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: [PATCH][gitweb] Make it possible to retrieve HEAD plain blob
Date: Tue, 6 Jun 2006 23:31:09 +0200
Message-ID: <4fb292fa0606061431g2fcc8cdet93685b5a4977c29f@mail.gmail.com>
References: <20060606205737.GX10488@pasky.or.cz> <e64rhu$i7n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 23:31:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnj8u-0002BO-Eh
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 23:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFFVbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 17:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWFFVbL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 17:31:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:35946 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751136AbWFFVbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 17:31:10 -0400
Received: by nf-out-0910.google.com with SMTP id k27so8235nfc
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 14:31:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y7LlxHwiQt8wufRcSJ2r2h+WpxktNki06/860gqgFWHKsmODBltfjjzZJx6N1IfUnE7iqksgtbGWtE/o//HMNgMGb7t0t95PlwEnG9GeB9G30ByWxk2M66rsJoWbFmeVXIGrDKwfvwIoGluSjOUPTYUJr9KCc8ZaXThrrSHfnss=
Received: by 10.48.206.19 with SMTP id d19mr2159nfg;
        Tue, 06 Jun 2006 14:31:09 -0700 (PDT)
Received: by 10.49.5.13 with HTTP; Tue, 6 Jun 2006 14:31:09 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e64rhu$i7n$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21404>

On 6/6/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Petr Baudis wrote:
>
> > Sometimes, it is useful to be able to link directly to the blob plain
> > version in the latest tree. This patch implements that.
>
> By the way, how to download binary file, like for example image, via gitweb?
> blob_plain doesn't give correct file after Save As (in the case of image,
> it is not recognized as such)...

This is also a gitweb fault which always define document as plain-text
instead of correct MIME.

-- 
# Beber : beber@gna.org
# IM : beber@jabber.fr
# http://guybrush.ath.cx, irc://irc.freenode.net/#{e.fr,gentoofr}
