From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig] [PATCHv2 0/3] log: colour the diffstat
Date: Wed, 16 Apr 2014 20:52:47 -0400
Message-ID: <CAFuPQ1L=iW+kWXZ41BDKXzyMH0Ci87_qi79FCm14juiK=Qfh=A@mail.gmail.com>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in> <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Thu Apr 17 02:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaaZm-0004AA-RY
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 02:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbaDQAxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 20:53:09 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57700 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaDQAxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 20:53:08 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so13309192obc.13
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 17:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HKrhw/CW9pd3bep39HvLb8yFd7NCy8RrgY84xaPcod4=;
        b=ZP1ghwesKuTWuesZMg2swbtsMOWqo8BImnwRUoPvgvPUrB9slLFp6CRZ6lwxtLuRZo
         81nZ2zSKZlPew2sqErrVv/cjirQjL+E3LWVLtFMqk2oQjqqt/RDxSp9pwsr/+Wzf2DBM
         Svzy3OXfQrzsCSzrVsUBUXH5Isbealu6v054erQugPiNTQs0/pNEiCYNpjwlHP9p9j7k
         qhCrEgsAG/q1dnt00TX6adOqQUOjdLP4BiloarDzguh9BQ5L3kAPzGH3pwuDIkwWbQa2
         Nje++x9nNykU49jcECyvjZUg9S0AqjyURafUntUcK+Lspc7A7lxlZdpA7XbQtRb7CHc6
         8YxQ==
X-Received: by 10.182.225.137 with SMTP id rk9mr4510360obc.51.1397695987736;
 Wed, 16 Apr 2014 17:53:07 -0700 (PDT)
Received: by 10.76.8.3 with HTTP; Wed, 16 Apr 2014 17:52:47 -0700 (PDT)
In-Reply-To: <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246396>

Hi Kumar,

On Sun, Apr 13, 2014 at 5:54 PM, Kumar Appaiah
<a.kumar@alumni.iitm.ac.in> wrote:
>
> These patches add colourization to the log view. They reuse the diff
> stat drawing functions from the diff module directly.

This is a great idea. I wonder though if it would make sense to put
this into the pager backend instead so all pager based views can
benefit unless of course the "state machine" would end up becoming too
complicated.

> This version just includes some code reformatting and minor
> fixes. Please comment on what other fixes could help.

See my other email regarding fixes. Since I am currently refactoring
how views are drawn I'd prefer to postpone merging this patchset until
the dust has settled. I'll try to rebase the patches once I get there
before reaching out to you.

-- 
Jonas Fonseca
