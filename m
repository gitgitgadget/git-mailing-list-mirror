From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git pull (Re: need advice on usage patterns)
Date: Mon, 26 Jul 2010 10:26:35 +0000
Message-ID: <AANLkTikPHARaosHLwaKUqL12va4F7O3WMp1I4LIpu7Mp@mail.gmail.com>
References: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com>
	<20100726033634.GA30877@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 12:26:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdKtN-000485-Ez
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 12:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab0GZK0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 06:26:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36964 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab0GZK0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 06:26:35 -0400
Received: by iwn7 with SMTP id 7so2722189iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LH3FtQXw2aD1WRr4/dMLy6uhQ2RMmz25FQIdh+tbrhg=;
        b=akkAhJjGatNwvOAz9Iebt1vobpqZOiBtvLnHcI8SJEgkgYtCaAKe8aP+7U+DImyk/O
         zX0+zepkmdix33u0S5/muFCwKlq3Hv5Iu2tBzytB1C46wSxs0DvXXxWXdyGmIVsA64c1
         f8VQHl69CX1Q8t+txatuWKQOA3mA3Oz2Q3LgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x/w2Wsj7VBD0Op0snRhKKNAXF5zuMocdjCUdHKI5GduA2ClOOfr+Bm9f+L0j75ywnj
         ezfsYjwGCyD4P5g4IwMxki5aTBpX7h50HS92eQWWE7KH1lZwmclDjcYkhX2XU1/oY96v
         RDLg+RjgQqRU97+yeAJXb7EAR/Lvs1CK5O7m4=
Received: by 10.231.179.24 with SMTP id bo24mr7801244ibb.193.1280139995110; 
	Mon, 26 Jul 2010 03:26:35 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 03:26:35 -0700 (PDT)
In-Reply-To: <20100726033634.GA30877@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151826>

On Mon, Jul 26, 2010 at 03:36, Jonathan Nieder <jrnieder@gmail.com> wrote:

> -'git pull' <options> <repository> <refspec>...
> +'git pull' <options> <repository> <branch>...

Wasn't it "refspec" because git-pull can take args like
"refs/remotes/origin/*:refs/heads/*", not just branch names?
