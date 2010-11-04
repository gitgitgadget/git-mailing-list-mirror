From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Thu, 4 Nov 2010 02:00:12 +0100
Message-ID: <AANLkTimDyAatzEXGi_q+1+3x5p5SXGaap2Aqwr+d3Nhk@mail.gmail.com>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <7vsjzixty5.fsf@alter.siamese.dyndns.org> <AANLkTin_NuzQocOab+w=B3Ka+n22j2-OXQu8=J6uzByS@mail.gmail.com>
 <201011040149.47968.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 02:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDoC4-0000rJ-5P
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab0KDBAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:00:37 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48362 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0KDBAg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:00:36 -0400
Received: by gxk23 with SMTP id 23so978190gxk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=MIGQ4nTJjOF2T+yHufYPzLvRmemeRNgoYrMcL6U2kJg=;
        b=kdZLYuFMr/WijRzmTa4DCMMfXC9wMSjDh/l2nVornsua/MUD1vIfJHGGK60CuvFrIZ
         01zPqq6kNVFu010JtVrUgz6p4rE9NLKvlOrXbeCTcy81jLideIbBmgOMKUde095IktWF
         JN3wXvkJni7olxhfvgww7Tez9E7yEVfK51VBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZlRf3u3ZmF6eIor+dqgHEVHqIeD8fvsQheFSewfxlsAT7oWyPRUeZ+UvheUfAo5L24
         0pnW80IwuNHhmPaA8cxqJ2qkYE5wxbr44A2iQQoDW97UR67ECuxZyT1rFaOB7URyp+s7
         o/0rD09KXcXGj6sP51Z7KaL6q2vGgPR5dTxww=
Received: by 10.150.206.11 with SMTP id d11mr135100ybg.369.1288832435304; Wed,
 03 Nov 2010 18:00:35 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Wed, 3 Nov 2010 18:00:12 -0700 (PDT)
In-Reply-To: <201011040149.47968.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160659>

Heya,

On Thu, Nov 4, 2010 at 01:49, Johan Herland <johan@herland.net> wrote:
> ...Johan (scrambles for a flame retardant suit)

I for one, have thought about this design, and it's probably how I
will represent refs for hg remotes (for git-remote-hg). E.g.:

* refs/remotes/<some-hg-remote>/heads
* refs/remotes/<some-hg-remote>/tags
* refs/remotes/<some-hg-remote>/branches

So, no retardant suit needed as far as I'm concerned :)

-- 
Cheers,

Sverre Rabbelier
