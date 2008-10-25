From: "David Symonds" <dsymonds@gmail.com>
Subject: From Perforce to Git
Date: Sat, 25 Oct 2008 16:41:28 -0700
Message-ID: <ee77f5c20810251641l4892ff12n7b30667c6fcc903c@mail.gmail.com>
References: <82c87da00810251418y4a6ef1fbgccefb12061535226@mail.gmail.com>
	 <ee77f5c20810251640q4b40d524n7271a0dfa11ebef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Brandon <siamesedream01@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 01:42:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtsmK-0003pY-AF
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 01:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbYJYXlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 19:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbYJYXlb
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 19:41:31 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:28333 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYJYXla (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 19:41:30 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1444884wfd.4
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2YZkpXoVoA0cjZf6lCeg+TB9Lw8xpiYDZFgmQde8tVM=;
        b=oG78dgMS8RHv0FUFQApT3Ms4QoRD0AhwHWUthORvowzypWwMfsqON/NDuOhERxTS/g
         GbLu7eSLfbPb16AgafyiAov5mIKDSTKwDPAEkD1MbRFmx6Kzn3uZV5vwGsf9XZW2OU73
         iMcz8ayIDHtKTwWh3Qylz/5dhcWuFMiXwGUA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gxm1YNQsidwuILvcx8KqXRQfoEC6oLU8FKJR7ET++Eb+Nkjz8WlUi4E/nMact91v/f
         ne1HaUq9Anm465qOFFYpwR568anNY6Lh7RlldG8CdQDSowTSGQT424nuOz+GPSUPBWXD
         8RIPi0cioGxqmE3/afGJCmLxTOS5JB8Rb1/+I=
Received: by 10.143.3.4 with SMTP id f4mr1767503wfi.233.1224978088503;
        Sat, 25 Oct 2008 16:41:28 -0700 (PDT)
Received: by 10.142.170.14 with HTTP; Sat, 25 Oct 2008 16:41:28 -0700 (PDT)
In-Reply-To: <ee77f5c20810251640q4b40d524n7271a0dfa11ebef8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99132>

On Sat, Oct 25, 2008 at 2:18 PM, Brandon <siamesedream01@gmail.com> wrote:

>   I'm trying to make a comprehensive comparison of Perforce and Git
> features. There are two things I currently can't find:
>
> 1) "Who's editing what"
>    It's been documented that git can help developers communicate who
> is editing what at any given time like perforce. (assuming there is a
> central repositry) Has anyone seen an example of scripts to do this?

That's the primary feature of Perforce that kills its scalability once
you get past a few hundred developers; it bloats the metadata too
much. When you're using Git, there's really little point in using it,
since you don't declare what files you are going to be editing, and
you can find out other people's changes at merge time at your leisure
(not just when *you* want to commit).

> 2) Symlinks to checkout partial repository
>   I believe I read symlinks could be used to checkout part of a
> repository. Is this true? any references? I imagine submodules is the
> preferred way of doing this, and "narrow" or "partial" or "sparse"
> checkouts are under development

I don't think so. You could use symlinks to *simulate* a bigger
repository that is actually made up of smaller repositories.


Dave.
