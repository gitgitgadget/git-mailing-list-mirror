From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: Committing with past date?
Date: Mon, 1 Sep 2008 12:02:35 -0700
Message-ID: <f9d2a5e10809011202v418a71cbw489c58fdf468c940@mail.gmail.com>
References: <1220179469.5518.5.camel@magnus-desktop>
	 <m34p51qvzv.fsf@localhost.localdomain>
	 <1220286321.5474.6.camel@magnus-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Magnus Hjorth" <magnus.hjorth@home.se>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaEgi-0000uP-De
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbYIATCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYIATCi
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:02:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:21211 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYIATCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:02:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1420117waf.23
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lj4VezBWHTQGFkOLEdhG1ukg+s54hqI6OjS8RzpxH1c=;
        b=URjMx70Ns9cwll3TSDL4TO8dZuXX59a1xXCJWkVaPVFloaGDy3ve7u2AMp99QP8Ky+
         EYmxKUpFXK9rq+hPmwovx9ITBAlt+1809k9skHv8l8S87ipbDA8IjJSCFd7UAflIiHBA
         cGJd1FW+U4uqHggve0L741SxFerO2yC4IJTE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kJl4pTCVe1lRa9f6BadsHEo2m0C2T4EUp9ctN75KedIkVHYJU5FhALFeyFU9Egopdm
         wQt70hbIUeEXpj+SOWAN7xIpq0lb89OGdK4F/jxN0CobcLTfekwAZ20ui/G5GsoyJ7gb
         yb5205Dvudh5oI5tZg7nnctl/dsc9SYh0ZXzs=
Received: by 10.114.15.1 with SMTP id 1mr5500934wao.184.1220295755890;
        Mon, 01 Sep 2008 12:02:35 -0700 (PDT)
Received: by 10.114.148.17 with HTTP; Mon, 1 Sep 2008 12:02:35 -0700 (PDT)
In-Reply-To: <1220286321.5474.6.camel@magnus-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94598>

On Mon, Sep 1, 2008 at 9:25 AM, Magnus Hjorth <magnus.hjorth@home.se> wrote:
> Thank you Jakub!
>
> Forgot to look in the main git manpage, and that variable wasn't
> mentioned in the git-commit manpage or in any FAQ..
>
> Now I have a more tricky question.
>
> The first part of my application history (the stone age) was maintained
> manually using tarballs, but the second part was maintained using CVS
> (the dark ages).
>
> I have successfully imported the CVS history using git-cvsimport, but
> now I want to add these older revisions that were made with tarballs to
> the same tree, before the CVS revisions. The last tarball and the first
> CVS revision have identical content, and I would like to somehow "glue"
> the histories together.
>
> Can this be done?
>

I think you want git filter-branh --parent-filter ...
