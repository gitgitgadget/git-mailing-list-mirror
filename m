From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-svn doesn't fetch an empty directory with svn:externals
Date: Wed, 13 Jan 2010 16:11:02 +0100
Message-ID: <40aa078e1001130711gf602ed4pa68cbeb8ba590600@mail.gmail.com>
References: <loom.20100113T124446-187@post.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michel Jouvin <jouvin@lal.in2p3.fr>
X-From: git-owner@vger.kernel.org Wed Jan 13 16:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV4sM-00068k-AG
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 16:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab0AMPLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 10:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755696Ab0AMPLK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 10:11:10 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:45036 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab0AMPLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 10:11:09 -0500
Received: by fxm25 with SMTP id 25so262962fxm.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=4aTpID+rO5PygA87274rJzW0mjh76jL77Svdn0gQXzQ=;
        b=eKz8Zhf5gVR67OvISbwdusDF+XGU0KTfEEOs+Si0hsyT+wlyjgNNPWIrWP04j/bhe2
         o15MPosJyATBvaJP+y1/XSz+COFwlU5Kpz2A9Z16XFxIy1fCGUKDzmrDzDOUrb9v++JE
         W/U9t5prgvHd3VBouyE2hN8cdR6RikGduI2OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=xTyKKNC+mLE2zC4eswYUvPcOMB6tkbAMRB1E2AS+uXxpj8bGSCBobrs2sp4RIXWGS2
         cAYWFPS0+EagjrVp91yGPQGxM6UaG9kg/BdlxEtobsXlbq8st/vlGa6YEc4NRunj6uKJ
         eyKJc3xGsz2bypB1TkwMGgwHU1fppc4r4EgAM=
Received: by 10.216.85.14 with SMTP id t14mr4206900wee.222.1263395462810; Wed, 
	13 Jan 2010 07:11:02 -0800 (PST)
In-Reply-To: <loom.20100113T124446-187@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136829>

On Wed, Jan 13, 2010 at 12:49 PM, Michel Jouvin <jouvin@lal.in2p3.fr> wrote:
> Hi,
>
> I'm running in a problem when trying to fetch a SVN repository branch that
> contains an empty directory with a SVN property svn:externals attached. This
> directory is missing in the Git repository/checkout. I was unable to find an
> option to have it added. I'd like to get it added to readd the externals using
> the trick described in http://kerneltrap.org/mailarchive/git/2007/5/1/245002.
> Without it, I have to recreate it in git, add it to .gitignore... which is
> painful.
>
> BTW, I didn't find any documentation on empty dirs handling by git-svn. They
> seems to be often removed which is not always desirable. Are they options
> related to this?
>

I don't think this is git-svn's fault, but simply that git doesn't
track directories (just files). I guess git-svn could create some sort
of place-holder files in empty folders, but currently it doesn't
AFAIK.

-- 
Erik "kusma" Faye-Lund
