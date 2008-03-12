From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v5 2/5] git-submodule summary: show commit summary
Date: Wed, 12 Mar 2008 12:28:59 +0800
Message-ID: <46dff0320803112128j23337873jf1fb12f5716151d8@mail.gmail.com>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
	 <7vabl48tt4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 05:29:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZIb1-00045P-5x
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 05:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYCLE3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 00:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbYCLE3C
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 00:29:02 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:54141 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbYCLE3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 00:29:00 -0400
Received: by an-out-0708.google.com with SMTP id d31so658713and.103
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A/V1CMBA/StrPBKZVm4+F9CwwZBJmQ0u4x/WBUO5EOE=;
        b=Q5+Nl/4Kq2UQhPqYFCMOueeCyVSOEZwb9ypCVhL4TTaAkb/aIeLVlx+RR2WuncR38dtcS7GK2KGdDHvJRk+l0Zqacz2cqKks+/SiYCYEzFcw/NRjhlx83YG5suoWP8iWzpUwXbKdJjovWt2n5KMxxlouWpQKJqO8EVO8jQV3/mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MVWIS/HojQq3iRLkYVL84HeuNDejuRMoQOFY/SfxaYpXatEuZruwtOct25AUUG4mJSakrQVYtypVKE9EG5wmf52heFkUypgad1QS4RSWYbyjxdMx+00lt6xu7bPXod/CIq6fttYaNB1h0DBpp2irFOkasjBL8FBd87lUApJh8k4=
Received: by 10.100.92.9 with SMTP id p9mr7372743anb.71.1205296139781;
        Tue, 11 Mar 2008 21:28:59 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Tue, 11 Mar 2008 21:28:59 -0700 (PDT)
In-Reply-To: <7vabl48tt4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76921>

On Wed, Mar 12, 2008 at 12:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> --- a/git-submodule.sh
>  +++ b/git-submodule.sh
>  @@ -400,7 +400,7 @@ cmd_summary() {
>
>                                 160000)
>                                 sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
>                                 ;;
>  -                               100644)
>  +                               100644 | 100755 | 120000)
>
Are 644 and 755 file permission bit? If it is, how about the other
cases (655, 744 and so on)?



-- 
Ping Yin
