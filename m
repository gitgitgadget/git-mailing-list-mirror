From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [ANNOUNCE] Gerrit Code Review 2.0.3
Date: Tue, 17 Feb 2009 13:06:14 -0800
Message-ID: <8c9a060902171306w5926c20ej439489de450e04f5@mail.gmail.com>
References: <20090217011256.GA23314@spearce.org>
	 <1976ea660902162311q12e11ec5g7a43ab637186985e@mail.gmail.com>
	 <20090217151838.GI18525@spearce.org>
	 <8c9a060902170813ie8f5bc1gfed53e4f31f64c23@mail.gmail.com>
	 <alpine.DEB.1.00.0902171743280.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:08:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZXAc-0002Wu-Q0
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 22:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbZBQVGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 16:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZBQVGR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 16:06:17 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:33005 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbZBQVGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 16:06:16 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1690009qwi.37
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 13:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6QZKMMRlfDUd7ryHmZdnKnFTJ8hKvix7qtuLeh2pdoY=;
        b=wi3aQDQufokzbP7x9QbVbrAEymc8f/xCj3Xr/+tI6K2+k67Lfu3f1D0z0NustEXGfQ
         +xUGGG5yZbIw1gp+bSqEJw6p7NUHlCjAoO8Tgh6Bu0iWz1A1XaNnfWbMfuzRBSWR5KfI
         wxg67nHAhl39RLIWWYogctnBHd8Cn6rJ7AyGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qSO4kfgYJCElVcz4Bd4NatC55ijS+QC26JjHiFH6rceDstzyCoqYBUNcE0+LllWCuL
         DrJGOOi+tTrmB6g6yYoO7bOWSmmQM/efsZYRQrx39c8Es4TT+ErEtX60fWBHm/EpHO2W
         p49jvqg1A6Qb1Qyjjn2k2KoGgQMSZsLLaGpl8=
Received: by 10.224.28.143 with SMTP id m15mr3894895qac.82.1234904774953; Tue, 
	17 Feb 2009 13:06:14 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171743280.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110452>

On Tue, Feb 17, 2009 at 08:44, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 17 Feb 2009, Jacob Helwig wrote:
>
>> On Tue, Feb 17, 2009 at 07:18, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > Gerrit is known to not work in Internet Explorer.  As an open source
>> > developer, my primary desktop system runs Linux.  My portable laptops
>> > all run Mac OS X, because its shiny.  I have no system capable of
>> > running Internet Explorer, nor do I desire to send dollars towards
>> > Redmond in order to obtain an OS license in order to do so.
>> >
>> > Something is busted in the IE AJAX code used by Gerrit Code Review.
>> > I'm guessing that instead of making the data available to the AJAX
>> > callback, IE wants to save it as a file on disk.  No clue why.
>> > And due to the lack of IE, I am unable to debug the problem myself.
>> > I am waiting for someone who really cares about using IE to debug
>> > it and contribute the patch back.
>> >
>>
>> I've found IEs4Linux helpful for debugging IE-only issues under Linux.
>>
>> http://www.tatanka.com.br/ies4linux/page/Main_Page
>>
>> I don't recall, off hand, if it'll provide IE 7 (and the site isn't
>> working for me right now, so I can't confirm this).  It does provide
>> IE 5.0, 5.5, and 6.0, however.
>
> If I understand Shawn (and the motto "scratch your own itch") correctly,
> Shawn was not so much interested in being pointed to a way of running IE
> himself, but more in people who absolutely want to run IE themselves to go
> and fix the issues.
>
> Ciao,
> Dscho
>
>

Oh, I understand "scratch your own itch", but there's also a
difference between unable to, and unwilling to. ;-)  I wouldn't have
questioned it, or said anything, if it was simply put as: "Known
issue, but we don't use IE, so it's not a priority for us.  Patches
welcome."

(Note: I'm not saying that Shawn should be willing to, just that he's
not "unable" to. I also don't claim to know the full nuances of any
possible licensing issues.)
