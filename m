From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Wed, 16 Mar 2016 14:11:20 -0400
Organization: Twitter
Message-ID: <1458151880.9385.1.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
	 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
	 <alpine.DEB.2.20.1603151517590.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:11:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFuq-0001Ni-CX
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934084AbcCPSLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:11:24 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36597 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbcCPSLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:11:23 -0400
Received: by mail-qg0-f45.google.com with SMTP id u110so50227957qge.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8Bt38S0cnspdW7iXWeaLSUB64WxGCBnbJEjORRTcvvc=;
        b=gH1l5l5us7WsgsnEuVmCgc9+jxRl3XEDEiZ8KuAjkDTxAHcwR0VcNYgRV380sF1rPp
         e2uixvjy2fNGvJOCCfengopBzuXCMCm8PKL7DgWUJIX1WRrT01iqfGXbeH+Ab5GzXsol
         hzBkiEnAG/aupE/B3qY4dgqyZA6LmOMvZNbMVCnIciSJduRIZZ+kviHHTLbQikwTejN8
         0LDc8p20nN2AAiskP21zFd0UeJ9LbDDFR86LuWTmWXar5W9fkjcZ7cmgIt19FcYosU/V
         lJFqAifu8zUiYXIJvqamcyfAwpJuDKZKHc0tgjxdwtX8JuACnbkL6++yfW6O1mYSl3k4
         rfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8Bt38S0cnspdW7iXWeaLSUB64WxGCBnbJEjORRTcvvc=;
        b=GQ/efBm6ygXzNa0PlryMx4XSYhZq8MiZ9aTf/PQheFBC2nOtMa8tD9zkyEu+eQe8OR
         jTebJ/iqroxwMBnful+6UuHFveo2lA7eDaHBU4j8s2c6o23pBSUEkqf6PiB/Tp7/dCoH
         1a0dQRJLyqPii+WehiYjbWKXAost7jSv/Zb4lM76/lgC9VhOleZk8XPCrYN8JIAaI/UC
         EOsdTVpWDKt9r5XjtQH+aL+UH50hJI04tpOXnSb17b35Rux/OLocCxfj/lfbxbnk0wtS
         HkNjgrsJuNnYRNksJlLfOMNOJA8a+QbLBAAIVQstN5CYsFVXZXNrSagplPb7MOQom7DW
         b0SA==
X-Gm-Message-State: AD7BkJI/dnfe8FRArlrK1pCGYCIWQigttHl5GmvVsqQR/XHjTPuf/C8tyrfqsF4h9Ujunw==
X-Received: by 10.140.148.134 with SMTP id 128mr7879836qhu.98.1458151882446;
        Wed, 16 Mar 2016 11:11:22 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 5sm2003450qky.21.2016.03.16.11.11.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2016 11:11:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603151517590.4690@virtualbox>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289011>

On Tue, 2016-03-15 at 15:26 +0100, Johannes Schindelin wrote:
> Hi Duy,
> 
> On Tue, 15 Mar 2016, Duy Nguyen wrote:
> 
> > On Thu, Mar 10, 2016 at 1:36 AM, David Turner <
> > dturner@twopensource.com> wrote:
> > > Introduce a new config option, indexhelper.autorun, to
> > > automatically
> > > run git index-helper before starting up a builtin git command. 
> > >  This
> > > enables users to keep index-helper running without manual
> > > intervention.
> > 
> > This could be a problem on Windows because "index-helper --detach"
> > does not work there. I have no idea how "daemons" are managed on
> > Windows and not sure if our design is still good when such a
> > "daemon"
> > is added on Windows. So I'm pulling Johannes in for his opinions.
> > 
> > Background for Johannes. We're adding "git index-helper" daemon
> > (one
> > per repo) to cache the index in memory to speed up index load time
> > (and in future probably name-hash too, I think it's also more often
> > used on Windows because of case-insensitive fs). It also enables
> > watchman (on Windows) for faster refresh. This patch allows to
> > start
> > the daemon automatically if it's not running. But I don't know it
> > will
> > work ok on Windows.
> > 
> > Assuming that "index-helper" service has to be installed and
> > started
> > from system, there can only be one service running right? This
> > clashes
> > with the per-repo daemon design... I think it can stilf work, if
> > the
> > main service just spawns new process, one for each repo. But again
> > I'm
> > not sure.
> 
> If we want to run the process as a Windows service, you are correct,
> there
> really can only be one. Worse: it runs with admin privileges.
> 
> But why not just keep it running as a detached process? We can run
> those
> on Windows, and if we're opening a named pipe whose name reveals the
> one-to-one mapping with the index in question, I think we are fine
> (read:
> we can detect whether the process is running already).
> 
> We can even tell those processes to have a timeout, or to react to
> other
> system events.
> 
> Please note that I am *very* interested in this feature (speeding up
> index
> operations).

I don't understand what a "detached process" is on Windows (I have
never done any real Windows programming). Does that mean "call
daemonize() and it'll take care of it?"  Or something else?  Or should
I just not worry about it and let you take care of it?

Also, I'll figure out how to switch to named pipes. 
