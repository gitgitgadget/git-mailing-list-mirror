From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 9 May 2014 09:53:56 +0200
Message-ID: <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com> <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 09:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wifdh-0007GL-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbaEIHyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:54:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46925 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaEIHyg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:54:36 -0400
Received: by mail-ie0-f174.google.com with SMTP id at1so376260iec.19
        for <git@vger.kernel.org>; Fri, 09 May 2014 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QUOgD+P69Mgl4195edd9bFpORdVQBEYNXrXmHTQMyso=;
        b=xxhs7PI+1Gq+sZGqzTsr2xnyMqd4lrk24xK+mM/+fUA7x61PhVQazGoXL+YSeozfz6
         zrRg6NwNvFRcuGSMS0hLMLuFRsxOPux+ZlMOpEBMBIkzlSpXHhDsMMlrdWyRi/oPEERB
         M0NZNy315SY1JiZiTKlTs0pfkyob4HP70gPQVf0dFyTuRqn9Yl1P1ONwtUfikWGMzCWz
         Rt3G85H+xRM6JPRb2c2ba4Xhujs+W/Sa2TZMlNVpPJVwpL0pKnNGR1Ur34TBHbthgxjV
         jovP4qDHI/HIumgaRsDJOFtB56k+OY8HhR0F4FyvLrSuut8y7/yzUKV9cwrgzGQnMLRf
         +YoQ==
X-Received: by 10.50.92.98 with SMTP id cl2mr6204811igb.14.1399622076274; Fri,
 09 May 2014 00:54:36 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Fri, 9 May 2014 00:53:56 -0700 (PDT)
In-Reply-To: <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248527>

On Fri, May 9, 2014 at 2:58 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> No activity since 2010, no documentation, no tests.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/buildsystems/Generators.pm        |  42 --
>  contrib/buildsystems/Generators/QMake.pm  | 189 ---------
>  contrib/buildsystems/Generators/Vcproj.pm | 626 ------------------------------
>  contrib/buildsystems/engine.pl            | 359 -----------------
>  contrib/buildsystems/generate             |  29 --
>  contrib/buildsystems/parse.pl             | 228 -----------
>  6 files changed, 1473 deletions(-)
>  delete mode 100644 contrib/buildsystems/Generators.pm
>  delete mode 100644 contrib/buildsystems/Generators/QMake.pm
>  delete mode 100644 contrib/buildsystems/Generators/Vcproj.pm
>  delete mode 100755 contrib/buildsystems/engine.pl
>  delete mode 100755 contrib/buildsystems/generate
>  delete mode 100755 contrib/buildsystems/parse.pl

Please don't. This script is useful to build with the MSVC IDE, which
enables us to use their excellent debugger.
