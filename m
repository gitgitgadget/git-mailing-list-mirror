From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [announce] text-based tree visualizer
Date: Thu, 6 Mar 2008 21:46:03 +0100
Message-ID: <2c6b72b30803061246j52c005f8nb76df3742776d0fd@mail.gmail.com>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr>
	 <alpine.LSU.1.00.0803061924350.3941@racer.site>
	 <Pine.LNX.4.64.0803061938550.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jan Engelhardt" <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXMzE-0002TS-EB
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 21:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759412AbYCFUqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 15:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759445AbYCFUqG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 15:46:06 -0500
Received: from rn-out-0910.google.com ([64.233.170.190]:13483 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758346AbYCFUqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 15:46:05 -0500
Received: by rn-out-0910.google.com with SMTP id v46so93144rnb.15
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 12:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aIvVY2Zvj5wjE2wvHkOoXnTyyL75eFC8GRDTQAilTL8=;
        b=iFuHJ15AaUqOkK1vh8Ac6WAGXpfoZ3W+2KkeocSBuD6iGmV8oogkRD8p9ADO6qJyO9oWE/fmv+dkTspFx+jYjR9md1i38CJQdQLSvpk1uWARdc65EadsfDFxSoL6NuepgN2KZJdGn+UWez+2A2wgQ3lOniBuKWjJ6CazASm17SU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xnrmrwHVlJjT4dRN3VXwjeAWmAKWvQv6BcBKUJgxFfwcQj6myIrQdeA7w/vUCgGceXCPwwdEL9Z8TsBMl6GhG5SVAdMZ9fvKLdp1CMJkrvbOiujIEce9thSHvsTIUkONYpL15ho2JAIeOJ5jJE4+l0f9pxoQ/Fa5lnhLbnm/sXo=
Received: by 10.140.54.6 with SMTP id c6mr144021rva.37.1204836363098;
        Thu, 06 Mar 2008 12:46:03 -0800 (PST)
Received: by 10.141.163.17 with HTTP; Thu, 6 Mar 2008 12:46:03 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0803061938550.7660@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76421>

On Thu, Mar 6, 2008 at 7:49 PM, Jan Engelhardt <jengelh@computergmbh.de> wrote:
>  On Mar 6 2008 19:24, Johannes Schindelin wrote:
>  >On Thu, 6 Mar 2008, Jan Engelhardt wrote:
>  >
>  >> I spent the last two days writing a text-based tree visualizer; gitk is
>  >> really convenient, but unfortunately it needs an X display, tigs tree
>  >> view left me unimpressed, and I actually wanted a tool that does not
>  >> read all commits in like gitk/tig do, but just gives me the treeview.
>  >>
>  >> Screenshot:
>  >> http://jengelh.hopto.org/other/git-forest.png
>  >> Program (perl):
>  >> http://dev.computergmbh.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest
>  >> Top of file contains option overview.

It looks very interesting and inspiring.

>  Yes, see above? :-) "tig's treeview" - that meant the 'g' key.
>
>  It just uses boring ascii, fails to display octopus merges and
>  'octoups branching', is limited to 'one branch' (e.g. no apparent way
>  to pass --all to git-log/git-rev-list).

I agree to tig's revision graph renderer being boring and very limited.
As for passing --all you need to first pass --:

  $ tig -- --all --not pu

I am planning to change this awkwardness after next release.

-- 
Jonas Fonseca
