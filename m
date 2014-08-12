From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Error "fatal: not a git repository" after auto packing
Date: Tue, 12 Aug 2014 18:11:22 +0200
Message-ID: <1407859882.17965.1.camel@spirit>
References: <CACZXET_qPzBtqJLXBbou+iZ_Muj=VqCBe5qMADN72VScsuHRVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Luke Campagnola <luke.campagnola@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 18:11:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHEfb-0001ul-W1
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 18:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbaHLQL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 12:11:27 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:53211 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbaHLQL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 12:11:27 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so10079046wgg.19
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 09:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=x6Z1H7HxnFmBkWk0buMUMsL7SYdcQ6ZDqN69FtgUwB0=;
        b=lBW8oSwya1/tmaMXYiIkFbNxd2ZhKrYglXfGM//heQkSd2OFBtvxkDLJIhYCUWsntK
         9IMekJ4nRE5cVoKACxKO4HDBZfIBqDGxcRXODUjy9fZGts+Uy5e35q7ivalBB2dndnIC
         zlCrmfazCZw8ERzSA0aEw3p8iWqNP64nYCWH3HPPqNHl47JB9qKfPn02fI54l/sO0NbF
         fwwVORLaz6PKayK1mWcazQdm6upLr6Xgg4hbwXU/tbkbYk4TXJzKI90mhErm6CqtBxR5
         Vpk/fxZYwMkLN8Y5x5hYefOFEpyqjvoEswGI555tMIlhDxsnu2lNarfZnsOfdK17P2xz
         BIBg==
X-Gm-Message-State: ALoCoQnRli9nBEhAM0qsmDVD/IObev5JOXHuHTmPDHa4GFAZ7/Kw7clj/XLiF1SNcMhKwqELkmZ7
X-Received: by 10.180.39.73 with SMTP id n9mr33532797wik.70.1407859885231;
        Tue, 12 Aug 2014 09:11:25 -0700 (PDT)
Received: from [10.42.1.3] (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id fb12sm10154342wjc.43.2014.08.12.09.11.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 09:11:24 -0700 (PDT)
In-Reply-To: <CACZXET_qPzBtqJLXBbou+iZ_Muj=VqCBe5qMADN72VScsuHRVQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255152>

On ma, 2014-08-11 at 18:56 -0400, Luke Campagnola wrote:
> 
> raven:/home/luke/vispy (transform-cache)$ git checkout master
> Switched to branch 'master'
> Deleted 103 .pyc files
> Deleted 11 empty directories

This looks like you have a local post-checkout hook that deletes empty
directories. Fix that hook to not do anything in .git and it should be
fine.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
