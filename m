From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Is there a way to add a default `--squash` flag for all merges
 into a head?
Date: Tue, 8 Mar 2011 02:29:38 -0500
Message-ID: <AANLkTinmdQ6r8cBDsFjXR+KLGeZR1-yeu7h9R=X0+1PG@mail.gmail.com>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 08:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwrN0-0004QC-Tq
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 08:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab1CHHaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 02:30:10 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42814 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab1CHHaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 02:30:08 -0500
Received: by iwn34 with SMTP id 34so4626234iwn.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 23:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IR99Eu8SEPGbOOBqULGowkM1MoM60Cqo4l8AmkFDhWw=;
        b=dGmCWt/ajx3VesL+ldRz2fLbD38Btwf4j+7riFpXx2Uhrq5tmOddl4YCs7W32mQoP8
         mRupupyG0eJfd0FSLTbHvPg3GQb3Mjdu45ptykeRaTMSE9xTmzx/K5lL5pGwqWTxztpC
         pxXS3/td7OFKshyZM+k9ngVQze6KbT8GEvZus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=K8jXsF8H7P+r56SDpkjNi5OjI3lmUiYacIy2MV97IkS/worO1rJ6xMFFqvaAGaceCn
         AS81FkvAdGGs4Z1K8w4jvtkVBWA/O7r9RCo2nhfQW5LLeeheLiXGju/NiWqeSJ+7jutm
         ZRVgDc3Wjobejs+s8gojsrOrCvBVi4um49d4I=
Received: by 10.231.193.214 with SMTP id dv22mr3705450ibb.157.1299569408198;
 Mon, 07 Mar 2011 23:30:08 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Mon, 7 Mar 2011 23:29:38 -0800 (PST)
In-Reply-To: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168636>

On Mon, Mar 7, 2011 at 2:28 PM, Dun Peal <dunpealer@gmail.com> wrote:
> There's a configuration feaute `branch.<name>.rebase` for specifying
> that all merges into a branch (master in this case) would be done by
> rebase, so I was expecting a similar feature for always squashing back
> (since some developers may forget to add the flag). Unfortunately, I
> couldn't find it. Does it exist?

Try:

  $ git config branch.<name>.mergeoptions --squash

j.
