From: Saikiran Madugula <hummerbliss@gmail.com>
Subject: Re: [PATCH] Documentation: Fix build failure of docs.
Date: Tue, 28 Jul 2009 17:39:33 +0100
Message-ID: <4A6F29C5.6030608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:39:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVpiL-0000eo-8w
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 18:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbZG1Qji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 12:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbZG1Qji
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 12:39:38 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:56472 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZG1Qjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 12:39:37 -0400
Received: by ewy26 with SMTP id 26so171700ewy.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=5iUdocKbPRJx6CmSuvY4gD00zFPlxpdioSZITvEUiQQ=;
        b=ASYYoJxX0endrplHRwj/suClREjZXGO8USh7ftPffeAu8N2PBmU+FpN3/1wqA6Yrkp
         TiyXluuHtE4SAujgOD3XCRMntwQwyQkNaufwiYftZwru92Y6naIi2PU8fw6qSSIVLrii
         0VuX061O/97rV/ObyuPG78R4uK4Dx3zugOR9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=qsQL88gxI2kWIo1YdlAXtITFonQLUoPK7s7E1SR0K0vbBKL+wEJyYLfzUiFjsT09o+
         Fq/znM/6tQ99tAywKttWHKvbwfjh+rUl9MRIV+circ4PaxaeLKv2+xo8Cve26PDu2Oz6
         DUpN609baZsaM1nQzefoSN136SBD20imE9vhI=
Received: by 10.210.81.3 with SMTP id e3mr10182654ebb.12.1248799175873;
        Tue, 28 Jul 2009 09:39:35 -0700 (PDT)
Received: from ?10.0.11.140? ([85.118.31.194])
        by mx.google.com with ESMTPS id 7sm184395eyg.15.2009.07.28.09.39.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 09:39:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124261>

OOps, forgot to cc vger.kernel.org

Thomas Rast wrote:
> NAK.  Presumably you are using an asciidoc 8.x?  Please check if
> saying
> 
>   make ASCIIDOC8=Yes man
> 
> fixes the problem.  Read the comments in Documentation/Makefile for
> advice on what precise combination of options you should use.  Also,
> if you do not want to actually work on docs
> 
>   make quick-install-man
> 
> is a much less painful way to get manpages (in this case, from Junio's
> 'man' branch that has preformatted manpages for 'master').

My asciidoc version is 8.4.1. Yes "make ASCIIDOC8=yes" seems to have built with
out any problems. Thanks for quick-install-man tip, I should have read till the
end of INSTALL document  :) .
> 
> I put the +++ in there to stop the version I used at the time from
> rendering the closing backtick as part of the URL and garbling the
> entire paragraph in the process.  To be precise, with asciidoc 8.2.7
> and without the +++ I get
> 
>   Clone it with <tt>git clone <a href="file:///path/to/repo</tt">file:///path/to/repo</tt</a>>.
> 
> in the HTML output.  Note the nested tags.  (With asciidoc 8.4.5 the
> problem appears to be fixed.)
> 

People would start using latest versions of ascii doc which has no problems,
wouldn't it be better if the default compile options suit them ? Also, it would
be good if "make install man", would do "quick-install-man" as default to
prevent users from the painful compilation of manpages everytime they try to
install latest git.
