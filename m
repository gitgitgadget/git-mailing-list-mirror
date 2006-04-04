From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add git-clean command
Date: Tue, 4 Apr 2006 11:17:19 +0200
Message-ID: <81b0412b0604040217s3b8863d3w1b79400c42ca2b90@mail.gmail.com>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
	 <20060404082002.GJ4663@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Pavel Roskin" <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 11:17:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQhfA-00011R-Js
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 11:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWDDJRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 05:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDDJRV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 05:17:21 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:53346 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932376AbWDDJRU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 05:17:20 -0400
Received: by pproxy.gmail.com with SMTP id f25so1599810pyf
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 02:17:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DaFFxGcBk/eWzNJlGDC4WjZ8dh3+L0NPoiLEcamjgjPHSo/HxAI58+CFL1lMv/Dwsy37Gcs6vPFD7i7Yi7CpemIx8y2caV61HSZYkyk7961qvpyETmycB/OlGFksvDzoitdxYYzr1cxx+OGMeYsRxC0NgBiLYtaXXil7xjDb+6U=
Received: by 10.35.96.11 with SMTP id y11mr740094pyl;
        Tue, 04 Apr 2006 02:17:19 -0700 (PDT)
Received: by 10.35.41.18 with HTTP; Tue, 4 Apr 2006 02:17:19 -0700 (PDT)
To: "Martin Waitz" <tali@admingilde.org>
In-Reply-To: <20060404082002.GJ4663@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18380>

On 4/4/06, Martin Waitz <tali@admingilde.org> wrote:
> What is the use case of cleaning up all untracked files without also
> cleaning ignored files?

Thinks of git's .gitignore: it has config.mak in it. Are you sure you want
"clean" your build customizations?
