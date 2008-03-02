From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git diff-index --raw HEAD and git diff --raw HEAD output the same thing?
Date: Sun, 2 Mar 2008 13:24:03 +0800
Message-ID: <46dff0320803012124m415516cbof1f3056773843455@mail.gmail.com>
References: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 06:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVggm-0007JF-Rt
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 06:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYCBFYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 00:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYCBFYI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 00:24:08 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:40849 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYCBFYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 00:24:06 -0500
Received: by an-out-0708.google.com with SMTP id d31so1088924and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 21:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=va2P/C3v4STWiFczbzj4+tYH4tmO9swSFTXtjc0U97A=;
        b=o+R/jrmpLLO6lRne/7rd9vvG7IjLz7GfdI0VxJYK59pmQ+zJpdLw0HXAH1cAwdVwZEiUJG6ug17z60oj2QH2K9SW2H3uPvdgRdCRcRpre0zwOifit5y97DIXFAI2vPht782RDNpd22amB9caJqXQIyJUXtUn7Afaa9Ak0pd4X+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IdDOYXQfSx4BFaMfsrFHDnJNyM+M/1vY5NOWgR8p+vOaWFClZprQAtGOGbImwhRx1TtekzZRjysbjRbuTSKGHp16D5vTmxhdRgyLA0qSlC9qrCl03beJvAS3FlrElLLKxmYgnj4jmbn6msRls8X07nsSBhbp8q4wQf6L33vBWIY=
Received: by 10.100.9.20 with SMTP id 20mr24984607ani.75.1204435443378;
        Sat, 01 Mar 2008 21:24:03 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 21:24:03 -0800 (PST)
In-Reply-To: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75723>

On Sat, Mar 1, 2008 at 9:10 PM, Ping Yin <pkufranky@gmail.com> wrote:
> Does these two commands output the same content except displaying format?
>
>  Follwoing is my test
>
>  $ git diff-index --raw HEAD
>  :160000 000000 ad1e416e87dc02617de68c41bb18e5abf0e24729
>  0000000000000000000000000000000000000000 D      WordBreak
>  :160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
>  0000000000000000000000000000000000000000 M      commonmake
>  :160000 100644 c517f783d9efb5a8d24f80fb67f644a39afec2a6
>  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 T      util
>
>  $ git diff --raw HEAD
>  :160000 000000 ad1e416e87dc02617de68c41bb18e5abf0e24729 0000000... D
>   WordBreak
>  :160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
>  c1f46b3f10cc041e196c388490ddb049dacc7dc0 M      commonmake
>  :160000 100644 c517f783d9efb5a8d24f80fb67f644a39afec2a6 e69de29... T    util
>
>  Strange things is this line
>  :160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
>  0000000000000000000000000000000000000000 M      commonmake
>
>  why mod is 160000 while sha1 is 0000...
>
>  --
>  Ping Yin
>

Any more response? Is this a bug or my misunderstanding?


-- 
Ping Yin
