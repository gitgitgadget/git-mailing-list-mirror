From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Identifying the last push to a reposiotry
Date: Tue, 2 Mar 2010 13:13:09 -0800
Message-ID: <a038bef51003021313j40eb5df3ufd9c6e88d8c2b7c@mail.gmail.com>
References: <27761186.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 22:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmZP4-0005r9-Fm
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 22:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab0CBVNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 16:13:11 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59175 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab0CBVNK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 16:13:10 -0500
Received: by pwj8 with SMTP id 8so416696pwj.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 13:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=bqmgJoc2CxnYvMPJVz0mEkLdMhVNCMm+T16cw0j7nuw=;
        b=dT29/x21x/6X1f+UyVL+WdadrzTFa4xS5FlqYGcT2Hr2mmzQi+2B71CnvBLrydp8rE
         wXVcKTUAU9gZyWUu6CPE9PJAOWe/PCA1f+y9gd4UpQjTkojaVf2cDgfC6ZhFci4h+AT6
         Jil24kTqldnYWAxxibGByV/Od3rMW5oSraFl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZmRR04XYP73zAyOeLGOcHCeYDMQtuHhNTFxqNPwEnQpgjGDEAcTsjcm2+9Qpw5lTI2
         RaCoxGax8O0PMWmJfmJQUozN46UAaPWaP3Mi1TJZuk6NUfLi56oUi4bOXV9xoQ3u2SFJ
         rlkPCiFIE1YdapeGE0V5mBBFcBYJUqbZwwekc=
Received: by 10.115.65.6 with SMTP id s6mr3788172wak.53.1267564389530; Tue, 02 
	Mar 2010 13:13:09 -0800 (PST)
In-Reply-To: <27761186.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141414>

On Tue, Mar 2, 2010 at 1:07 PM, jateeq <jawad_atiq@hotmail.com> wrote:
>
> Hello,
>
> I am trying to list all the modifications to the clone of a repository since
> the clone was last pushed to its original. Is there a way to identify the
> commit id of the HEAD(of the clone) when this last push was carried out?
>
> Thanks,
> Jawad
> --

Something like

  git log origin/master..HEAD

Getting more fancy you can do a 'git fetch' first and then you are
able to see what has been pushed to the remote but not pulled locally
as well.
