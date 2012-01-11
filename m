From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Intriguing error with Git 1.6.3.1: Too many open files
Date: Tue, 10 Jan 2012 21:09:31 -0600
Message-ID: <20120111030931.GA12862@burratino>
References: <CALjyegUJ+ZY7g0Lpxqs=gvAyhtYW_a3SNWVybSG4EG3X=ROV9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Soham Mehta <soham@box.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 04:04:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkoUW-0002JK-2L
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 04:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346Ab2AKDEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 22:04:39 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46101 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812Ab2AKDEi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 22:04:38 -0500
Received: by ggdk6 with SMTP id k6so130125ggd.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 19:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qo3hv0CEIdIOCUb5gE1v094z1P2/NkYk0c+W1T1KU3E=;
        b=AOdGKZUpd703jZN9T5fbFavtVhCJggxhQiWvJAaQp66ImqteDIFwM3+xqIGVN92Y6l
         cJK472SE09B5l1PaUNmnUCjSizbA1ZCkYlWr3taMVN9nncQ6/3F+mwIjoU8QUrcs8hJG
         V4/CeInEdBA4toptRFqxd144Dg1bJkKzlAgcE=
Received: by 10.236.139.132 with SMTP id c4mr29738073yhj.68.1326251077426;
        Tue, 10 Jan 2012 19:04:37 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r1sm15365353yhh.14.2012.01.10.19.04.35
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 19:04:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALjyegUJ+ZY7g0Lpxqs=gvAyhtYW_a3SNWVybSG4EG3X=ROV9Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188317>

Hi,

Soham Mehta wrote:

> *"error: unable to open object pack directory: ./objects/pack: Too many
> open files"

Do current git versions (v1.7.4.2 or later) behave the same way?

Sorry for the trouble,
Jonathan
