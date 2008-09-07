From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 3
Date: Mon, 8 Sep 2008 01:07:50 +0200
Message-ID: <2c6b72b30809071607m69148ec0mc9d0925e24bb7b7e@mail.gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
	 <200809060422.34779.jnareb@gmail.com>
	 <20080906051530.GB28035@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:09:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTNM-000382-2x
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYIGXHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbYIGXHx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:07:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:18575 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYIGXHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:07:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1327467wfd.4
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 16:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0OCnjPCD8CxccBDjzfvcL44UldZGmvHkfA5jHKGow9M=;
        b=Dsj/PS5rPkGfq0//XuobJu1BaRMElkgBZZK4uiaYJPy7ojx+3lQhRC/SnNEr5vMXzf
         HvxpWvCFxLquhUCPQpS/4cL86xeFKBFwITWk3j/Kl8YYY4nIjHm+oGrZROWq9dPw7JU+
         Q9Z3RkVy76zRr7m2Qjxhn+euyd/954Tlle7oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=R2QG4C1o2DwEOUY3m6vwMy9bPsnhnYX6EyE3Z3yX2UA3BFBk3LNbPTvBzWKE73yRuj
         0INPHzT19YSRrAgw+KNQ7FjV2oJvJQtoOA+nu+k8tnioMuUXJxZI0oPaynNvtJTnQxFr
         boGvnGBSGL7GwpfbdwxelCypAffYEh4xZOm9A=
Received: by 10.142.240.9 with SMTP id n9mr4977665wfh.136.1220828870982;
        Sun, 07 Sep 2008 16:07:50 -0700 (PDT)
Received: by 10.142.200.15 with HTTP; Sun, 7 Sep 2008 16:07:50 -0700 (PDT)
In-Reply-To: <20080906051530.GB28035@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95189>

On Sat, Sep 6, 2008 at 07:15, Shawn O. Pearce <spearce@spearce.org> wrote:
> Actually, I'm rather excited by what's going on in the Git IDE
> space these days.  The NetBeans plugin is seeing more activity,
> and since GSoC so has EGit.  Both projects have been steadily
> picking up contributors.  Quite a good thing.

One thing that I am wondering about is how to best integrate the
various git-specific traits. NetBeans already has several VCS plugins,
many of which are derived from the same code and have been built to
abide to the same UI design principles, and so naturally they have a
similar "feel" to them. It seems foolish to not try and respect this
when integrating git into the IDE space. Especially, to make it easier
for people to try out and switch to git.

One example is the question of how to enable users to work with the
index without adding too many obscure UI elements. NetBeans VCS
infrastructure and diff engine automatically annotates, which lines in
the editor has been changed, modified, or deleted, and allows users to
revert on a chunk level. While it seems very practical to extend the
annotation bar to allow changes to be staged (I am not sure if this is
even possible) it could end up cluttering a concept that many users
are already very familiar with.

I am curious what kind of considerations you have done on this topic
in your work on EGit.

-- 
Jonas Fonseca
