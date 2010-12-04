From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Splitting up a repository
Date: Sat, 4 Dec 2010 14:09:15 +0700
Message-ID: <AANLkTikqnnOLN=asPUKK0zYxYK9VWXcZPBPtwMZ3z-cr@mail.gmail.com>
References: <4CF9D15D.7090001@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Evan Driscoll <driscoll@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Sat Dec 04 08:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POmL5-0001dP-Uh
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 08:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0LDHJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 02:09:47 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57947 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0LDHJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 02:09:47 -0500
Received: by wyb28 with SMTP id 28so10253991wyb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 23:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Jm70wBgyv6gfa8H6Ra3nFzMvwVrPp2PUYHahAeEEWVA=;
        b=TMJvE0G/VThfPosBug6FRHMZOhof4LnZVSU/dA9CP1/xqlnVqvuAgLT+QPdhasRy9h
         R9oH4BHb3FLnf2nqkslqeb+1MPpb9xqF3Xf35bj9Uzu8llDAUCFVN4ofe4b1QyZjFRkQ
         BgUMNYQTNhfoTjpJy9hM4YLuN9n+BY4Ff7BjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UbmLKTSl+XKwUDGIDj8HM7nPFIwHTK6Nq+Nm0NRNNJpWAL8KiAk/Uqdl+Kqhv37QAz
         DFUsm69/NvI7aZIr5TGxXPcCAMsnK8sXvYIJjHHIpDdmeXPDbZOa9/Xlu4PiGHswLwfD
         EfBJuGR2WfmiKOzZV311ObA/S5N0ezSY5yRlU=
Received: by 10.216.179.193 with SMTP id h43mr211351wem.49.1291446585639; Fri,
 03 Dec 2010 23:09:45 -0800 (PST)
Received: by 10.216.167.193 with HTTP; Fri, 3 Dec 2010 23:09:15 -0800 (PST)
In-Reply-To: <4CF9D15D.7090001@cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162887>

On Sat, Dec 4, 2010 at 12:27 PM, Evan Driscoll <driscoll@cs.wisc.edu> wrote:
> Say I have a repo where there are directories repo/foo, repo/bar,
> repo/baz. 'foo', 'bar', and 'baz' are loosely related -- closely enough
> that I put them together initially, but loosely enough that I now wish I
> could check out just 'repo/foo'. Since Git doesn't support partial
> checkouts (a bit annoying!),

Um.. it does support partial checkouts (check out man page of
git-read-tree, sparse checkout section). But you must do a full clone
(i.e. your repository will have bar and baz, even if you only checkout
foo).
-- 
Duy
