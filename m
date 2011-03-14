From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 16:09:39 +0100
Message-ID: <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Franz Liedke <franz@develophp.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz9Pe-00030h-Po
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 16:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab1CNPKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 11:10:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59156 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab1CNPKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 11:10:20 -0400
Received: by gwaa18 with SMTP id a18so1852652gwa.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=kiYdgwO4VI/et/S2qbPhYA5QAYbq4nB8YzBZcR0TIEs=;
        b=VQHhrzdERtgzp6gIkQ43nTuO6snL7SsCkEwdLg57u/QsLDA00H8/fnUl2/Dh5lCmjw
         YZMw8AvD0n1EfVBsFWd2eGlGTIsvg7X1VJvMr1/0D1ETu+4OoePdAG52z4KLpmvDCLrt
         I0YyQirPj5bQdPc+6fyR54nIynJXob2028pgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mcJb0Ch3q8N6/pPBufcwFmRL5wei8/F6C8wLszayv4t2/XYDwIZrOXBnMxIpWY4NML
         RblsG76FiFDwrKPvsp9IHByn88hHz+ne7XQnqZ9DjgfwNJWy7LGzAjqnMmZ09UsCyPY6
         upUJG3yE45FTXv8mg2UzabTSoNjOvqr0g6Tjw=
Received: by 10.150.204.19 with SMTP id b19mr5998088ybg.163.1300115419157;
 Mon, 14 Mar 2011 08:10:19 -0700 (PDT)
Received: by 10.151.11.12 with HTTP; Mon, 14 Mar 2011 08:09:39 -0700 (PDT)
In-Reply-To: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168989>

Heya,

On Mon, Mar 14, 2011 at 14:18, Franz Liedke <franz@develophp.org> wrote:
> I am currently having some trouble with a local Git branch.
> It seems the branch pointer is not updated when I make new commits to that
> particular branch.

You might not be on any branch/the branch you expect. What does 'git
status' and 'git branch ' say?

-- 
Cheers,

Sverre Rabbelier
