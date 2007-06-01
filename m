From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Fri, 1 Jun 2007 09:35:34 +0200
Message-ID: <81b0412b0706010035s5fc38dc6y6f985675cc3c069@mail.gmail.com>
References: <20070531222313.GA12204@steel.home>
	 <7v4pls1qjv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 09:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu1fk-00062o-DM
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 09:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbXFAHfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 03:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760262AbXFAHfi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 03:35:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:8490 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbXFAHfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 03:35:38 -0400
Received: by wr-out-0506.google.com with SMTP id i21so403231wra
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 00:35:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fFa513YhrIPu/IneGSq+2GJNJwychgflrg53hkY57VbLhDw9+VqNHlpe0MXDndGEI+zEE1SdKCJNzm0wigKQSdzK2rDI9pfbV54aRAMgUuYzckh0OgBnlPkfnHiPxBI5Zd+urnIA67Vhnrv/jY1Kuzi9NegSUrgDsDL01ij+Qvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JdKpgJuLwbVQulVr9WkjN4MKk9dFUpc9VIomWW0pwvTTBljTDCyC2tbAb/Jp59YEISMNrbzYUFGE5mP25ac9yknY+61UJNw9JAH7g5uysS5QlyeoUHuRwFGx1o0iT+87egOwlGIJCXzwNLjkOrSYRf1TFr1HMcdQqu2Ph4pLITU=
Received: by 10.78.188.10 with SMTP id l10mr1038714huf.1180683334690;
        Fri, 01 Jun 2007 00:35:34 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Fri, 1 Jun 2007 00:35:34 -0700 (PDT)
In-Reply-To: <7v4pls1qjv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48847>

On 6/1/07, Junio C Hamano <junkio@cox.net> wrote:
> This would not even let you see what got installed.  At least,
> less verbose compilation step we have these days lets you see
> what is being built.  I certainly would not object if the output
> would look like this, though:
>
>         MKDIR -p /usr/local/bin
>         INSTALL git-foo
>         INSTALL git-bar
>         ...
>         INSTALL templates/description
>         INSTALL templates/hooks/post-update
>         ...

As I said, it did _not_ look like an improvement (I actually
did that first). There is just too much information to be printed.

I'll send that first patch, with every program on its own line.
