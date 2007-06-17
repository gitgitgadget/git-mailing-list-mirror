From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: GIT_DIR question
Date: Sun, 17 Jun 2007 18:34:14 +0300
Message-ID: <f36b08ee0706170834m464ce57dl3fd5b549b23abb16@mail.gmail.com>
References: <f36b08ee0706170829w59979d86i7bf09bc35ff28fca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 17:34:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzwle-0000jW-GP
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 17:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbXFQPeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbXFQPeQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 11:34:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:41429 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbXFQPeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 11:34:15 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1196103nzf
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 08:34:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hm6qPohqBFBw2Dxgr0RnhHz33r0DPB6lbR9TlrKouFXfkZ+HZ31x/98mWNzc+oLHaArPp+PQ3SQm3qzNqBrWf8CHPxixzFN2bonKfVj66rsXP670KkMSSaWmDbU1m1IzBfk1cTsyyJdf2ZzkpwlOvObmmch8NCvXYmZ3E21ooBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VwLOYiRL2oj6e54LanVTu/taun8f4Rw0dkPoKoE9+jUrEHtkZq9nKhtXSAZVSp33Vuxn6wLnTfmvoGWjdQfZ0SbPmUikMwwEKA+zTMtmLO5TiGnbtIDPv7OEeDu5WaQ7uMdDKGqg2GDxi0t9Q2soxzFMqa39o15x9qhIvl54k8Y=
Received: by 10.143.32.4 with SMTP id k4mr249637wfj.1182094454613;
        Sun, 17 Jun 2007 08:34:14 -0700 (PDT)
Received: by 10.143.7.6 with HTTP; Sun, 17 Jun 2007 08:34:14 -0700 (PDT)
In-Reply-To: <f36b08ee0706170829w59979d86i7bf09bc35ff28fca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50352>

I wanted to create cloned repo, but with metaninfo separately from data.
I cloned the repo ( git-clone ~/repo ~/x) ,
then I moved ~/x/.git to different place (mv ~/x/.git ~/git);
then exported GIT_DIR=~/git; then
cd ~/x;
But now 'git status' says 'fatal: runstatus must be run in a work tree' . Why ?

'ls $GIT_DIR'  shows
  FETCH_HEAD  HEAD  ORIG_HEAD  branches  config
  description  hooks  index  info  logs  objects  refs
This is ok, no ?

Thanks
Yakov
