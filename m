From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Re*: AW: Getting the full path of a conflicting file within a
 custom merge driver?
Date: Fri, 5 Jun 2015 10:07:06 +0200
Message-ID: <CAP8UFD0cJoh2YrxD-Cjr-r37SGDOcy=VafETAN4suxS0HVa6sA@mail.gmail.com>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
	<xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
	<xmqq4mmq3sug.fsf@gitster.dls.corp.google.com>
	<xmqqvbf3t98b.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468839F73@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:07:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0mev-0001Bo-8x
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 10:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbbFEIHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 04:07:14 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34955 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbFEIHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 04:07:08 -0400
Received: by wgme6 with SMTP id e6so50523092wgm.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nMrPMHeQ6MMKmuWXCTC/EvAd5TXwSKeit6rAG6RSJ8A=;
        b=sL6shP/kSQqGDlTuscOU57PFBxay9PQlbpgsTe5TLKut25TgiEM9Yc8DgraF8zirlT
         WEYW6Eb+JLW+zSbvdfeGG58EmF3t/gXCdz9O3lCXaASeu/VqQu3PHEbBy6ksAguXoS+f
         NNZRcNr7g1rFSEgg+wEqsvQ3BFFQgUPGZ6PNl5/SftifNVBMa/VolNIFUAyaQpUyzN5h
         vkiW9y04cBfBoKMzOJ4AL5FdbaykPK44w37bEHZEGz7TCBo0ZimpB18UsoS0Wy8a1Myl
         WPFXyYGNyIn2E1SPelvs7hW/VHViM7U6lopEV8NOLsMT+yS6QnaXv1SsztBDuzHmr0bu
         4vhQ==
X-Received: by 10.194.178.227 with SMTP id db3mr4122729wjc.82.1433491627014;
 Fri, 05 Jun 2015 01:07:07 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Fri, 5 Jun 2015 01:07:06 -0700 (PDT)
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D468839F73@DWPWHMS531.dwpbank.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270816>

On Fri, Jun 5, 2015 at 7:56 AM, Gondek, Andreas
<Andreas.Gondek@dwpbank.de> wrote:
> Thanks, thanks, thanks.
>
> One last question. If I don't want to compile Git myself, how long may the pu branch take approx. to get into a next release?

According to:

https://github.com/git/git/blob/master/Documentation/howto/maintain-git.txt

"One release cycle for a feature release is expected to last for eight
to ten weeks."

As v2.4.2 was tagged on May 26, the next feature release should be in
6 to 9 weeks, and will hopefully include the feature you are
interested in.

(Also please don't top post on this list.)

Best,
Christian.
