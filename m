From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [new tool] git-project-version.sh
Date: Tue, 15 Apr 2008 06:55:18 -0600
Message-ID: <51419b2c0804150555i50bcfa98pb6811c14e33f9d3c@mail.gmail.com>
References: <20080415113629.GA17459@denkbrett.schottelius.org>
	 <20080415120507.GB21572@bit.office.eurotux.com>
	 <8aa486160804150501p2f55a3e9g33df94c1d4274e48@mail.gmail.com>
	 <20080415125209.GC17459@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>,
	"Luciano Rocha" <luciano@eurotux.com>, git@vger.kernel.org
To: "Nico Schottelius" <nico-git-20080415@schottelius.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 14:56:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlkhp-0003G6-Me
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 14:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759819AbYDOMzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 08:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764712AbYDOMzV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 08:55:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:62841 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764673AbYDOMzT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 08:55:19 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3134648waf.23
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jMOf3Gov5bTjT5gyeAsEln4+hfuG6HYLGf4AbXvLejg=;
        b=ftv11W81qmVG4a3BGzggVVD0pyuddcX05lJFrQKS623DrrsKBZxhfzjMobriUiGw3cABDOZvqCBJuYfQqzeQCeSyszHSeBQEDqdWFrI+iJU36FkFZmEvlAVIPaVGuWuGTaG7Bb9sqJQhfMNnD8Vvzers3/aTbZvClFKHG25Sd9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V9Dg07u4+v+oXRCt4WBkimJxAI53i8wuCis22LE4+edxQSo87derhlQX49TyHWAgvQJTnR7yC4CoUtHwTWmlQoTCciAcEdGrh/Zdxqs61JnUNDyUmXxiW2aEkD8frWp9NPuRLm9ZnY4Wg3U9HVVgFW+XoIFknrPpxZxqAOzBza8=
Received: by 10.114.110.1 with SMTP id i1mr8129230wac.112.1208264118338;
        Tue, 15 Apr 2008 05:55:18 -0700 (PDT)
Received: by 10.114.73.10 with HTTP; Tue, 15 Apr 2008 05:55:18 -0700 (PDT)
In-Reply-To: <20080415125209.GC17459@denkbrett.schottelius.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79597>

On Tue, Apr 15, 2008 at 6:52 AM, Nico Schottelius
<nico-git-20080415@schottelius.org> wrote:
> Santi B=E9jar [Tue, Apr 15, 2008 at 02:01:06PM +0200]:
>  Luciano Rocha [Tue, Apr 15, 2008 at 01:05:07PM +0100]:
>  > [...git describe...]
>
>  Looks also quite nice, also added it to the blog entry,
>  but it seems to work wrong here:
>
>  The last tag I created on the master branch is called 1.20.3pre6,
>  but git-describe uses pre5:

Is your 1.20.3pre6 tag annotated?  git-describe only uses annotated
tags by default; pass the --tags option to have it consider all tags.
(This caught me be surprise a few times as well.)

Elijah
