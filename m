From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git and peer review
Date: Sat, 3 May 2008 22:03:33 +0800
Message-ID: <46dff0320805030703g68de70edtc0371b2261059827@mail.gmail.com>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com>
	 <18071eea0805030654j42c21212wd1ccf4df42662000@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 16:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsILg-000095-FG
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbYECODe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYECODe
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:03:34 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:11001 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYECODe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:03:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so400749and.103
        for <git@vger.kernel.org>; Sat, 03 May 2008 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2MkzdnIf/r3du7D/BrslyWzDgygE6P+07B/HWp8J6Co=;
        b=sIJ4zQSqxE4cnEnnvwpBLbn4Pd+JG5JvHTjbigLqXRoolI0SM0Wd/G38SYbUXvQOnBg0HdFbk2e7G9Yo4dRpaLNspBaVWITvR9AKsVJLaIy8hGCSA91VqfhTh6GhdsPjdGnybRpvdOvTzIWK2x9toDY07YBDNHcfTltprqN0moY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VlZZhQgbyQ6I0292yj24ZQ1EQUtUNN6zIwx1OnEETgHF2l3fHA8s9g9lmfm2z3koN6LhSyd09uApOARmnOl2Jcom5YsLuNX1RdNZz+SflxU1PDkyWhj1eLMQi3DluipooqKuuJOieRl27tbaXD3lQqhyS3YVbSguSIDaywTC54o=
Received: by 10.100.3.4 with SMTP id 4mr5888992anc.99.1209823413105;
        Sat, 03 May 2008 07:03:33 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 3 May 2008 07:03:33 -0700 (PDT)
In-Reply-To: <18071eea0805030654j42c21212wd1ccf4df42662000@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81088>

On Sat, May 3, 2008 at 9:54 PM, Thomas Adam <thomas.adam22@gmail.com> wrote:

>  Assuming this is enforced either through a template (see:
>  commit.template in git-config(1)), or as part of being added by the
>  committer, then in GIT 1.5.4 onwards there's a commit-msg hook which
>  will do this for you.  Something like:
>
>  test "" = "$(grep '^Reviewed-by: ')" || {
>     echo >&2 "Message must have a Reviewed-by line present."
>     exit
>
> }

Actually, i want a way to rewrite the history or reapply the patch
series and add the reviewed-by line then. Before that, i can commit
arbitrarily without any limitation.

>
>  >  And one question, how to add a "Reviewed-by" line automatically?
>
>  There's an example of that by way of a SOB in the commit-msg hook.

Sorry, but what does SOB stand for?





-- 
Ping Yin
