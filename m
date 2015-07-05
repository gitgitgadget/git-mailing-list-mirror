From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Sun, 5 Jul 2015 18:01:09 -0400
Message-ID: <CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@gmail.
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 00:01:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBryZ-00074H-My
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 00:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbbGEWBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 18:01:11 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:32777 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbGEWBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 18:01:09 -0400
Received: by ykeo3 with SMTP id o3so12921038yke.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=E+ovml5LA9cNz6dhtB+8nXmxH6KVsmGhqiE5BMz3y9M=;
        b=vomG/2ERV1P8mAHzlpnwnI7A5Dydd9KpdJS9Z0cccV/69K4IyCYzKeTeKDCv5Auk2t
         KffiSuKQvGelZX7W/fMYPehjA+aVVB6nNoDHA5ZknbllukHjpzPKWpAubFqUaano6CNi
         m/Weoq3nPVLELHD4+MTdbRlHR5nfKUxFJtZ++mxq4FW6MH/Xs6Jv7VcZQHrv+v6XcV15
         99QnqTU5UIyiMXQ2jtHe4rAbz9RbHSU84pO2019lmM+pMIEBIMDpimSxOXTbPsbwv0+f
         Vc7T015uVBxO0oKg3Zu1EBXyZwsfnkgnWbLYrwtQ9JoOafF55+M5I3Q/pEDo1Bcxt8WH
         PahQ==
X-Received: by 10.170.97.9 with SMTP id o9mr55632128yka.84.1436133669126; Sun,
 05 Jul 2015 15:01:09 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 5 Jul 2015 15:01:09 -0700 (PDT)
In-Reply-To: <CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
X-Google-Sender-Auth: BngqKX6MbUsipOQK9rtXGLx13FQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273373>

On Sun, Jul 5, 2015 at 5:13 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Jul 5, 2015 at 9:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Jul 05, 2015 at 01:13:57PM +0200, Christian Couder wrote:
>>> A draft of Git Rev News edition 5 is available here:
>>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-5.md
>>> Everyone is welcome to contribute in any section...
>>
>> I'm not familiar with the criteria for deciding what merits mention
>> in the newsletter. Is the recent introduction of git-worktree and the
>> attendant relocation of "add" and "prune" functionality worthy?
>
> Yes, I think it's really worthy, thanks a lot for contributing this
> very interesting article!
>
>> If so, perhaps the following write-up would be suitable?
>
> Yes, I changed a few things to make fit better with the rest of the
> content, but otherwise it looks great!
>
> I created this PR to discuss the changes I made:
> https://github.com/git/git.github.io/pull/85

Thanks, for incorporating it. Unfortunately, the non-ASCII characters
in Duy's name got corrupted, and the botch is present in the patch I
sent. Sorry. Not sure how that happened. Can you fix it locally?
