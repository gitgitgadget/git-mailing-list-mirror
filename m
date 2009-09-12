From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Effectively tracing project contributions with git
Date: Sat, 12 Sep 2009 21:03:35 +0200
Message-ID: <fabb9a1e0909121203r527bc81ctd68382fc1107bf06@mail.gmail.com>
References: <4AAB9459.3070809@webdrake.net> <20090912185940.GA21277@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joseph Wakeling <joseph.wakeling@webdrake.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:04:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXtW-0007zP-SU
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 21:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbZILTDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 15:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754637AbZILTDy
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 15:03:54 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:38170 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbZILTDx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 15:03:53 -0400
Received: by ewy2 with SMTP id 2so1941921ewy.17
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=tLJVTAvZ3NBWd2zvHJkY8QfH6z/Tu96aLtvpI2qadk8=;
        b=oA2bio1l0Ee0XvguFB5LaAFzJY3lLBu5+uCI2PUIslBrp/Q/P1ClCgr9ki3yVm9aya
         R2Nkk8oq5PbLmJMNCKEeExnZuGxHPminLjOCyLIs0wbL4mb+tRgnOlD0x4KmNxSRCSSh
         0fiJJEwudnoEA6miXzaiWapMBC3oaqSNhGf0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TJRk2+LRZIuA8v3uBVJ3Xc6kRhvYyZ/J8gDs2bwSnLikrj981iLaqLd0r6z/4UpdI7
         X8WsFW7/DrPR/0iCwhWO695318uwpzaqrmi36WKVzvXmsZn3I6G3D7DW5Vjs27gqneIp
         0OMu+3uS3wxI4UO/9RjcgMd+qxOskzfm+u7eA=
Received: by 10.216.1.21 with SMTP id 21mr531201wec.70.1252782236120; Sat, 12 
	Sep 2009 12:03:56 -0700 (PDT)
In-Reply-To: <20090912185940.GA21277@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128287>

Heya,

On Sat, Sep 12, 2009 at 20:59, Jeff King <peff@peff.net> wrote:
> I think it is less a git problem and more of a "how do you want to
> define contribution" problem. The above is just my thinking about it for
> a few minutes. Sverre Rabelier (cc'd) did a "git stats" GSoC project
> last year, but I don't think I ever looked closely at the results or
> what metrics he came up with. But that is probably a good direction to
> look in.

Git stats can aggregate diffs, so it can show you "this author made
changes to this many lines to this file in total", but it doesn't work
across renames. It also has an option to aggregate that to a total per
project number, but I'm not sure how useful that is to your case, as
you seem to be interested in a per-file/line basis? I agree with Jeff
that you'll need to define more precisely what it is you want to know
:).

-- 
Cheers,

Sverre Rabbelier
