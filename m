From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: rsync a *bunch* of git repos
Date: Wed, 11 Jan 2012 10:52:30 -0600
Message-ID: <4F0DBE4E.30401@gmail.com>
References: <20120110211548.GD10255@titan.lakedaemon.net> <201201102124.q0ALOowL026941@no.baka.org> <25207BDC675840DEA94AA2B04D6783BD@PhilipOakley> <7v39bn9onl.fsf@alter.siamese.dyndns.org> <loom.20120111T141805-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 17:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl1Pk-0000Dm-Ks
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 17:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab2AKQwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 11:52:35 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61956 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195Ab2AKQwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 11:52:34 -0500
Received: by yhjj63 with SMTP id j63so409346yhj.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZzQR8OfyRUWt/CAwHhJ0zD1AlgI96sksDYX6xo4CYrc=;
        b=ZG9fZUj++vtD3BfMZEjuFugAZYhewbPY/CFEKj7PHgnmZ2ZwBCGIgJgVSZTSaz3vB4
         VqgO3RJ/EgvwdvF+AJHrq5dQ7AxkW/UkYkVGjFN9hK47cGKp85puvYdhoZ6IzZO4mcg5
         Sr9VoVwrGZPtbffnYbkfl3PZugDW1JCnngmfg=
Received: by 10.236.173.133 with SMTP id v5mr31630463yhl.73.1326300754206;
        Wed, 11 Jan 2012 08:52:34 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id j11sm5340069anl.8.2012.01.11.08.52.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 08:52:33 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <loom.20120111T141805-791@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188373>

On 1/11/2012 7:22 AM, Sergio wrote:

>
> As an aside: git works fine when repos are transferred with rsync, but git packs
> are not rsync friendly nor friendly with backup strategies using binary deltas.
>
All these answers are assuming that your source git repos are quiet 
during the rsync.  If they are not quiet during the rsync then you are 
going to need a more tailored rsync to do things in a certain order. 
See this thread for details: 
http://thread.gmane.org/gmane.comp.version-control.git/168699

v/r,
neal
