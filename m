From: Matt Graham <mdg149@gmail.com>
Subject: Re: Git setup for kernel in-house development + mainstream 
	submissions?
Date: Mon, 2 Feb 2009 23:13:04 -0500
Message-ID: <1c5969370902022013l7c0b3619ue1de39c6d8a13563@mail.gmail.com>
References: <49861363.1000104@aster.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: PaV <pav@aster.pl>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUCgO-0001dN-LV
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 05:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbZBCENJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 23:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbZBCENI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 23:13:08 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:64681 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbZBCENG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 23:13:06 -0500
Received: by bwz5 with SMTP id 5so1672653bwz.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 20:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+z5vAoFwUcJVI1gs0HMkc7DzvEqEc+E4l21uQuQ8Soo=;
        b=xQjX/Ap+t5zgaz1XLN9f5zvIhvwSESJH+62x+nj6T1F63KMRvV1jzjHB3hAUZxuwLf
         fZ4otmukCz15OP/YcNSGdnC8tU2OnEcuacKTaLWa/z+vKqQiREf88bYBGEtoKGiNMov1
         aIK0mDGND35ybLb3QxKcNfLcEq/7VWq3Ts7qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XLZ9Zi5uX0OKRjLv72bY94vz4YpZDvMQvMLt9GARe4JYtQczEYv8BXmEMUhZ3wkzlj
         3CQFlMT/cuOqlf/B2/hOys2VgT3jzE+44wbvu1rnbwOs3/eYsh9x3WoOE4z5GeQHJv4j
         NVpxZf6jHInEl2P/cfajxsvZIbZ1s/p25KamE=
Received: by 10.223.113.3 with SMTP id y3mr1423971fap.71.1233634384343; Mon, 
	02 Feb 2009 20:13:04 -0800 (PST)
In-Reply-To: <49861363.1000104@aster.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108138>

On Sun, Feb 1, 2009 at 16:25, PaV <pav@aster.pl> wrote:
> I would like to kindly ask for suggestions how to setup and use git in a
> company that performs in-house kernel development (drivers mostly) for
> its own devices and would like to occasionaly submit patches for mainstream.
>
> 4) a simple way to select changes (which may be as small as only parts
> of any of the drivers), format them and submit for upstream merge.
> Preferably, if possible, prepare those series of patches and store them
> for later use (immediate submission might not be possible and might not
> be done at all).
>
> (4) - now this is hard.
> The main problems are how to create, how to diff and how to manage those
> patches (stgit?) and what to do when mainstream gets updated, etc...

When you decide what to prepare for an upstream merge, it sounds like
what you'd want to do is make a new "upstream" branch and cherry pick
the changes you want onto it.  You can use git cherry-pick -n to clean
them up or squash them together if necessary.
