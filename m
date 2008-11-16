From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: Conflict-free merging (i.e. concat) of conflicting branches?
Date: Sun, 16 Nov 2008 22:43:44 +0100
Message-ID: <2d460de70811161343w52a9a4deo7c8d9bb155514de0@mail.gmail.com>
References: <2d460de70811160550g75e50e00gb50d3b2045c460af@mail.gmail.com>
	 <2008-11-16-15-19-47+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: "Samuel Tardieu" <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1pQV-0001Ea-Bg
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbYKPVns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbYKPVns
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:43:48 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:52251 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbYKPVnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:43:47 -0500
Received: by an-out-0708.google.com with SMTP id d40so950811and.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ri3KWR4G4Wjst9J44eqyCVhKkvCu18jcI9ZaGySmw8Q=;
        b=r0d0/JjANM29epj2Y0Vgi8sSvddsWZndSopORTzQRr1UMWbXJxvK54PEkT7w7wqzBW
         02W27UwXJqzhKVyxyNJoZ1iCth4oB6nmEbU9GzX7mYg/QyxMmVeuYpUukPUCZBT4FxuI
         QA8gX7nsufsqKFeYXr4evr2WlLCD3/LK+gVQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Od0vegWe7QgWSWX6Qg7RU9QBYq/gZ8Q6ZHpwV2ZqRf/ZWJivZkoMVZ+SVaQYWeYahR
         2uWX+8+FLcp770PTEGigSPOkxoH2gWb5ZTnZS+8aIlWGOTt28oIPfoTopxz3C2t6qfW4
         uVcafbkFszqV0rjAVa274p56AapOp7NaHqryY=
Received: by 10.100.144.11 with SMTP id r11mr1362378and.24.1226871824844;
        Sun, 16 Nov 2008 13:43:44 -0800 (PST)
Received: by 10.100.43.19 with HTTP; Sun, 16 Nov 2008 13:43:44 -0800 (PST)
In-Reply-To: <2008-11-16-15-19-47+trackit+sam@rfc1149.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101162>

On Sun, Nov 16, 2008 at 15:19, Samuel Tardieu <sam@rfc1149.net> wrote:

> You can use a custom merge driver especially designed for this case.
> See gitattributes(5) man page for an explanation of how it works.

Thanks.


Richard
