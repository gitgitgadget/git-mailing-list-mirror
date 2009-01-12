From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git diff --stat" doesn't show added empty file
Date: Mon, 12 Jan 2009 13:19:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901121319210.3586@pacific.mpi-cbg.de>
References: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 13:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMLmB-0006sL-QC
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 13:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbZALMSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 07:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbZALMSw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 07:18:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:40799 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751343AbZALMSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 07:18:52 -0500
Received: (qmail invoked by alias); 12 Jan 2009 12:18:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 12 Jan 2009 13:18:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fB+M43Nnfv+UTwX0mfr8n8409ZDVqS9esKzhEmH
	3+CUfjKN55tHio
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105333>

Hi,

On Mon, 12 Jan 2009, Ping Yin wrote:

> $ git --version
> git version 1.6.1.9.g97c34
> $ mkdir test && cd test && git init && git commit --allow-empty -m
> "Initial commit"
> $ touch .gitignore && git add .gitignore && git commit -m "Add empty .gitignore"
> $ git diff --stat HEAD^..
>  0 files changed, 0 insertions(+), 0 deletions(-)
> 
> May be the following is better?
> 
>  .gitignore |    0 +
>  1 files changed, 0 insertions(+), 0 deletions(-)

Have fun coding that.

Ciao,
Dscho
