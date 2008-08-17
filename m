From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2008, #04; Sun, 17)
Date: Sun, 17 Aug 2008 13:44:05 +0200
Message-ID: <1a6be5fa0808170444n74e498eob800ade8de79cbe@mail.gmail.com>
References: <7vej4o6j40.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 13:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUghB-0004qU-HK
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 13:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYHQLoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbYHQLoJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 07:44:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:55177 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYHQLoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 07:44:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1399872fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aJ7M/oNwkOUZOduc/6YnYtllo98uYZHNz8IFpJ5iBNw=;
        b=Sa7IqY2yZNqtD9/K3oHtu96EZw1F+nLz0lnXKqlEck34XJRL7JR5pIfextFvfJx/hl
         O5HPIwqujhkvWE1qhRzehUe+n+GhUGmjXkvwBTWwmBj08ayWJhUWf6JUhpu4J0TPLA7r
         hzIEXHve+mgkrO8pITPSWB0c5fORstMSy55m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B/jmiB5E1l93kO1n/X+YyCU6vBKIW8CYi8ImYBGKZ/vf9YKmjbyzNy7sS8v6aausqL
         mBUXyE21BEnHkHALslbChNDIP2BoNn/LQR1gi3FXIDTLeHt+xfG60drbDhNu6FHcft3X
         rIlKWN1eOvFSbkyTjzZZ6Rbsbf555PWeQBLMc=
Received: by 10.86.87.5 with SMTP id k5mr3655091fgb.59.1218973446012;
        Sun, 17 Aug 2008 04:44:06 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Sun, 17 Aug 2008 04:44:05 -0700 (PDT)
In-Reply-To: <7vej4o6j40.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92600>

Hi,

On Sun, Aug 17, 2008 at 12:17 PM, Junio C Hamano <junio@pobox.com> wrote:
> [On Hold and/or Cooking]
>
> * ak/p4 (Thu Aug 14 23:40:39 2008 +0100) 14 commits
>  + Utilise our new p4_read_pipe and p4_write_pipe wrappers
>  + Add p4 read_pipe and write_pipe wrappers
>  + Put in the two other configuration elements found in the source
>  + Put some documentation in about the parameters that have been
>   added
>  + Move git-p4.syncFromOrigin into a configuration parameters section
>  + Consistently use 'git-p4' for the configuration entries
>  + If the user has configured various parameters, use them.
>  + Switch to using 'p4_build_cmd'
>  + If we are in verbose mode, output what we are about to run (or
>   return)
>  + Add a single command that will be used to construct the 'p4'
>   command
>  + Utilise the new 'p4_system' function.
>  + Have a command that specifically invokes 'p4' (via system)
>  + Utilise the new 'p4_read_pipe_lines' command
>  + Create a specific version of the read_pipe_lines command for p4
>   invocations
>
> Warmly received by the primary contributor of git-p4; I do not mind
> merging this before 1.6.0 (final call for "Yays").

I've tried these for a few days now, and they work fine for me, so FWIW: Yay!

-Tor Arvid-
