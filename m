From: Jakub Narebski <jnareb@gmail.com>
Subject: Implementing CSP (Content Security Policy) for gitweb in the future
Date: Sun, 5 Jun 2011 11:03:55 +0200
Message-ID: <201106051103.59541.jnareb@gmail.com>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com> <1307222101.5994.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sun Jun 05 11:04:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QT9Fw-0000hf-Pc
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 11:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab1FEJEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 05:04:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53336 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238Ab1FEJEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 05:04:12 -0400
Received: by fxm17 with SMTP id 17so1937044fxm.19
        for <git@vger.kernel.org>; Sun, 05 Jun 2011 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iPHL9x46QYJE5LPgOgyO5QTtR+tzDF+gLyDiKHbF2J0=;
        b=rSak692TZlRB0aM0SL4dfTONBIR7DNQl6on6yxIEksD9CYGTinKiiQ1KfuhKfO+z1R
         QW6f0mm6OzhCxpWfMZYZPgT9xrU4ocarZ9pPXeQ7o56dkdeUZnazlgOnuha6LiZxTP/R
         WeYXr4dkoPeKxTbevX5Zi+fArzzCjEbcf1RwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=spHnsGLsSAChW4K+Sn8gBu8G4ED5HGKvdXE0rxqXwJUYJbXu3XtV4Thit3xrdGaYrW
         iGtrnh3J84jbMvUJNcE846t8ldNPCWa4XLJoHOyW7gkaIF0AVzMZszuV+tAOlKlPpzou
         /vfYA8HnOISJcxtZFjbTUyuPobQlhrFcSx2JU=
Received: by 10.223.16.136 with SMTP id o8mr944865faa.21.1307264650468;
        Sun, 05 Jun 2011 02:04:10 -0700 (PDT)
Received: from [192.168.1.13] (abva119.neoplus.adsl.tpnet.pl [83.8.198.119])
        by mx.google.com with ESMTPS id e16sm975355fak.41.2011.06.05.02.04.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Jun 2011 02:04:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307222101.5994.13.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175070>

On Sat, 4 Jul 2011, Matt McCutchen qrote:
> On Sat, 2011-06-04 at 10:43 +0200, Jakub Narebski wrote:

> > The fact that it this buglet was present for so long, since its
> > introduction by Matt McCutchen in 7e1100e (gitweb: add $prevent_xss
> > option to prevent XSS by repository content, 2009-02-07) without
> > complaint shows that not many people are using this feature...
> 
> Yes.  Well, I'm still using it, and I found a few mentions on the web:
> 
> https://android.git.kernel.org/?p=tools/gerrit.git;a=blob;f=gerrit-httpd/src/main/java/com/google/gerrit/httpd/gitweb/GitWebServlet.java;h=947fbb423f1f8cf46db9876f4b80c600cdf9ee41;hb=HEAD#l193
> http://ao2.it/wiki/How_to_setup_a_GIT_server_with_gitosis_and_gitweb
> http://www.digitalfoo.net/posts/2009/11/git,_gitosis,_gitweb_on_FreeBSD/
> 
> And there are probably others who did their own custom things (GitHub?)
> before the feature was added upstream.

In the future however it might be better solution for gitweb to implement
(as an option) support for CSP (Content Security Policy), which IIRC did
not exists in 2009, in addition to current $prevent_xss.

-- 
Jakub Narebski
Poland
