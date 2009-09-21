From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 11:43:44 +0200
Message-ID: <81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com>
References: <871vm0k6jm.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 11:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpfRI-00051C-9x
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 11:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795AbZIUJnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 05:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755785AbZIUJnm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 05:43:42 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:61309 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbZIUJnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 05:43:41 -0400
Received: by mail-bw0-f210.google.com with SMTP id 6so1806362bwz.37
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jj9zSBzKr/OZlFnyem2yr86AcsZy4KzxR/h/m42HHwg=;
        b=G64dFSVgek08ue1axao4X/V0nf9dtw25lpMpaVD6gnesk4UgC7M7jSHz4ZUUJmXXLI
         t3VsyFQMikhmB2CTemdFxUcxp1N/rGpvuikTNYBqKVb4fyl5+nGUlHSqY6yX3ttjmB4I
         NEx3CaNWJsnZYs3o3IqKN4AfYlTIbUGaJs1L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ygz1GXvhYS6XtwyDc7oJEprVOVR0C8sfqI4QvfWHlQOfwDZHQZmY5hv/6VrE0c91GF
         5G2OhXyq/rFDrBH1ioGgRbrlcBizs7kRHIQhvNjk/+DunkaImNHPDMRiz9+Uhq9v0Ydt
         nPbIyUtvvZ3sL5HHLx53+BnTB1rg3JcxBMEk0=
Received: by 10.204.20.138 with SMTP id f10mr4082686bkb.212.1253526224812; 
	Mon, 21 Sep 2009 02:43:44 -0700 (PDT)
In-Reply-To: <871vm0k6jm.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128873>

On Mon, Sep 21, 2009 at 11:09, Jim Meyering <jim@meyering.net> wrote:
> However, if the use of [] is deliberate, because git still
> cares about portability to ancient SYSV versions of tr that
> require that notation, then let me know and I'll undo that part
> of the change and add a comment to that effect.

We have (had?) people trying to support Git on HP-UX and SunOS.
Do these count?
