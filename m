From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [UNSTABLE PATCH 03/19] Allow programs to not depend on remotes 
	having urls
Date: Fri, 30 Oct 2009 05:24:03 -0700
Message-ID: <fabb9a1e0910300524x105f49efr51a295c7c0069258@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-4-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300157170.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 13:25:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3qWs-0005ik-BA
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 13:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbZJ3MYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 08:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755311AbZJ3MYT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 08:24:19 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:47784 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbZJ3MYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 08:24:19 -0400
Received: by ewy28 with SMTP id 28so2926979ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=QzEIgY2qliXUw1/ZwktAc1IGfQi4Uwpy3I6WSub3iBI=;
        b=CVzrKBczlb8lYgDq+WRkmKGhC0mHmyjxHBEncBJSKV5G9/N5gsC6PWnSTA+eg69WYq
         0RnInSKclq+WSf/EljISGapikq5/qEM+NXlEPj2afAIEsjsQUsfpbn/xUt13w3D//1Xo
         JERA1xiAkNTjQOk+sXCsVPIiCF2qmJIULE5LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WE0TVJsNEhBVfqDafFRzg6c6NRsd6xDjnoBFsw26btJj/07nxfcFwJj8bNy6tFu6q6
         orqc4yNecxUXzZMtbtXrFe+9zmMYCW3B9ltrSZEvRgz1lT507W72XhImM0ejbxaAI3CM
         SJQegiNWjza35mLh2456q6s1po7/hEEMokMPQ=
Received: by 10.216.93.12 with SMTP id k12mr518131wef.195.1256905463191; Fri, 
	30 Oct 2009 05:24:23 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910300157170.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131698>

Heya,

On Thu, Oct 29, 2009 at 23:02, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Perhaps I should try to get the refactor in
> builtin-push to use push_with_options() without any behavior change into
> master ahead of the rest of this series.

I think that's a good idea in general :).

> Anyway, you correctly understood the intended change here.

Ok, nice.

-- 
Cheers,

Sverre Rabbelier
