From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 2/2] Fix the geometry when restoring from zoomed state.
Date: Tue, 15 Sep 2009 18:11:41 +0400
Message-ID: <e2480c70909150711h6bd556e3t683c1d1473f9cb58@mail.gmail.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	 <8763bkcsxb.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 16:12:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYlG-0007Rf-IH
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 16:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbZIOOLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 10:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754238AbZIOOLk
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 10:11:40 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46183 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZIOOLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 10:11:39 -0400
Received: by bwz19 with SMTP id 19so2816063bwz.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=TT73+a+huqAPxA5DGUThmvNJoDXDxPP8Nr9xVSYzTt0=;
        b=ZE00BKtycS6RE/b678HGejIX6/cFv3IKZGjFXBkklFO2OpTVoWF/IwlsNduy2GLGj/
         7LJhdXHb44rR24dzhO6z4rk8dtWHk8JMKvppObbnZQYrIp3ysXhN46N72FLummerdlxR
         vTuDewm8C5/cgwNQXQLIwFj6O53iDRvEoNMcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KtmKOnYK7oIfcWZ6lFASW40zW047/obJKztFPs6J+7BEwjtRBuvYBTYFT5wJVVO+ou
         B/5JIGHPn9Qhfdw3hqpJnNgvCtFr9+PJ3/kq+gMOQ+K3LMbCjeF8JlUWa03IdZhTYctB
         t3wbRiwnuTnMDT18AcCigRHlsaLvkMfjLXEV4=
Received: by 10.223.20.85 with SMTP id e21mr2706718fab.25.1253023901831; Tue, 
	15 Sep 2009 07:11:41 -0700 (PDT)
In-Reply-To: <8763bkcsxb.fsf@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128565>

On Tue, Sep 15, 2009 at 1:37 PM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> The patch to handle the geometry of a restored gitk by Alexy Borzenkov
> causes the position of the columns to creep each time the application
> is restarted. This patch addresses this by remembering the application
> geometry for the normal state and saving that regardless of the actual
> state when the application is closed.

I can confirm it works even when the difference between normal and
maximized window are big.
